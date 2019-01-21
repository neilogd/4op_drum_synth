#if defined(WIN32)
#define NOMINMAX

#include "opl3.h"
#include "opn2.h"
#include "imgui.h"
#include "params.h"
#include "utils.h"

#define PROGMEM

#include "midi_instruments.h"
#include "factory_settings.h"

#include "nukedopl3.h"
#include "portaudio.h"
#include "portmidi.h"
#include "teVirtualMIDI.h"

extern "C"
{
	#include "ym3438.h"
}

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

#include <atomic>
#include <deque>
#include <cmath>
#include <cstdio>
#include <future>
#include <mutex>
#include <vector>
#include <algorithm>


#include <Windows.h>

#define ENABLE_VIBRATO 0
#define ENABLE_TREMOLO 0

double SAMPLE_RATE = 44100;

void load();
void save();

LPVM_MIDI_PORT midiPort;
std::vector<uint8_t> midiData;
std::mutex midiDataMutex;
static std::future<void> futurePlayVGM;
static std::future<void> futureSave;

static bool b_dump_writes = false;

struct NukedOPL3Transport
{
	opl3_chip chip;
	int32_t numSamples = 0;
	std::vector<Bit16s> buffer;

	NukedOPL3Transport()
	{
	}

	~NukedOPL3Transport()
	{
	}

	void reset()
	{
	    std::memset(&chip, 0, sizeof(chip));
		OPL3_Reset(&chip, SAMPLE_RATE);
	}

	void writeReg(uint8_t arr, uint8_t addr, uint8_t data)
	{
		if(b_dump_writes)
			printf("Write: %.2x %.2x - %.2x\n", arr, addr, data);

		OPL3_WriteRegBuffered(&chip, (arr << 8) | addr, data);
	}

	void sendParams(Params& params)
	{
	}

	void readSamples(float* buf, int32_t samples)
	{
		buffer.resize(samples * 4);
		auto* genBuf = buffer.data();
		OPL3_GenerateStream(&chip, genBuf, samples);
		for(int i = 0; i < samples; ++i)
		{
			buf[i*2] = genBuf[i*4] / 32767.0f;
			buf[i*2+1] = genBuf[i*4+1] / 32767.0f;
		}
	}
};

struct NukedOPN2Transport
{
	ym3438_t chip;
	int32_t numSamples = 0;
	std::vector<Bit16s> buffer;
	std::mutex mutex;

	NukedOPN2Transport()
	{
	}

	~NukedOPN2Transport()
	{
	}

	void reset()
	{
		OPN2_Reset(&chip, SAMPLE_RATE, 7670453);
		OPN2_SetChipType(ym3438_type_asic);
	}

	void writeReg(uint8_t arr, uint8_t addr, uint8_t data)
	{
		mutex.lock();
		OPN2_WriteBuffered(&chip, (arr << 1), addr);
		OPN2_WriteBuffered(&chip, ((arr << 1) | 1), data);
		mutex.unlock();
	}

	void readSamples(float* buf, int32_t samples)
	{
		buffer.resize(samples * 4);
		auto* genBuf = buffer.data();
		mutex.lock();
		OPN2_GenerateStream(&chip, genBuf, samples);
		mutex.unlock();
		for(int i = 0; i < samples; ++i)
		{
			buf[i*2] = genBuf[i*2] / 32767.0f;
			buf[i*2+1] = genBuf[i*2+1] / 32767.0f;
		}
	}
};

struct SerialOPL3Transport
{
	HANDLE handle_ = nullptr;

	NukedOPL3Transport emu_;
	std::future<void> futureLogging;

	SerialOPL3Transport(const char* port, int baudRate)
	{
		std::string portPath = "\\\\.\\";
		portPath += port;

		handle_ = ::CreateFileA(portPath.c_str(), GENERIC_READ | GENERIC_WRITE, 0x0, nullptr, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL , nullptr);
	}

	SerialOPL3Transport(SerialOPL3Transport&& other)
	{
		using std::swap;
		swap(handle_, other.handle_);
	}

	~SerialOPL3Transport()
	{
		if(handle_)
			::CloseHandle(handle_);
	}

	struct Command
	{
		uint8_t id;
		uint8_t arr;
		uint8_t addr;
		uint8_t data;
	};

	void reset()
	{

		if(handle_)
		{
			BOOL retVal = 0;
			DCB serialParams = { 0 };
			serialParams.DCBlength = sizeof(serialParams);

			retVal = ::GetCommState(handle_, &serialParams);

			serialParams.BaudRate = 115200;
			serialParams.ByteSize = DATABITS_8;
			serialParams.StopBits = ONESTOPBIT;
			serialParams.Parity = PARITY_NONE;
			retVal = ::SetCommState(handle_, &serialParams);

			// Set timeouts
			COMMTIMEOUTS timeout = { 0 };
			timeout.ReadIntervalTimeout = 50;
			timeout.ReadTotalTimeoutConstant = 50;
			timeout.ReadTotalTimeoutMultiplier = 50;
			timeout.WriteTotalTimeoutConstant = 50;
			timeout.WriteTotalTimeoutMultiplier = 10;
			retVal = ::SetCommTimeouts(handle_, &timeout);

#if 0
			// Read and log:
			futureLogging = std::async(std::launch::async, 
				[this]()
			{
				char byte = 0;
				for(;;)
				{
					DWORD b;
					if(::ReadFile(handle_, &byte, 1, &b, nullptr))
						if(b > 0)
						{
							printf("%c", byte);
							byte = 0;
						}
					::Sleep(10);
				}
			});
#endif
		}

		emu_.reset();

		softReset();
	}

	void softReset()
	{
		Command cmd = { 'r', 0x0, 0x0, 0x0 };
		DWORD bytesWritten = 0;
		auto retVal = ::WriteFile(handle_, &cmd, sizeof(cmd), &bytesWritten, nullptr);
	}

	void sendParams(Params& params)
	{
		Command cmd = { 'p', 0x0, 0x0, 0x0 };
		DWORD bytesWritten = 0;
		auto retVal = ::WriteFile(handle_, &params, sizeof(params), &bytesWritten, nullptr);
	}

	void writeReg(uint8_t arr, uint8_t addr, uint8_t data)
	{
		emu_.writeReg(arr, addr, data);

		//printf("addr %x data %x\n", addr, data);

		Command cmd = { 'w', arr, addr, data };
		DWORD bytesWritten = 0;
		auto retVal = ::WriteFile(handle_, &cmd, sizeof(cmd), &bytesWritten, nullptr);
	}


	void readSamples(float* buf, int32_t samples)
	{
		emu_.readSamples(buf, samples);
	}
};


OPL3::Interface<SerialOPL3Transport> opl3(SerialOPL3Transport("COM14", 115200));
OPN2::Interface<NukedOPN2Transport> opn2;

FILE* vgmFile = nullptr;

#define M_PI       3.14159265358979323846   // pi

float t = 0.0f;
float dt = (440.0f * 2.0f * M_PI) / SAMPLE_RATE;
std::atomic<uint64_t> currSample = 0;
std::mutex fmMutex;
uint64_t nextSample = 0;

void fm_flush()
{
	fmMutex.lock();
	opl3.flush();
	//opn2.flush();
	fmMutex.unlock();
}

std::vector<float> visSamples;

int callback(
	const void *input, void *output,
	unsigned long frameCount,
	const PaStreamCallbackTimeInfo* timeInfo,
	PaStreamCallbackFlags statusFlags,
	void *userData )
{
	float* o = (float*)output;
	fmMutex.lock();
	opl3.getTransport().readSamples(o, frameCount);
	//opn2.getTransport().readSamples(o, frameCount);

	auto maxCnt = 8192;
	visSamples.reserve(maxCnt * 2);
	for(int i = 0; i < frameCount; ++i)
	{
		visSamples.push_back(o[i*2]);
	}
	if(visSamples.size() > maxCnt)
	{
		auto cnt = visSamples.size() - maxCnt;
		visSamples.erase(visSamples.begin(), visSamples.begin() + cnt);
	}
	fmMutex.unlock();
	currSample += frameCount;
	t = std::fmodf(t, 2.0f * M_PI);
	return 0;
};

void playVGM()
{
	if(vgmFile = fopen("02 At Doom's Gate.vgm", "rb"))
	{
		struct VGMHeader {
			unsigned long VGMIdent;               // "Vgm "
			unsigned long EoFOffset;              // relative offset (from this point, 0x04) of the end of file
			unsigned long Version;                // 0x00000110 for 1.10
			unsigned long PSGClock;               // typically 3579545, 0 for no PSG
			unsigned long YM2413Clock;            // typically 3579545, 0 for no YM2413
			unsigned long GD3Offset;              // relative offset (from this point, 0x14) of the GD3 tag, 0 if not present
			unsigned long TotalLength;            // in samples
			unsigned long LoopOffset;             // relative again (to 0x1c), 0 if no loop
			unsigned long LoopLength;             // in samples, 0 if no loop
			unsigned long RecordingRate;          // in Hz, for speed-changing, 0 for no changing
			unsigned short PSGWhiteNoiseFeedback; // Feedback pattern for white noise generator; if <=v1.01, substitute default of 0x0009
			unsigned char PSGShiftRegisterWidth;  // Shift register width for noise channel; if <=v1.01, substitute default of 16
			unsigned char Reserved;
			unsigned long YM2612Clock;            // typically 3579545, 0 for no YM2612
			unsigned long YM2151Clock;            // typically 3579545, 0 for no YM2151
		};
		VGMHeader hdr;

		uint32_t bufferPos = 0;

		fread(&hdr, sizeof(VGMHeader), 1, vgmFile);
		auto dummyRead = [&](uint32_t b) -> uint8_t
		{
			int data[256];
			while(b > 256)
			{
				fread(data, 256, 1, vgmFile);
				b -= 256;
			}
			fread(data, b, 1, vgmFile);
			bufferPos += b;
			return data[0];
		};

		uint8_t pcmBuffer[40000];
		uint32_t pcmBufferPosition = 0;
		uint32_t waitSamples = 0;
		uint32_t loopOffset = 0;
		uint32_t loopCount = 0;

		fseek(vgmFile, 0, 0);
		for(int i = bufferPos; i<0x17; i++)
			dummyRead(1); //Ignore the unimportant VGM header data
		
		for ( int i = bufferPos; i < 0x1B; i++ ) //0x18->0x1B : Get wait Samples count
			waitSamples += uint32_t(dummyRead(1)) << ( 8 * i );

		for ( int i = bufferPos; i < 0x1F; i++ ) //0x1C->0x1F : Get loop offset Postition
			loopOffset += uint32_t(dummyRead(1)) << ( 8 * i );

		for ( int i = bufferPos; i < 0x40; i++ )
			dummyRead(1); //Go to VGM data start


		opl3.getTransport().softReset();

		opl3.clearRegisters();
		opl3.setRegister(0, OPL3::Register::WS_ENABLE, 0, 1);
		opl3.setRegister(0, OPL3::Register::TEST_REG, 0, 0);
		opl3.setRegister(1, OPL3::Register::OPL3, 0, 1);

		fm_flush();

		while(feof(vgmFile) == 0)
		{
			int numCmds = 0;
			const uint64_t currSampleCached = currSample * (44100.0 / SAMPLE_RATE);
			uint64_t pauseTime = 0;
			if(nextSample <= currSampleCached)
			{
				//printf("Curr: %lld\n", currSample.load());

				uint8_t b;
				uint8_t a, r;
				uint16_t w;
				fread(&b, 1, 1, vgmFile);
				//printf("vgm: %x\n", b);
				switch(b)
				{
				case 0x4f: // psg
				case 0x50: // psg
					fread(&a, 1, 1, vgmFile);
					++numCmds;
					break;
				case 0x52: // ym2612 port 0
					fread(&a, 1, 1, vgmFile);
					fread(&r, 1, 1, vgmFile);
					opn2.setRegister(0, a, r);
					++numCmds;
					break;
				case 0x53: // ym2612 port 1
					fread(&a, 1, 1, vgmFile);
					fread(&r, 1, 1, vgmFile);
					opn2.setRegister(1, a, r);
					++numCmds;
					break;

				case 0x5e: // ymf262 port 0
					fread(&a, 1, 1, vgmFile);
					fread(&r, 1, 1, vgmFile);
					opl3.setRegister(0, a, r);
					++numCmds;
					break;
				case 0x5f: // ymf262 port 1
					fread(&a, 1, 1, vgmFile);
					fread(&r, 1, 1, vgmFile);
					opl3.setRegister(1, a, r);
					++numCmds;
					break;

				case 0x61:
					fread(&w, 2, 1, vgmFile);
					pauseTime = w;
					break;

				case 0x62:
					pauseTime = 735;
					break;

				case 0x63:
					pauseTime = 882;
					break;

				case 0x66:
					if(loopOffset == 0)
						loopOffset = 64;
					loopCount++;
					fseek(vgmFile, loopOffset-0x1C, 0);;
					break;

				case 0x67:
				{
					auto aa = dummyRead(1);
					auto aaa = dummyRead(1);
					uint32_t pcmDataSize = 0;
					fread(&pcmDataSize, 4, 1, vgmFile);	
					for(int i = 0; i < pcmDataSize; i++)
					{
						if(pcmDataSize <= ARRAYSIZE(pcmBuffer))
							pcmBuffer[i] = (uint8_t)dummyRead(1);
			        }
					dummyRead(pcmDataSize);
					break;
				}
	
				case 0x80: // ym2612 port 0 address 2A write from the data bank
				case 0x81:
				case 0x82:
				case 0x83:
				case 0x84:
				case 0x85:
				case 0x86:
				case 0x87:
				case 0x88:
				case 0x89:
				case 0x8A:
				case 0x8B:
				case 0x8C:
				case 0x8D:
				case 0x8E:
				case 0x8F:					
				{
					uint8_t data = pcmBuffer[pcmBufferPosition++];
					opn2.setRegister(0, OPN2::Register::DAC, 0, data);
					pauseTime = ((b & 0x0f) + 1) / 8;
					break;
				}
				case 0x70:
				case 0x71:
				case 0x72:
				case 0x73:
				case 0x74:
				case 0x75:
				case 0x76:
				case 0x77:
				case 0x78:
				case 0x79:
				case 0x7a:
				case 0x7b:
				case 0x7c:
				case 0x7d:
				case 0x7e:
				case 0x7f:
					pauseTime = (b & 0x0f) / 8;
					break;

				case 0xe0:
					pcmBufferPosition = 0;
					for ( int i = 0; i < 4; i++ )
					{
						pcmBufferPosition += ( uint32_t( dummyRead(1) ) << ( 8 * i ));
					}
					break;
				default:
					//assert(false);
					break;
				}

				fm_flush();
				nextSample = currSampleCached + pauseTime;
			}

			YieldProcessor();
		}
	}
}

void playTone()
{
	opn2.setRegister(0, OPN2::Register::LFO_ENABLE, 0, 0);
	opn2.setRegister(0, OPN2::Register::CH3_MODE, 0, 0);
	//opn2.setRegister(0, 0x28, 0);
	//opn2.setRegister(0, 0x28, 1);
	//opn2.setRegister(0, 0x28, 2);
	//opn2.setRegister(0, 0x28, 3);
	//opn2.setRegister(0, 0x28, 4);
	//opn2.setRegister(0, 0x28, 5);
	//opn2.setRegister(0, 0x28, 6);
	opn2.setRegister(0, OPN2::Register::DAC_ENABLE, 0, 0);

	// DT1/MUL
	opn2.setRegister(0, 0x30, 0x71);
	opn2.setRegister(0, 0x34, 0x0D);
	opn2.setRegister(0, 0x38, 0x33);
	opn2.setRegister(0, 0x3C, 0x01);

	// TL
	opn2.setRegister(0, 0x40, 0x23);
	opn2.setRegister(0, 0x44, 0x2D);
	opn2.setRegister(0, 0x48, 0x26);
	opn2.setRegister(0, 0x4C, 0x00);

	// RS/AR
	opn2.setRegister(0, 0x50, 0x5F);
	opn2.setRegister(0, 0x50, 0x99);
	opn2.setRegister(0, 0x50, 0x5F);
	opn2.setRegister(0, 0x50, 0x94);

	// AM/D1R
	opn2.setRegister(0, 0x60, 5);
	opn2.setRegister(0, 0x64, 5);
	opn2.setRegister(0, 0x68, 5);
	opn2.setRegister(0, 0x6C, 7);

	// D2R
	opn2.setRegister(0, 0x70, 2);
	opn2.setRegister(0, 0x74, 2);
	opn2.setRegister(0, 0x78, 2);
	opn2.setRegister(0, 0x7C, 2);

	// D1L/RR
	opn2.setRegister(0, 0x80, 0x11);
	opn2.setRegister(0, 0x84, 0x11);
	opn2.setRegister(0, 0x88, 0x11);
	opn2.setRegister(0, 0x8C, 0xA6);

	// Proprietary
	opn2.setRegister(0, 0x90, 0x00);
	opn2.setRegister(0, 0x94, 0x00);
	opn2.setRegister(0, 0x98, 0x00);
	opn2.setRegister(0, 0x9C, 0x00);
	
	// FB/algo
	opn2.setRegister(0, 0xB0, 0x32);
	// L & R on
	opn2.setRegister(0, 0xB4, 0xC0);

	// Key off.
	opn2.setRegister(0, 0x28, 0x00);

	// Set freq
	opn2.setRegister(0, 0xA4, 0x22);
	opn2.setRegister(0, 0xA0, 0x69);

	// Key on.
	opn2.setRegister(0, 0x28, 0xf0);
	fm_flush();

	::Sleep(1000);

	// Key off.
	opn2.setRegister(0, 0x28, 0x00);
	fm_flush();
}

PmStream* midiStream = nullptr;
PaStream* audioStream = nullptr;

void init_opl3()
{
	load();

	int32_t samples = 0;
	auto midiCallback = []( LPVM_MIDI_PORT midiPort, LPBYTE midiDataBytes, DWORD length, DWORD_PTR dwCallbackInstance )
	{
		midiDataMutex.lock();
		for(int i = 0; i < length; ++i)
			midiData.push_back(midiDataBytes[i]);
		midiDataMutex.unlock();
	};

	midiPort = virtualMIDICreatePortEx2(L"4OpDrumModule IN", midiCallback, 0, 256, 0);

	Pa_Initialize();


	const auto* deviceInfo = Pa_GetDeviceInfo(Pa_GetDefaultOutputDevice());
	
	PaStreamParameters streamParams = {};
	streamParams.channelCount = 2;
	streamParams.device = Pa_GetDefaultOutputDevice();
	streamParams.sampleFormat = paFloat32;
	streamParams.suggestedLatency = deviceInfo->defaultLowOutputLatency;

	SAMPLE_RATE = deviceInfo->defaultSampleRate;
	opl3.getTransport().reset();
	opn2.getTransport().reset();

	// Initialize and enable OPL3 mode.
	opl3.clearRegisters();
	opl3.setRegister(0, OPL3::Register::WS_ENABLE, 0, 1);
	opl3.setRegister(0, OPL3::Register::TEST_REG, 0, 0);
	opl3.setRegister(1, OPL3::Register::OPL3, 0, 1);

	// Flush to device.
    fm_flush();

	auto err = Pa_OpenStream(&audioStream, nullptr, &streamParams, SAMPLE_RATE, 32, paNoFlag, callback, nullptr);
	if(err != paNoError)
	{
		exit(1);
	}
	Pa_StartStream(audioStream);

	Pm_Initialize();

	const PmDeviceInfo* midiDeviceInfo = nullptr;

#if 0
	auto midiDeviceId = Pm_GetDefaultInputDeviceID();
	for(int i = 0; ; ++i)
	{
		midiDeviceInfo = Pm_GetDeviceInfo(i);
		if(midiDeviceInfo && strstr(midiDeviceInfo->name, "Axiom 25") != nullptr && midiDeviceInfo->input == 1)
		{
			midiDeviceId = i;
			break;
		}
		if(!midiDeviceInfo)
			break;
	}

	Pm_OpenInput(&midiStream, midiDeviceId, nullptr, 256, nullptr, nullptr);
#endif
}

void deinit_opl3()
{
	save();
	Pa_Terminate();
	Pm_Terminate();

	virtualMIDIClosePort(midiPort);
}

struct OPN2OperatorParams
{
	int detune = 0; // 0-7
	int mult = 0; // 0-15
	int level = 0; // 0-127
	int ar = 0;  // attack rate 0-31
	int dr1 = 0; // decay rate 1 0-31
	int am = 0;  // amplitude mod 0-1
	int dr2 = 0; // decay rate 2 0-31
	int d1l = 0; // secondary amplitude 0-15
	int rr = 0; // release rate 0-15

	void randomize()
	{
		detune = (uint32_t)rand() % 7;
		mult = (uint32_t)rand() % 15;
		level = (uint32_t)rand() % 127;
		ar = (uint32_t)rand() % 31;
		dr1 = (uint32_t)rand() % 31;
		am = (uint32_t)rand() % 1;
		dr2 = (uint32_t)rand() % 31;
		d1l = (uint32_t)rand() % 15;
		rr = (uint32_t)rand() % 15;
	}

	void tweak()
	{
		detune = ::tweak(detune) % 7;
		mult = ::tweak(mult) % 15;
		level = ::tweak(level) % 127;
		ar = ::tweak(ar) % 31;
		dr1 = ::tweak(dr1) % 31;
		am = ::tweak(am) % 1;
		dr2 = ::tweak(dr2) % 31;
		d1l = ::tweak(d1l) % 15;
		rr = ::tweak(rr) % 15;
	}
};

struct OPN2VoiceParams
{
	bool on = false;
	bool on_latch = false;
	float freq = 440.0f;
	int feedback = 0; // 0-7
	int algo = 0; // 0-7
	int ams = 0; // 0-7
	int fms = 0; // 0-3

	OPN2OperatorParams ops[4] = {};

	void randomize()
	{
		feedback = (uint32_t)rand() % 7;
		ams = (uint32_t)rand() % 7;
		fms = (uint32_t)rand() % 3;
		ops[0].randomize();
		ops[1].randomize();
		ops[2].randomize();
		ops[3].randomize();
	}

	void tweak()
	{
		feedback = ::tweak(feedback) % 7;
		ams = ::tweak(ams) % 7;
		fms = ::tweak(fms) % 3;
		ops[0].tweak();
		ops[1].tweak();
		ops[2].tweak();
		ops[3].tweak();
	}
};

VoiceParams voices[6];

void load()
{
	if(auto saveFile = fopen("voices.sav", "rb"))
	{
		fread(voices, sizeof(VoiceParams), 6, saveFile);
		fclose(saveFile);
	}
}

void save()
{
	if(auto saveFile = fopen("~voices.sav", "wb+"))
	{
		fwrite(voices, sizeof(VoiceParams), 6, saveFile);
		fclose(saveFile);

		::DeleteFileA("voices.sav");
		::MoveFileA("~voices.sav", "voices.sav");
	}

	Params params =
	{
		{ voices[0], voices[1], voices[2], voices[3], voices[4], voices[5] }
	};

	params.saveFactorySettings("factory_settings.h");
}

void saveAsync()
{
	if(futureSave.valid())
		futureSave.wait();

	futureSave = std::async(std::launch::async, save);
}

void operator_ui(OperatorParams& params)
{
	ImGui::Columns(3);

	ImGui::SliderInt("Attn.", &params.attn, 0, 63);
	ImGui::SliderInt("Wave", &params.wave, 0, 7);
	ImGui::SliderInt("Mult.", &params.mult, 0, 15);
	ImGui::NextColumn();
#if ENABLE_VIBRATO
	ImGui::Checkbox("En. Vibrato", &params.en_vib);
#endif
	ImGui::SliderInt("A", &params.a, 0, 15);
	ImGui::SliderInt("D", &params.d, 0, 15);
	ImGui::NextColumn();
#if ENABLE_TREMOLO
	ImGui::Checkbox("En. Tremolo", &params.en_tre);
#endif
	ImGui::SliderInt("S", &params.s, 0, 15);
	ImGui::SliderInt("R", &params.r, 0, 15);
	ImGui::NextColumn();

	ImGui::Columns(1);
}

void voice_ui(VoiceParams& params, int idx)
{
	const int numOps = params.conn < 2 ? 2 : 4;

	static VoiceParams copiedVoice;
	if(ImGui::GetIO().KeysDown['C'])
		copiedVoice = params;
	if(ImGui::GetIO().KeysDown['V'])
		params = copiedVoice;

	ImGui::Columns(6);
	if(ImGui::Button("1&2 <-> 3&4"))
	{
		std::swap(params.ops[0], params.ops[2]);
		std::swap(params.ops[1], params.ops[3]);
		saveAsync();
	}
	ImGui::NextColumn();

	if(ImGui::Button("1 <-> 2"))
	{
		std::swap(params.ops[0], params.ops[1]);
		saveAsync();
	}
	ImGui::NextColumn();

	if(ImGui::Button("3 <-> 4"))
	{
		std::swap(params.ops[2], params.ops[3]);
		saveAsync();
	}
	ImGui::NextColumn();

	if(ImGui::Button("1 <-> 4"))
	{
		std::swap(params.ops[0], params.ops[3]);
		saveAsync();
	}
	ImGui::NextColumn();
	if(ImGui::Button("Randomize"))
	{
		params.randomize();
		saveAsync();
	}
	ImGui::NextColumn();

	if(ImGui::Button("Tweak"))
	{
		params.tweak();
		saveAsync();
	}
	ImGui::Columns(1);

	ImGui::SliderFloat("Freq", &params.freq, 0.0f, 4000.0f, "%.3f", 2.0f);
	ImGui::SliderInt("Feedback", &params.feedback, 0, 7);

	const char* conn[6] = { "FM", "AM", "FM-FM", "AM-FM", "FM-AM", "AM-AM" };
	ImGui::Columns(6);
	for(int i = 0; i < 6; ++i)
	{
		ImGui::RadioButton(conn[i], &params.conn, i);
		ImGui::NextColumn();
	}
	ImGui::Columns(1);


	for(int i = 0; i < numOps; ++i)
	{
		ImGui::Separator();
		ImGui::Text("Operator %d (%s%d):", i + 1, i % 2 == 0 ? "Modulator " : "Carrier ", (i / 2) + 1);

		ImGui::PushID(i);
		operator_ui(params.ops[i]);
		ImGui::PopID();
	}
}

bool voice_update(VoiceParams& params, int idx)
{
	static const int VOICE_CH[6] = { 0, 1, 2, 9, 10, 11 };
	const int ch = VOICE_CH[idx];
	const int numOps = params.conn < 2 ? 2 : 4;

	fm_flush();

	int op[4] = { OPL3::MODE_4OP[0][ch], OPL3::MODE_4OP[1][ch], OPL3::MODE_4OP[2][ch], OPL3::MODE_4OP[3][ch] };

//	if(params.on == false && params.on_latch == params.on)
	{
	//	return false;
	}

	if(numOps == 2)
	{
		op[0] = OPL3::MODE_2OP[0][ch];
		op[1] = OPL3::MODE_2OP[1][ch];
		op[2] = -1;
		op[3] = -1;
	}

	int arr[4] = {-1, -1, -1, -1};
	int off[4] = {-1, -1, -1, -1};
		for(int i = 0; i < numOps; ++i)
	{
		arr[i] = OPL3::OP_OFF[op[i]][0];
		off[i] = OPL3::OP_OFF[op[i]][1];
	}

	int mode4op = numOps == 4 ? 1 : 0;
	switch(ch)
	{
	case 0: opl3.setRegister(1, OPL3::Register::EN_4OP_03, 0, mode4op); break;
	case 1: opl3.setRegister(1, OPL3::Register::EN_4OP_14, 0, mode4op); break;
	case 2: opl3.setRegister(1, OPL3::Register::EN_4OP_25, 0, mode4op); break;
	case 9: opl3.setRegister(1, OPL3::Register::EN_4OP_9C, 0, mode4op); break;
	case 10: opl3.setRegister(1, OPL3::Register::EN_4OP_AD, 0, mode4op); break;
	case 11: opl3.setRegister(1, OPL3::Register::EN_4OP_BE, 0, mode4op); break;
	default: break;
	}

	// Per voice config.
	int attn[4] = { 0, 0, 0, 0 };
	{
		float f = params.freq;
		int b = 0;
		if(f < 48.503f)
			b = 0;
		else if(f < 97.006f)
			b = 1;
		else if(f < 194.013f)
			b = 2;
		else if(f < 388.026f)
			b = 3;
		else if(f < 776.053f)
			b = 4;
		else if(f < 1552.107f)
			b = 5;
		else if(f < 3104.215f)
			b = 6;
		else if(f < 6208.431f)
			b = 7;

		uint16_t fnum = (uint16_t)(f * pow(2.0f, 19.0f) / (14318180.0 / 288.0) / pow(2.0f, b - 1));

		opl3.setRegister(arr[0], OPL3::Register::BLOCK_NUM, off[0], b);
		opl3.setRegister(arr[0], OPL3::Register::FREQ_MSB, off[0], fnum >> 8);
		opl3.setRegister(arr[0], OPL3::Register::FREQ_LSB, off[0], fnum & 0xff);
		opl3.setRegister(arr[0], OPL3::Register::FEEDBACK, off[0], params.feedback);

		uint32_t voiceAttn = 0; //(127 - voices2[idx].velocity) >> 2;
		switch(params.conn)
		{
		case 0:
			opl3.setRegister(arr[0], OPL3::Register::CONN, off[0], 0);
			attn[1] = voiceAttn;
			break;
		case 1:
			opl3.setRegister(arr[0], OPL3::Register::CONN, off[0], 1);
			attn[0] = voiceAttn;
			attn[1] = voiceAttn;
			break;
		case 2:
			opl3.setRegister(arr[0], OPL3::Register::CONN, off[0], 0);
			opl3.setRegister(arr[1], OPL3::Register::CONN, off[1], 0);
			attn[3] = voiceAttn;
			break;
		case 3:
			opl3.setRegister(arr[0], OPL3::Register::CONN, off[0], 1);
			opl3.setRegister(arr[1], OPL3::Register::CONN, off[1], 0);

			attn[0] = voiceAttn;
			attn[3] = voiceAttn;
			break;
		case 4:
			opl3.setRegister(arr[0], OPL3::Register::CONN, off[0], 0);
			opl3.setRegister(arr[1], OPL3::Register::CONN, off[1], 1);

			attn[1] = voiceAttn;
			attn[3] = voiceAttn;

			break;
		case 5:
			opl3.setRegister(arr[0], OPL3::Register::CONN, off[0], 1);
			opl3.setRegister(arr[1], OPL3::Register::CONN, off[1], 1);

			attn[0] = voiceAttn;
			attn[2] = voiceAttn;
			attn[3] = voiceAttn;
			break;
		}
	}

	for(int i = 0; i < numOps; ++i)
	{
		// 0x20
		opl3.setRegister(arr[i], OPL3::Register::EN_SUS, off[i], params.ops[i].en_sus);
#if ENABLE_VIBRATO
		opl3.setRegister(arr[i], OPL3::Register::EN_TRE, off[i], params.ops[i].en_tre);
#else
		opl3.setRegister(arr[i], OPL3::Register::EN_TRE, off[i], 0);
#endif
#if ENABLE_VIBRATO
		opl3.setRegister(arr[i], OPL3::Register::EN_VIB, off[i], params.ops[i].en_vib);
#else
		opl3.setRegister(arr[i], OPL3::Register::EN_VIB, off[i], 0);
#endif
		opl3.setRegister(arr[i], OPL3::Register::KSR, off[i], 0);
		opl3.setRegister(arr[i], OPL3::Register::MULT, off[i], params.ops[i].mult);

		// 0x40
		opl3.setRegister(arr[i], OPL3::Register::KSL, off[i], 0);
		opl3.setRegister(arr[i], OPL3::Register::ATTN, off[i], std::min(63, params.ops[i].attn + attn[i]));

		// 0x60
		opl3.setRegister(arr[i], OPL3::Register::ATTACK, off[i], params.ops[i].a);
		opl3.setRegister(arr[i], OPL3::Register::DECAY, off[i], params.ops[i].d);

		// 0x80
		opl3.setRegister(arr[i], OPL3::Register::SUSTAIN, off[i], params.ops[i].s);
		opl3.setRegister(arr[i], OPL3::Register::RELEASE, off[i], params.ops[i].r);

		// 0xC0
		opl3.setRegister(arr[i], OPL3::Register::CHAN_A, off[i], 1);
		opl3.setRegister(arr[i], OPL3::Register::CHAN_B, off[i], 1);

		// 0xE0
		opl3.setRegister(arr[i], OPL3::Register::WAVE_SEL, off[i], params.ops[i].wave);
	}

	bool keyedOn = false;
	if(params.on_latch != params.on)
	{
		params.on_latch = params.on;
		if(params.on)
		{
			params.log();

			b_dump_writes = true;
			opl3.setRegister(arr[0], OPL3::Register::KEY_ON, off[0], 1);
			keyedOn = true;

			fm_flush();
			b_dump_writes = false;
		}
		else
		{
			opl3.setRegister(arr[0], OPL3::Register::KEY_ON, off[0], 0);
		}
	}
	else
	{
		//opl3.setRegister(arr[0], OPL3::Register::KEY_ON, off[0], 1);
	}

	fm_flush();
	return keyedOn;
}

double saveTimer = 0.0f;

uint8_t voiceNotes[6] = 
{
	36, 38, 42, 46, 50, 45 
#if 0
	60,
	62,
	64,
	65,
	67,
	69,
#endif
};

void loop()
{
	int x,y,n;
	unsigned char *data = stbi_load("4op.png", &x, &y, &n, 0);
	// ... process data if not NULL ...
	// ... x = width, y = height, n = # 8-bit components per pixel ...
	// ... replace '0' with '1'..'4' to force that many components per pixel
	// ... but 'n' will always be the number that it would have been if you said 0


	if(data)
	{
		if(auto f = fopen("icons.h", "w+"))
		{
			uint32_t* t = (uint32_t*)data;

			fprintf(f, "#pragma once\n");
			fprintf(f, "static const int icons_w = %i;\n", x);
			fprintf(f, "static const int icons_h = %i;\n", y);
			fprintf(f, "static const uint8_t icons_data[] = {\n");
			int numBytes = (x * y) / 8;
			int it = 0;
			for(int i = 0; i < numBytes; ++i)
			{
				if((i % 32) == 0)
				{
					fprintf(f, "\t");
				}

				uint8_t b = 0;
				for(int j = 0; j < 8; ++j)
				{
					b <<= 1;
					uint32_t d = *t++;
					if((d & 0x00ffffff) > 0)
						b |= 1;
				}
				fprintf(f, "0x%.2x, ", b);

				if((i % 32) == 31)
				{
					fprintf(f, "\n");
				}
			}

			fprintf(f, "};\n");

			fclose(f);

			++t;
		}
		stbi_image_free(data);
	}


#if 0
	while(Pm_Poll(midiStream) == pmGotData)
	{
		PmEvent ev;
		if(Pm_Read(midiStream, &ev, 1))
		{
			union
			{
				uint32_t fullMsg;
				uint8_t msgBytes[4];
			};
			fullMsg = ev.message;

			uint8_t msg = msgBytes[0] & 0xf0;
			uint8_t ch = msgBytes[0] & 0x0f;

			if(ch == 0x9)
			{
				switch(msg)
				{
				case 0b10110000: // control change
					{

					}
					break;
				case 0b10000000: // note off
					{
						uint8_t k = msgBytes[1];
						uint8_t v = msgBytes[2];
						for(int i = 0; i < 6; ++i)
						{
							if(k == voiceNotes[i])
								voices[i].on = false;
						}
						printf("NOTE_OFF: %u, %u\n", k, v);
					}
					break;
				case 0b10010000: // note on
					{
						uint8_t k = msgBytes[1];
						uint8_t v = msgBytes[2];
						for(int i = 0; i < 6; ++i)
						{
							if(k == voiceNotes[i])
							{
								if(v == 0)
									voices[i].on = false;
								else
								{
									voices[i].on = true;
									voices2[i].velocity = v;
								}
							}
						}

						printf("NOTE_ON: %u, %u\n", k, v);
					}
					break;
				}
			}

		}
	}

	midiDataMutex.lock();
	midiData.clear();
	midiDataMutex.unlock();
#endif

#if 0
	midiDataMutex.lock();
	const uint8_t* midiByte = midiData.data();
	const uint8_t* midiByteEnd = midiData.data() + midiData.size();
	while(midiByte && midiByte != midiByteEnd)
	{
		uint8_t msg = *midiByte & 0xf0;
		uint8_t ch = *midiByte & 0x0f;

		++midiByte;
		if(ch == 0)
		{
			switch(msg)
			{
			case 0b10000000: // note off
				{
					uint8_t k = *midiByte++;
					uint8_t v = *midiByte++;
					for(int i = 0; i < 6; ++i)
					{
//						if(k == voiceNotes[i])
//							voices[i].on = false;
					}
				}
				break;
			case 0b10010000: // note on
				{
					uint8_t k = *midiByte++;
					uint8_t v = *midiByte++;
					for(int i = 0; i < 6; ++i)
					{
						if(k == voiceNotes[i])
						{
							voices[i].on = true;
						}
					}
				}
				break;
			}
		}
	}
	midiData.clear();
	midiDataMutex.unlock();
#endif

    {
        static float f = 0.0f;
        static int counter = 0;

		ImGui::SetNextWindowPos(ImVec2(0, 0));
		ImGui::SetNextWindowSize(ImGui::GetIO().DisplaySize);
        ImGui::Begin("4 Operator Drum Machine Prototype", nullptr, ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoMove) ;

#if 1
		if(ImGui::Button("Play VGM (Test)"))
		{
			if(!futurePlayVGM.valid())
			{
				futurePlayVGM = std::async(std::launch::async, playVGM);
			}
		}
		if(ImGui::Button("Play Tone (Test)"))
		{
			playTone();
		}
#endif

		saveTimer += 1.0f / 60.0f;

		if(saveTimer > 10.0f)
		{
			saveAsync();

			saveTimer -= 10.0f;
		}

		static bool vibDepth = false;
		static bool treDepth = false;
		ImGui::Columns(2);
#if ENABLE_VIBRATO
		ImGui::Checkbox("Vib. Depth", &vibDepth);
#endif
		ImGui::NextColumn();
#if ENABLE_TREMOLO
		ImGui::Checkbox("Tre. Depth", &treDepth);
#endif
		ImGui::Columns(1);
		opl3.setRegister(0, OPL3::Register::VIBR_DEP, 0, vibDepth ? 1 : 0);
		opl3.setRegister(0, OPL3::Register::TREM_DEP, 0, treDepth ? 1 : 0);

		ImGui::Separator();
		fmMutex.lock();

		ImGui::PlotLines("", visSamples.data(), visSamples.size(), 0, nullptr, 
			-0.5f, 0.5f, ImVec2(ImGui::GetIO().DisplaySize.x - 4, 100));
		fmMutex.unlock();
		ImGui::Separator();
		ImGui::Columns(6);
		static int voice  = 0;

		if(!futurePlayVGM.valid())
		{
			for(int i = 0; i < 6; ++i)
			{
				char label[100] = {};
				sprintf_s(label, sizeof(label), "Voice: %d", i + 1);

				if(ImGui::RadioButton(label, &voice, i))
				{
					voice = i;
					saveAsync();
				}
				ImGui::NextColumn();

				voices[i].on = ImGui::GetIO().KeysDown['1' + i];

				if(voice_update(voices[i], i))
				{
					voice = i;
				}
			}

			static int tickery = 0;
			if(tickery++ > 10)
			{
				Params params;
				params.voices[0] = voices[0];
				params.voices[1] = voices[1];
				params.voices[2] = voices[2];
				params.voices[3] = voices[3];
				params.voices[4] = voices[4];
				params.voices[5] = voices[5];
				//opl3.getTransport().sendParams(params);
				tickery = 0;
			}
		}

		ImGui::Columns(1);
		ImGui::Separator();

		voice_ui(voices[voice], voice);

        ImGui::End();
    }
}
#endif // defined(WIN32)

