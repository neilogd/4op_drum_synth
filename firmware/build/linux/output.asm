
./firmware:     file format elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:	48 83 ec 08          	sub    $0x8,%rsp
    1004:	48 8b 05 cd 5f 00 00 	mov    0x5fcd(%rip),%rax        # 6fd8 <__gmon_start__>
    100b:	48 85 c0             	test   %rax,%rax
    100e:	74 02                	je     1012 <_init+0x12>
    1010:	ff d0                	callq  *%rax
    1012:	48 83 c4 08          	add    $0x8,%rsp
    1016:	c3                   	retq   

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:	ff 35 5a 5f 00 00    	pushq  0x5f5a(%rip)        # 6f80 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	ff 25 5c 5f 00 00    	jmpq   *0x5f5c(%rip)        # 6f88 <_GLOBAL_OFFSET_TABLE_+0x10>
    102c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000001030 <__printf_chk@plt>:
    1030:	ff 25 5a 5f 00 00    	jmpq   *0x5f5a(%rip)        # 6f90 <__printf_chk@GLIBC_2.3.4>
    1036:	68 00 00 00 00       	pushq  $0x0
    103b:	e9 e0 ff ff ff       	jmpq   1020 <.plt>

0000000000001040 <__cxa_guard_release@plt>:
    1040:	ff 25 52 5f 00 00    	jmpq   *0x5f52(%rip)        # 6f98 <__cxa_guard_release@CXXABI_1.3>
    1046:	68 01 00 00 00       	pushq  $0x1
    104b:	e9 d0 ff ff ff       	jmpq   1020 <.plt>

0000000000001050 <__cxa_atexit@plt>:
    1050:	ff 25 4a 5f 00 00    	jmpq   *0x5f4a(%rip)        # 6fa0 <__cxa_atexit@GLIBC_2.2.5>
    1056:	68 02 00 00 00       	pushq  $0x2
    105b:	e9 c0 ff ff ff       	jmpq   1020 <.plt>

0000000000001060 <strcpy@plt>:
    1060:	ff 25 42 5f 00 00    	jmpq   *0x5f42(%rip)        # 6fa8 <strcpy@GLIBC_2.2.5>
    1066:	68 03 00 00 00       	pushq  $0x3
    106b:	e9 b0 ff ff ff       	jmpq   1020 <.plt>

0000000000001070 <__stack_chk_fail@plt>:
    1070:	ff 25 3a 5f 00 00    	jmpq   *0x5f3a(%rip)        # 6fb0 <__stack_chk_fail@GLIBC_2.4>
    1076:	68 04 00 00 00       	pushq  $0x4
    107b:	e9 a0 ff ff ff       	jmpq   1020 <.plt>

0000000000001080 <__cxa_guard_acquire@plt>:
    1080:	ff 25 32 5f 00 00    	jmpq   *0x5f32(%rip)        # 6fb8 <__cxa_guard_acquire@CXXABI_1.3>
    1086:	68 05 00 00 00       	pushq  $0x5
    108b:	e9 90 ff ff ff       	jmpq   1020 <.plt>

Disassembly of section .plt.got:

0000000000001090 <__cxa_finalize@plt>:
    1090:	ff 25 2a 5f 00 00    	jmpq   *0x5f2a(%rip)        # 6fc0 <__cxa_finalize@GLIBC_2.2.5>
    1096:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

00000000000010a0 <main>:
    SDL_Texture* texture_;
    DisplayST7735 display;
};

int main()
{
    10a0:	50                   	push   %rax
    static VoiceParams oldVoice;
    10a1:	8a 05 d1 5f 00 00    	mov    0x5fd1(%rip),%al        # 7078 <_ZGVZ4mainE8oldVoice>
    10a7:	84 c0                	test   %al,%al
    10a9:	75 28                	jne    10d3 <main+0x33>
    10ab:	48 8d 3d c6 5f 00 00 	lea    0x5fc6(%rip),%rdi        # 7078 <_ZGVZ4mainE8oldVoice>
    10b2:	e8 c9 ff ff ff       	callq  1080 <__cxa_guard_acquire@plt>
    10b7:	85 c0                	test   %eax,%eax
    10b9:	74 18                	je     10d3 <main+0x33>
    10bb:	48 8d 3d be 5f 00 00 	lea    0x5fbe(%rip),%rdi        # 7080 <_ZZ4mainE8oldVoice>
    10c2:	e8 87 06 00 00       	callq  174e <_ZN11VoiceParamsC1Ev>
    10c7:	48 8d 3d aa 5f 00 00 	lea    0x5faa(%rip),%rdi        # 7078 <_ZGVZ4mainE8oldVoice>
    10ce:	e8 6d ff ff ff       	callq  1040 <__cxa_guard_release@plt>
    voice_update(oldVoice, 0, 16, -1);
    10d3:	f3 0f 10 05 0d 31 00 	movss  0x310d(%rip),%xmm0        # 41e8 <_ZN4OPL3L6OP_OFFE+0x48>
    10da:	00 
    10db:	ba 10 00 00 00       	mov    $0x10,%edx
    10e0:	31 f6                	xor    %esi,%esi
    10e2:	48 8d 3d 97 5f 00 00 	lea    0x5f97(%rip),%rdi        # 7080 <_ZZ4mainE8oldVoice>
    10e9:	e8 c3 03 00 00       	callq  14b1 <_Z12voice_updateR11VoiceParamsiif>

00000000000010ee <_GLOBAL__sub_I_ExampleName>:
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();

    return 0;
}
    10ee:	55                   	push   %rbp
static CommandList cmdList(cmdListBuffer, sizeof(cmdListBuffer));
    10ef:	48 8d 35 aa 7a 00 00 	lea    0x7aaa(%rip),%rsi        # 8ba0 <_ZL13cmdListBuffer>
    10f6:	48 8d 3d 83 7a 00 00 	lea    0x7a83(%rip),%rdi        # 8b80 <_ZL7cmdList>
}
    10fd:	53                   	push   %rbx
    10fe:	48 8d 1d c3 5f 00 00 	lea    0x5fc3(%rip),%rbx        # 70c8 <_ZL6params+0x8>
    1105:	52                   	push   %rdx
static CommandList cmdList(cmdListBuffer, sizeof(cmdListBuffer));
    1106:	ba 00 04 00 00       	mov    $0x400,%edx
    110b:	48 8d ab 90 00 00 00 	lea    0x90(%rbx),%rbp
    1112:	e8 a3 1c 00 00       	callq  2dba <_ZN11CommandListC1EPhj>
    constexpr static int16_t TILES_X = CANVAS_W / TILE_W;
    constexpr static int16_t TILES_Y = CANVAS_H / TILE_H;
    constexpr static int16_t TILES_NUM = TILES_X * TILES_Y;

    TileCanvas() :
        BaseTileCanvas(TILE_W, TILE_H, TILES_X, TILES_Y, pixBuffer_, tileBuffer_)
    1117:	41 b8 04 00 00 00    	mov    $0x4,%r8d
    111d:	ba 20 00 00 00       	mov    $0x20,%edx
    1122:	48 8d 05 03 7a 00 00 	lea    0x7a03(%rip),%rax        # 8b2c <_ZL10tileCanvas+0x10cc>
    1129:	51                   	push   %rcx
    112a:	be 40 00 00 00       	mov    $0x40,%esi
    112f:	b9 02 00 00 00       	mov    $0x2,%ecx
    1134:	4c 8d 88 fe ef ff ff 	lea    -0x1002(%rax),%r9
    113b:	50                   	push   %rax
    113c:	48 8d b8 34 ef ff ff 	lea    -0x10cc(%rax),%rdi
    1143:	e8 a6 23 00 00       	callq  34ee <_ZN14BaseTileCanvasC1EssssPtP4Tile>
static TileCanvas<TILE_W, TILE_H, CANVAS_W, CANVAS_H> tileCanvas;
    1148:	48 8d 15 b9 5e 00 00 	lea    0x5eb9(%rip),%rdx        # 7008 <__dso_handle>
    114f:	48 8d 35 0a 69 00 00 	lea    0x690a(%rip),%rsi        # 7a60 <_ZL10tileCanvas>
    1156:	48 8d 05 eb 5b 00 00 	lea    0x5beb(%rip),%rax        # 6d48 <_ZTV10TileCanvasILs64ELs32ELs128ELs128EE+0x10>
    115d:	48 8d 3d d2 05 00 00 	lea    0x5d2(%rip),%rdi        # 1736 <_ZN10TileCanvasILs64ELs32ELs128ELs128EED1Ev>
    1164:	48 89 05 f5 68 00 00 	mov    %rax,0x68f5(%rip)        # 7a60 <_ZL10tileCanvas>
    116b:	e8 e0 fe ff ff       	callq  1050 <__cxa_atexit@plt>
static Encoders encoders;
    1170:	48 8d 3d a9 68 00 00 	lea    0x68a9(%rip),%rdi        # 7a20 <_ZL8encoders>
    1177:	e8 b4 01 00 00       	callq  1330 <_ZN8EncodersC1Ev>
static UI ui(encoders);
    117c:	48 8d 35 9d 68 00 00 	lea    0x689d(%rip),%rsi        # 7a20 <_ZL8encoders>
    1183:	48 8d 3d 36 68 00 00 	lea    0x6836(%rip),%rdi        # 79c0 <_ZL2ui>
    118a:	e8 b9 13 00 00       	callq  2548 <_ZN2UIC1ER8Encoders>
	template<class TRANS>
	class Interface
	{
	public:
	  Interface(TRANS& trans)
      : trans_(trans)
    118f:	48 8d 05 12 68 00 00 	lea    0x6812(%rip),%rax        # 79a8 <_ZL9transport>
    {
      __warn_memset_zero_len ();
      return __dest;
    }
#endif
  return __builtin___memset_chk (__dest, __ch, __len, __bos0 (__dest));
    1196:	b9 80 00 00 00       	mov    $0x80,%ecx
    119b:	48 8d 35 c6 65 00 00 	lea    0x65c6(%rip),%rsi        # 7768 <_ZL4opl3+0x8>
    11a2:	48 89 f7             	mov    %rsi,%rdi
    11a5:	48 89 05 b4 65 00 00 	mov    %rax,0x65b4(%rip)        # 7760 <_ZL4opl3>
    11ac:	31 c0                	xor    %eax,%eax
    11ae:	f3 ab                	rep stos %eax,%es:(%rdi)
    11b0:	b0 ff                	mov    $0xff,%al
    11b2:	b9 40 00 00 00       	mov    $0x40,%ecx
  uint8_t channels : 4;
  //
  uint8_t reserved : 4;
};

struct ParamsBase
    11b7:	48 c7 05 fe 5e 00 00 	movq   $0x0,0x5efe(%rip)        # 70c0 <_ZL6params>
    11be:	00 00 00 00 
    11c2:	f3 aa                	rep stos %al,%es:(%rdi)
struct BasicPong
    11c4:	48 b8 40 00 00 00 40 	movabs $0x4000000040,%rax
    11cb:	00 00 00 
    11ce:	48 89 05 93 5e 00 00 	mov    %rax,0x5e93(%rip)        # 7068 <pong+0x8>
    11d5:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    11dc:	00 00 00 
    11df:	48 89 05 8a 5e 00 00 	mov    %rax,0x5e8a(%rip)        # 7070 <pong+0x10>
    11e6:	5e                   	pop    %rsi
    11e7:	5f                   	pop    %rdi
struct ParamsT : ParamsBase
{
  static const uint32_t VERSION = _VERSION;
};

struct Params_V0_0 : ParamsT<0x00000000>
    11e8:	48 89 df             	mov    %rbx,%rdi
    11eb:	48 83 c3 18          	add    $0x18,%rbx
    11ef:	e8 5a 05 00 00       	callq  174e <_ZN11VoiceParamsC1Ev>
    11f4:	48 39 eb             	cmp    %rbp,%rbx
    11f7:	75 ef                	jne    11e8 <_GLOBAL__sub_I_ExampleName+0xfa>
    11f9:	48 8d 1d 58 5f 00 00 	lea    0x5f58(%rip),%rbx        # 7158 <_ZL6params+0x98>
    1200:	48 8d ab 00 06 00 00 	lea    0x600(%rbx),%rbp
    1207:	48 89 df             	mov    %rbx,%rdi
    120a:	48 83 c3 18          	add    $0x18,%rbx
    120e:	e8 3b 05 00 00       	callq  174e <_ZN11VoiceParamsC1Ev>
    1213:	48 39 dd             	cmp    %rbx,%rbp
    1216:	75 ef                	jne    1207 <_GLOBAL__sub_I_ExampleName+0x119>
}
    1218:	58                   	pop    %rax
    1219:	5b                   	pop    %rbx
    121a:	5d                   	pop    %rbp
    121b:	c3                   	retq   
    121c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000001220 <_start>:
    1220:	31 ed                	xor    %ebp,%ebp
    1222:	49 89 d1             	mov    %rdx,%r9
    1225:	5e                   	pop    %rsi
    1226:	48 89 e2             	mov    %rsp,%rdx
    1229:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    122d:	50                   	push   %rax
    122e:	54                   	push   %rsp
    122f:	4c 8d 05 aa 2d 00 00 	lea    0x2daa(%rip),%r8        # 3fe0 <__libc_csu_fini>
    1236:	48 8d 0d 43 2d 00 00 	lea    0x2d43(%rip),%rcx        # 3f80 <__libc_csu_init>
    123d:	48 8d 3d 5c fe ff ff 	lea    -0x1a4(%rip),%rdi        # 10a0 <main>
    1244:	ff 15 86 5d 00 00    	callq  *0x5d86(%rip)        # 6fd0 <__libc_start_main@GLIBC_2.2.5>
    124a:	f4                   	hlt    
    124b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000001250 <deregister_tm_clones>:
    1250:	48 8d 3d d1 5d 00 00 	lea    0x5dd1(%rip),%rdi        # 7028 <__TMC_END__>
    1257:	48 8d 05 ca 5d 00 00 	lea    0x5dca(%rip),%rax        # 7028 <__TMC_END__>
    125e:	48 39 f8             	cmp    %rdi,%rax
    1261:	74 15                	je     1278 <deregister_tm_clones+0x28>
    1263:	48 8b 05 5e 5d 00 00 	mov    0x5d5e(%rip),%rax        # 6fc8 <_ITM_deregisterTMCloneTable>
    126a:	48 85 c0             	test   %rax,%rax
    126d:	74 09                	je     1278 <deregister_tm_clones+0x28>
    126f:	ff e0                	jmpq   *%rax
    1271:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    1278:	c3                   	retq   
    1279:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001280 <register_tm_clones>:
    1280:	48 8d 3d a1 5d 00 00 	lea    0x5da1(%rip),%rdi        # 7028 <__TMC_END__>
    1287:	48 8d 35 9a 5d 00 00 	lea    0x5d9a(%rip),%rsi        # 7028 <__TMC_END__>
    128e:	48 29 fe             	sub    %rdi,%rsi
    1291:	48 c1 fe 03          	sar    $0x3,%rsi
    1295:	48 89 f0             	mov    %rsi,%rax
    1298:	48 c1 e8 3f          	shr    $0x3f,%rax
    129c:	48 01 c6             	add    %rax,%rsi
    129f:	48 d1 fe             	sar    %rsi
    12a2:	74 14                	je     12b8 <register_tm_clones+0x38>
    12a4:	48 8b 05 35 5d 00 00 	mov    0x5d35(%rip),%rax        # 6fe0 <_ITM_registerTMCloneTable>
    12ab:	48 85 c0             	test   %rax,%rax
    12ae:	74 08                	je     12b8 <register_tm_clones+0x38>
    12b0:	ff e0                	jmpq   *%rax
    12b2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    12b8:	c3                   	retq   
    12b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000012c0 <__do_global_dtors_aux>:
    12c0:	80 3d 79 5d 00 00 00 	cmpb   $0x0,0x5d79(%rip)        # 7040 <completed.7963>
    12c7:	75 2f                	jne    12f8 <__do_global_dtors_aux+0x38>
    12c9:	55                   	push   %rbp
    12ca:	48 83 3d ee 5c 00 00 	cmpq   $0x0,0x5cee(%rip)        # 6fc0 <__cxa_finalize@GLIBC_2.2.5>
    12d1:	00 
    12d2:	48 89 e5             	mov    %rsp,%rbp
    12d5:	74 0c                	je     12e3 <__do_global_dtors_aux+0x23>
    12d7:	48 8b 3d 2a 5d 00 00 	mov    0x5d2a(%rip),%rdi        # 7008 <__dso_handle>
    12de:	e8 ad fd ff ff       	callq  1090 <__cxa_finalize@plt>
    12e3:	e8 68 ff ff ff       	callq  1250 <deregister_tm_clones>
    12e8:	c6 05 51 5d 00 00 01 	movb   $0x1,0x5d51(%rip)        # 7040 <completed.7963>
    12ef:	5d                   	pop    %rbp
    12f0:	c3                   	retq   
    12f1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    12f8:	c3                   	retq   
    12f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000001300 <frame_dummy>:
    1300:	e9 7b ff ff ff       	jmpq   1280 <register_tm_clones>
    1305:	90                   	nop

0000000000001306 <_ZN12AnalogInputsC1Ev>:
#include "analog_inputs.h"

AnalogInputs::AnalogInputs()
    1306:	31 c0                	xor    %eax,%eax
{
  for(int i = 0; i < MAX_INPUTS; ++i)
  {
    pins_[i] = -1;
    1308:	c6 04 07 ff          	movb   $0xff,(%rdi,%rax,1)
    values_[i] = 0;
    130c:	c7 44 87 08 00 00 00 	movl   $0x0,0x8(%rdi,%rax,4)
    1313:	00 
    1314:	48 ff c0             	inc    %rax
  for(int i = 0; i < MAX_INPUTS; ++i)
    1317:	48 83 f8 08          	cmp    $0x8,%rax
    131b:	75 eb                	jne    1308 <_ZN12AnalogInputsC1Ev+0x2>
  }
}
    131d:	c3                   	retq   

000000000000131e <_ZN12AnalogInputs8setInputEii>:

void AnalogInputs::setInput(int idx, int pin)
{
  pins_[idx] = pin;
    131e:	48 63 f6             	movslq %esi,%rsi
    1321:	88 14 37             	mov    %dl,(%rdi,%rsi,1)
#if 0
  pinMode(pin, INPUT_ANALOG); 
#endif
}
    1324:	c3                   	retq   
    1325:	90                   	nop

0000000000001326 <_ZNK12AnalogInputs8getInputEi>:

int AnalogInputs::getInput(int idx) const
{
  return values_[idx];
    1326:	48 63 f6             	movslq %esi,%rsi
    1329:	8b 44 b7 08          	mov    0x8(%rdi,%rsi,4),%eax
}
    132d:	c3                   	retq   

000000000000132e <_ZN12AnalogInputs4scanEv>:
  {
    if(pins_[i] != -1)
      values_[i] = analogRead(pins_[i]);
  }
#endif
}
    132e:	c3                   	retq   
    132f:	90                   	nop

0000000000001330 <_ZN8EncodersC1Ev>:

Encoders::Encoders()
{
    for(int i = 0; i < NUM_ENCODERS; ++i)
    {
        values_[i] = 0;
    1330:	b8 01 01 01 00       	mov    $0x10101,%eax
Encoders::Encoders()
    1335:	c6 07 ff             	movb   $0xff,(%rdi)
        values_[i] = 0;
    1338:	48 c1 e0 28          	shl    $0x28,%rax
        button_[i] = 1;
    133c:	66 c7 47 20 01 01    	movw   $0x101,0x20(%rdi)
        values_[i] = 0;
    1342:	48 89 47 18          	mov    %rax,0x18(%rdi)
    1346:	48 8d 47 09          	lea    0x9(%rdi),%rax
    134a:	48 83 c7 0c          	add    $0xc,%rdi
    }

    for(int i = 0; i < NUM_ROWS; ++i)
        for(int j = 0; j < NUM_COLS; ++j)
            state_[j][i] = 0;
    134e:	c6 00 00             	movb   $0x0,(%rax)
    1351:	48 ff c0             	inc    %rax
    1354:	c6 40 02 00          	movb   $0x0,0x2(%rax)
    1358:	c6 40 05 00          	movb   $0x0,0x5(%rax)
    135c:	c6 40 08 00          	movb   $0x0,0x8(%rax)
    1360:	c6 40 0b 00          	movb   $0x0,0xb(%rax)
    for(int i = 0; i < NUM_ROWS; ++i)
    1364:	48 39 c7             	cmp    %rax,%rdi
    1367:	75 e5                	jne    134e <_ZN8EncodersC1Ev+0x1e>
    
    encoder_ = this;
}
    1369:	c3                   	retq   

000000000000136a <_ZN8Encoders9setRowPinEiN4GPIO3PinE>:

void Encoders::setRowPin(int row, GPIO::Pin pin)
{
    rowPins_[row] = pin;
    136a:	48 63 f6             	movslq %esi,%rsi
    136d:	88 54 37 01          	mov    %dl,0x1(%rdi,%rsi,1)

    GPIO::SetMode(pin, GPIO_MODE_INPUT, GPIO_PULLUP);
}
    1371:	c3                   	retq   

0000000000001372 <_ZN8Encoders9setColPinEiN4GPIO3PinE>:

void Encoders::setColPin(int col, GPIO::Pin pin)
{
    colPins_[col] = pin;
    1372:	48 63 f6             	movslq %esi,%rsi
    1375:	88 54 37 04          	mov    %dl,0x4(%rdi,%rsi,1)

    GPIO::SetMode(pin, GPIO_MODE_OUTPUT_OD, GPIO_NOPULL);
    GPIO::Write(pin, true);
}
    1379:	c3                   	retq   

000000000000137a <_ZN8Encoders4scanEv>:
    if(NUM_ENCODERS > 1 && colScanIdx_ != -1)
    {
        GPIO::Write(colPins_[colScanIdx_], true);
    }

    colScanIdx_++;
    137a:	8a 07                	mov    (%rdi),%al
    137c:	b2 00                	mov    $0x0,%dl
    137e:	ff c0                	inc    %eax
    1380:	3c 04                	cmp    $0x4,%al
    1382:	0f 4f c2             	cmovg  %edx,%eax
    1385:	88 07                	mov    %al,(%rdi)
        {
            value++;
        }

        values_[enc] = value;
        button_[enc] = btn;
    1387:	48 0f be c0          	movsbq %al,%rax
    138b:	c6 44 07 1d 01       	movb   $0x1,0x1d(%rdi,%rax,1)
    }

    for(int i = 0; i < NUM_ROWS; ++i)
    {
        state_[colScanIdx_][i] = currRowState[i];
    1390:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
    1394:	48 01 f8             	add    %rdi,%rax
    1397:	c6 40 09 00          	movb   $0x0,0x9(%rax)
    139b:	c6 40 0a 00          	movb   $0x0,0xa(%rax)
    139f:	c6 40 0b 00          	movb   $0x0,0xb(%rax)
    }
}
    13a3:	c3                   	retq   

00000000000013a4 <_Z13Timer_SleepUSl>:
}
    13a4:	c3                   	retq   

00000000000013a5 <_Z13assert_failedPKci>:
{
    13a5:	50                   	push   %rax
    13a6:	48 89 fa             	mov    %rdi,%rdx
    13a9:	89 f1                	mov    %esi,%ecx
}

__fortify_function int
printf (const char *__restrict __fmt, ...)
{
  return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
    13ab:	bf 01 00 00 00       	mov    $0x1,%edi
    13b0:	48 8d 35 4d 2c 00 00 	lea    0x2c4d(%rip),%rsi        # 4004 <_IO_stdin_used+0x4>
    13b7:	31 c0                	xor    %eax,%eax
    13b9:	e8 72 fc ff ff       	callq  1030 <__printf_chk@plt>
    __builtin_trap();
    13be:	0f 0b                	ud2    

00000000000013c0 <_Z12setupIndicesiiPiS_S_>:
    assert_param(numOps == 2 || numOps == 4);
    13c0:	8d 46 fe             	lea    -0x2(%rsi),%eax
{
    13c3:	41 51                	push   %r9
    assert_param(numOps == 2 || numOps == 4);
    13c5:	83 e0 fd             	and    $0xfffffffd,%eax
    13c8:	74 07                	je     13d1 <_Z12setupIndicesiiPiS_S_+0x11>
    13ca:	be 57 01 00 00       	mov    $0x157,%esi
    13cf:	eb 31                	jmp    1402 <_Z12setupIndicesiiPiS_S_+0x42>
    if (numOps == 2)
    13d1:	83 fe 02             	cmp    $0x2,%esi
    13d4:	48 63 ff             	movslq %edi,%rdi
    13d7:	75 4b                	jne    1424 <_Z12setupIndicesiiPiS_S_+0x64>
        op[0] = OPL3::MODE_2OP[0][ch];
    13d9:	48 8d 05 80 2d 00 00 	lea    0x2d80(%rip),%rax        # 4160 <_ZN4OPL3L8MODE_2OPE>
        op[2] = -1;
    13e0:	48 c7 42 08 ff ff ff 	movq   $0xffffffffffffffff,0x8(%rdx)
    13e7:	ff 
        op[0] = OPL3::MODE_2OP[0][ch];
    13e8:	44 0f be 0c 38       	movsbl (%rax,%rdi,1),%r9d
        op[1] = OPL3::MODE_2OP[1][ch];
    13ed:	0f be 44 38 12       	movsbl 0x12(%rax,%rdi,1),%eax
        op[0] = OPL3::MODE_2OP[0][ch];
    13f2:	44 89 0a             	mov    %r9d,(%rdx)
        assert_param(op[0] != -1);
    13f5:	41 ff c1             	inc    %r9d
        op[1] = OPL3::MODE_2OP[1][ch];
    13f8:	89 42 04             	mov    %eax,0x4(%rdx)
        assert_param(op[0] != -1);
    13fb:	75 11                	jne    140e <_Z12setupIndicesiiPiS_S_+0x4e>
    13fd:	be 5f 01 00 00       	mov    $0x15f,%esi
    1402:	48 8d 3d 11 2c 00 00 	lea    0x2c11(%rip),%rdi        # 401a <_IO_stdin_used+0x1a>
    1409:	e8 97 ff ff ff       	callq  13a5 <_Z13assert_failedPKci>
        assert_param(op[1] != -1);
    140e:	ff c0                	inc    %eax
    1410:	74 0b                	je     141d <_Z12setupIndicesiiPiS_S_+0x5d>
{
    1412:	31 c0                	xor    %eax,%eax
        arr[i] = OPL3::OP_OFF[opIdx][0];
    1414:	4c 8d 0d 85 2d 00 00 	lea    0x2d85(%rip),%r9        # 41a0 <_ZN4OPL3L6OP_OFFE>
    141b:	eb 7b                	jmp    1498 <_Z12setupIndicesiiPiS_S_+0xd8>
        assert_param(op[1] != -1);
    141d:	be 60 01 00 00       	mov    $0x160,%esi
    1422:	eb de                	jmp    1402 <_Z12setupIndicesiiPiS_S_+0x42>
        op[0] = OPL3::MODE_4OP[0][ch];
    1424:	48 8d 05 d5 2c 00 00 	lea    0x2cd5(%rip),%rax        # 4100 <_ZN4OPL3L8MODE_4OPE>
    142b:	44 0f be 1c 38       	movsbl (%rax,%rdi,1),%r11d
        op[1] = OPL3::MODE_4OP[1][ch];
    1430:	44 0f be 54 38 12    	movsbl 0x12(%rax,%rdi,1),%r10d
        op[2] = OPL3::MODE_4OP[2][ch];
    1436:	44 0f be 4c 38 24    	movsbl 0x24(%rax,%rdi,1),%r9d
        op[3] = OPL3::MODE_4OP[3][ch];
    143c:	0f be 44 38 36       	movsbl 0x36(%rax,%rdi,1),%eax
        op[0] = OPL3::MODE_4OP[0][ch];
    1441:	44 89 1a             	mov    %r11d,(%rdx)
        assert_param(op[0] != -1);
    1444:	41 ff c3             	inc    %r11d
        op[1] = OPL3::MODE_4OP[1][ch];
    1447:	44 89 52 04          	mov    %r10d,0x4(%rdx)
        op[2] = OPL3::MODE_4OP[2][ch];
    144b:	44 89 4a 08          	mov    %r9d,0x8(%rdx)
        op[3] = OPL3::MODE_4OP[3][ch];
    144f:	89 42 0c             	mov    %eax,0xc(%rdx)
        assert_param(op[0] != -1);
    1452:	75 07                	jne    145b <_Z12setupIndicesiiPiS_S_+0x9b>
    1454:	be 69 01 00 00       	mov    $0x169,%esi
    1459:	eb a7                	jmp    1402 <_Z12setupIndicesiiPiS_S_+0x42>
        assert_param(op[1] != -1);
    145b:	41 ff c2             	inc    %r10d
    145e:	75 07                	jne    1467 <_Z12setupIndicesiiPiS_S_+0xa7>
    1460:	be 6a 01 00 00       	mov    $0x16a,%esi
    1465:	eb 9b                	jmp    1402 <_Z12setupIndicesiiPiS_S_+0x42>
        assert_param(op[2] != -1);
    1467:	41 ff c1             	inc    %r9d
    146a:	75 07                	jne    1473 <_Z12setupIndicesiiPiS_S_+0xb3>
    146c:	be 6b 01 00 00       	mov    $0x16b,%esi
    1471:	eb 8f                	jmp    1402 <_Z12setupIndicesiiPiS_S_+0x42>
        assert_param(op[3] != -1);
    1473:	ff c0                	inc    %eax
    1475:	75 9b                	jne    1412 <_Z12setupIndicesiiPiS_S_+0x52>
    1477:	be 6c 01 00 00       	mov    $0x16c,%esi
    147c:	eb 84                	jmp    1402 <_Z12setupIndicesiiPiS_S_+0x42>
        arr[i] = OPL3::OP_OFF[opIdx][0];
    147e:	48 0f be ff          	movsbq %dil,%rdi
    1482:	45 0f be 14 79       	movsbl (%r9,%rdi,2),%r10d
        off[i] = OPL3::OP_OFF[opIdx][1];
    1487:	41 0f be 7c 79 01    	movsbl 0x1(%r9,%rdi,2),%edi
        arr[i] = OPL3::OP_OFF[opIdx][0];
    148d:	44 89 14 81          	mov    %r10d,(%rcx,%rax,4)
        off[i] = OPL3::OP_OFF[opIdx][1];
    1491:	41 89 3c 80          	mov    %edi,(%r8,%rax,4)
    1495:	48 ff c0             	inc    %rax
    for (int i = 0; i < numOps; ++i)
    1498:	39 c6                	cmp    %eax,%esi
    149a:	7e 13                	jle    14af <_Z12setupIndicesiiPiS_S_+0xef>
        const int8_t opIdx = op[i];
    149c:	8b 3c 82             	mov    (%rdx,%rax,4),%edi
        assert_param(opIdx >= 0 && opIdx < 36);
    149f:	40 80 ff 23          	cmp    $0x23,%dil
    14a3:	76 d9                	jbe    147e <_Z12setupIndicesiiPiS_S_+0xbe>
    14a5:	be 72 01 00 00       	mov    $0x172,%esi
    14aa:	e9 53 ff ff ff       	jmpq   1402 <_Z12setupIndicesiiPiS_S_+0x42>
} 
    14af:	58                   	pop    %rax
    14b0:	c3                   	retq   

00000000000014b1 <_Z12voice_updateR11VoiceParamsiif>:
{
    14b1:	41 54                	push   %r12
    assert_param(idx < arraySize(VOICE_CH));
    14b3:	48 63 f6             	movslq %esi,%rsi
{
    14b6:	55                   	push   %rbp
    14b7:	53                   	push   %rbx
    14b8:	48 83 ec 30          	sub    $0x30,%rsp
    14bc:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    14c3:	00 00 
    14c5:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    14ca:	31 c0                	xor    %eax,%eax
    assert_param(idx < arraySize(VOICE_CH));
    14cc:	48 83 fe 05          	cmp    $0x5,%rsi
    14d0:	76 11                	jbe    14e3 <_Z12voice_updateR11VoiceParamsiif+0x32>
    14d2:	be 7a 01 00 00       	mov    $0x17a,%esi
    14d7:	48 8d 3d 3c 2b 00 00 	lea    0x2b3c(%rip),%rdi        # 401a <_IO_stdin_used+0x1a>
    14de:	e8 c2 fe ff ff       	callq  13a5 <_Z13assert_failedPKci>
    const int numOps = params.conn < 2 ? 2 : 4;
    14e3:	8a 47 14             	mov    0x14(%rdi),%al
    14e6:	4c 8d 25 70 2b 00 00 	lea    0x2b70(%rip),%r12        # 405d <_IO_stdin_used+0x5d>
    14ed:	83 e0 0f             	and    $0xf,%eax
    14f0:	3c 02                	cmp    $0x2,%al
    14f2:	19 ed                	sbb    %ebp,%ebp
    int arr[4] = { -1, -1, -1, -1};
    14f4:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
    int off[4] = { -1, -1, -1, -1};
    14f8:	31 db                	xor    %ebx,%ebx
    int arr[4] = { -1, -1, -1, -1};
    14fa:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    const int numOps = params.conn < 2 ? 2 : 4;
    14ff:	83 e5 fe             	and    $0xfffffffe,%ebp
    int arr[4] = { -1, -1, -1, -1};
    1502:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    const int numOps = params.conn < 2 ? 2 : 4;
    1507:	83 c5 04             	add    $0x4,%ebp
    int off[4] = { -1, -1, -1, -1};
    150a:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    150f:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    1514:	89 da                	mov    %ebx,%edx
    1516:	4c 89 e6             	mov    %r12,%rsi
    1519:	bf 01 00 00 00       	mov    $0x1,%edi
    151e:	31 c0                	xor    %eax,%eax
    1520:	e8 0b fb ff ff       	callq  1030 <__printf_chk@plt>
    1525:	44 8b 44 9c 08       	mov    0x8(%rsp,%rbx,4),%r8d
    152a:	89 da                	mov    %ebx,%edx
    152c:	89 e9                	mov    %ebp,%ecx
    152e:	48 8d 35 32 2b 00 00 	lea    0x2b32(%rip),%rsi        # 4067 <_IO_stdin_used+0x67>
    1535:	bf 01 00 00 00       	mov    $0x1,%edi
    153a:	31 c0                	xor    %eax,%eax
    153c:	e8 ef fa ff ff       	callq  1030 <__printf_chk@plt>
    1541:	44 8b 44 9c 18       	mov    0x18(%rsp,%rbx,4),%r8d
    1546:	89 da                	mov    %ebx,%edx
    1548:	89 e9                	mov    %ebp,%ecx
    154a:	48 8d 35 28 2b 00 00 	lea    0x2b28(%rip),%rsi        # 4079 <_IO_stdin_used+0x79>
    1551:	bf 01 00 00 00       	mov    $0x1,%edi
    1556:	31 c0                	xor    %eax,%eax
    1558:	48 ff c3             	inc    %rbx
    155b:	e8 d0 fa ff ff       	callq  1030 <__printf_chk@plt>
        assert_param(i < 2);
    1560:	eb b2                	jmp    1514 <_Z12voice_updateR11VoiceParamsiif+0x63>

0000000000001562 <_Z12ExampleInputtt>:
}
    1562:	c3                   	retq   

0000000000001563 <_Z11ExampleTickR6CanvasR13DisplayST7735>:
{  
    1563:	50                   	push   %rax
    static VoiceParams oldVoice;
    1564:	8a 05 2e 5b 00 00    	mov    0x5b2e(%rip),%al        # 7098 <_ZGVZ11ExampleTickR6CanvasR13DisplayST7735E8oldVoice>
    156a:	84 c0                	test   %al,%al
    156c:	75 28                	jne    1596 <_Z11ExampleTickR6CanvasR13DisplayST7735+0x33>
    156e:	48 8d 3d 23 5b 00 00 	lea    0x5b23(%rip),%rdi        # 7098 <_ZGVZ11ExampleTickR6CanvasR13DisplayST7735E8oldVoice>
    1575:	e8 06 fb ff ff       	callq  1080 <__cxa_guard_acquire@plt>
    157a:	85 c0                	test   %eax,%eax
    157c:	74 18                	je     1596 <_Z11ExampleTickR6CanvasR13DisplayST7735+0x33>
    157e:	48 8d 3d 1b 5b 00 00 	lea    0x5b1b(%rip),%rdi        # 70a0 <_ZZ11ExampleTickR6CanvasR13DisplayST7735E8oldVoice>
    1585:	e8 c4 01 00 00       	callq  174e <_ZN11VoiceParamsC1Ev>
    158a:	48 8d 3d 07 5b 00 00 	lea    0x5b07(%rip),%rdi        # 7098 <_ZGVZ11ExampleTickR6CanvasR13DisplayST7735E8oldVoice>
    1591:	e8 aa fa ff ff       	callq  1040 <__cxa_guard_release@plt>
    voice_update(voice, 0, 16, -1);
    1596:	f3 0f 10 05 4a 2c 00 	movss  0x2c4a(%rip),%xmm0        # 41e8 <_ZN4OPL3L6OP_OFFE+0x48>
    159d:	00 
    159e:	ba 10 00 00 00       	mov    $0x10,%edx
    15a3:	31 f6                	xor    %esi,%esi
    15a5:	48 8d 3d 1c 5b 00 00 	lea    0x5b1c(%rip),%rdi        # 70c8 <_ZL6params+0x8>
    15ac:	e8 00 ff ff ff       	callq  14b1 <_Z12voice_updateR11VoiceParamsiif>

00000000000015b1 <_putchar>:
}
    15b1:	c3                   	retq   

00000000000015b2 <_Z9voice_keyR11VoiceParamsib>:
{
    15b2:	53                   	push   %rbx
    const int ch = VOICE_CH[idx];
    15b3:	48 63 f6             	movslq %esi,%rsi
{
    15b6:	89 d3                	mov    %edx,%ebx
    15b8:	48 83 ec 40          	sub    $0x40,%rsp
    15bc:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    15c3:	00 00 
    15c5:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    15ca:	31 c0                	xor    %eax,%eax
    setupIndices(ch, numOps, op, arr, off);
    15cc:	48 8d 4c 24 18       	lea    0x18(%rsp),%rcx
    15d1:	4c 8d 44 24 28       	lea    0x28(%rsp),%r8
    const int ch = VOICE_CH[idx];
    15d6:	48 8d 05 03 2b 00 00 	lea    0x2b03(%rip),%rax        # 40e0 <_ZL8VOICE_CH>
    setupIndices(ch, numOps, op, arr, off);
    15dd:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    const int ch = VOICE_CH[idx];
    15e2:	44 8b 0c b0          	mov    (%rax,%rsi,4),%r9d
    const int numOps = params.conn < 2 ? 2 : 4;
    15e6:	8a 47 14             	mov    0x14(%rdi),%al
    15e9:	83 e0 0f             	and    $0xf,%eax
    setupIndices(ch, numOps, op, arr, off);
    15ec:	44 89 cf             	mov    %r9d,%edi
    const int numOps = params.conn < 2 ? 2 : 4;
    15ef:	3c 02                	cmp    $0x2,%al
    15f1:	19 f6                	sbb    %esi,%esi
    int arr[4] = { -1, -1, -1, -1};
    15f3:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
    const int numOps = params.conn < 2 ? 2 : 4;
    15f7:	83 e6 fe             	and    $0xfffffffe,%esi
    int arr[4] = { -1, -1, -1, -1};
    15fa:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    const int numOps = params.conn < 2 ? 2 : 4;
    15ff:	83 c6 04             	add    $0x4,%esi
    int arr[4] = { -1, -1, -1, -1};
    1602:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    int off[4] = { -1, -1, -1, -1};
    1607:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    160c:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    setupIndices(ch, numOps, op, arr, off);
    1611:	e8 aa fd ff ff       	callq  13c0 <_Z12setupIndicesiiPiS_S_>
    if (keyon)
    1616:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
    161a:	8b 74 24 18          	mov    0x18(%rsp),%esi
    161e:	84 db                	test   %bl,%bl
        opl3.setRegister(arr[0], OPL3::Register::KEY_ON, off[0], 1);
    1620:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    1626:	0f b6 c9             	movzbl %cl,%ecx
    1629:	40 0f b6 f6          	movzbl %sil,%esi
    if (keyon)
    162d:	75 03                	jne    1632 <_Z9voice_keyR11VoiceParamsib+0x80>
        opl3.setRegister(arr[0], OPL3::Register::KEY_ON, off[0], 0);
    162f:	45 31 c0             	xor    %r8d,%r8d
    1632:	ba b0 15 00 00       	mov    $0x15b0,%edx
    1637:	48 8d 3d 22 61 00 00 	lea    0x6122(%rip),%rdi        # 7760 <_ZL4opl3>
    163e:	e8 47 01 00 00       	callq  178a <_ZN4OPL39InterfaceINS_15ICTransportNullEE11setRegisterEhNS_8RegisterEhh>
}
    1643:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    1648:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    164f:	00 00 
    1651:	74 05                	je     1658 <_Z9voice_keyR11VoiceParamsib+0xa6>
    1653:	e8 18 fa ff ff       	callq  1070 <__stack_chk_fail@plt>
    1658:	48 83 c4 40          	add    $0x40,%rsp
    165c:	5b                   	pop    %rbx
    165d:	c3                   	retq   

000000000000165e <_Z11ExampleInitv>:
	  void clearRegisters()
	  {
  		for(int i = 0; i < 2; ++i)
  		  for(int j = 0; j < 256; ++j)
  		  {
  			  regs_[i][j] = 0;
    165e:	4c 8d 0d 03 61 00 00 	lea    0x6103(%rip),%r9        # 7768 <_ZL4opl3+0x8>
{
    1665:	52                   	push   %rdx
    1666:	31 c9                	xor    %ecx,%ecx
  		return dirty_[arr][reg >> 6] & (1ULL << (reg & 0x3f));
	  }

	  void setDirty(uint8_t arr, uint8_t reg)
	  {
  		dirty_[arr][reg >> 6] |= (1ULL << (reg & 0x3f));    
    1668:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    166e:	49 8d 51 f8          	lea    -0x8(%r9),%rdx
    1672:	48 89 d6             	mov    %rdx,%rsi
    1675:	89 c8                	mov    %ecx,%eax
    1677:	4c 89 c7             	mov    %r8,%rdi
  			  regs_[i][j] = 0;
    167a:	41 c6 04 09 00       	movb   $0x0,(%r9,%rcx,1)
	  void setDirty(uint8_t arr, uint8_t reg)
    167f:	c1 f8 06             	sar    $0x6,%eax
  		dirty_[arr][reg >> 6] |= (1ULL << (reg & 0x3f));    
    1682:	48 d3 e7             	shl    %cl,%rdi
    1685:	48 ff c1             	inc    %rcx
    1688:	48 98                	cltq   
    168a:	48 09 bc c2 08 02 00 	or     %rdi,0x208(%rdx,%rax,8)
    1691:	00 
  		  for(int j = 0; j < 256; ++j)
    1692:	48 81 f9 00 01 00 00 	cmp    $0x100,%rcx
    1699:	75 da                	jne    1675 <_Z11ExampleInitv+0x17>
    169b:	31 c9                	xor    %ecx,%ecx
  			  regs_[i][j] = 0;
    169d:	4c 8d 05 c4 61 00 00 	lea    0x61c4(%rip),%r8        # 7868 <_ZL4opl3+0x108>
  		dirty_[arr][reg >> 6] |= (1ULL << (reg & 0x3f));    
    16a4:	bf 01 00 00 00       	mov    $0x1,%edi
    16a9:	89 c8                	mov    %ecx,%eax
    16ab:	48 89 fa             	mov    %rdi,%rdx
  			  regs_[i][j] = 0;
    16ae:	41 c6 04 08 00       	movb   $0x0,(%r8,%rcx,1)
	  void setDirty(uint8_t arr, uint8_t reg)
    16b3:	c1 f8 06             	sar    $0x6,%eax
  		dirty_[arr][reg >> 6] |= (1ULL << (reg & 0x3f));    
    16b6:	48 d3 e2             	shl    %cl,%rdx
    16b9:	48 ff c1             	inc    %rcx
    16bc:	48 98                	cltq   
    16be:	48 09 94 c6 28 02 00 	or     %rdx,0x228(%rsi,%rax,8)
    16c5:	00 
  		  for(int j = 0; j < 256; ++j)
    16c6:	48 81 f9 00 01 00 00 	cmp    $0x100,%rcx
    16cd:	75 da                	jne    16a9 <_Z11ExampleInitv+0x4b>
    opl3.setRegister(0, OPL3::Register::WS_ENABLE, 0, 1);
    16cf:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    16d5:	31 c9                	xor    %ecx,%ecx
    16d7:	ba 01 15 00 00       	mov    $0x1501,%edx
    16dc:	31 f6                	xor    %esi,%esi
    16de:	48 8d 3d 7b 60 00 00 	lea    0x607b(%rip),%rdi        # 7760 <_ZL4opl3>
    16e5:	e8 a0 00 00 00       	callq  178a <_ZN4OPL39InterfaceINS_15ICTransportNullEE11setRegisterEhNS_8RegisterEhh>
    opl3.setRegister(0, OPL3::Register::TEST_REG, 0, 0);
    16ea:	45 31 c0             	xor    %r8d,%r8d
    16ed:	31 c9                	xor    %ecx,%ecx
    16ef:	ba 01 50 00 00       	mov    $0x5001,%edx
    16f4:	31 f6                	xor    %esi,%esi
    16f6:	48 8d 3d 63 60 00 00 	lea    0x6063(%rip),%rdi        # 7760 <_ZL4opl3>
    16fd:	e8 88 00 00 00       	callq  178a <_ZN4OPL39InterfaceINS_15ICTransportNullEE11setRegisterEhNS_8RegisterEhh>
    opl3.setRegister(1, OPL3::Register::OPL3, 0, 1);
    1702:	31 c9                	xor    %ecx,%ecx
    1704:	ba 05 10 00 00       	mov    $0x1005,%edx
    1709:	48 8d 3d 50 60 00 00 	lea    0x6050(%rip),%rdi        # 7760 <_ZL4opl3>
    1710:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    1716:	be 01 00 00 00       	mov    $0x1,%esi
    171b:	e8 6a 00 00 00       	callq  178a <_ZN4OPL39InterfaceINS_15ICTransportNullEE11setRegisterEhNS_8RegisterEhh>
    1720:	48 8d 15 41 62 00 00 	lea    0x6241(%rip),%rdx        # 7968 <_ZL4opl3+0x208>
    1727:	31 c0                	xor    %eax,%eax
    1729:	b9 10 00 00 00       	mov    $0x10,%ecx
    172e:	48 89 d7             	mov    %rdx,%rdi
    1731:	f3 ab                	rep stos %eax,%es:(%rdi)
}
    1733:	58                   	pop    %rax
    1734:	c3                   	retq   
    1735:	90                   	nop

0000000000001736 <_ZN10TileCanvasILs64ELs32ELs128ELs128EED1Ev>:
class TileCanvas : public BaseTileCanvas
    1736:	48 8d 05 0b 56 00 00 	lea    0x560b(%rip),%rax        # 6d48 <_ZTV10TileCanvasILs64ELs32ELs128ELs128EE+0x10>
    173d:	48 89 07             	mov    %rax,(%rdi)
    1740:	e9 a1 1e 00 00       	jmpq   35e6 <_ZN14BaseTileCanvasD1Ev>
    1745:	90                   	nop

0000000000001746 <_ZN14OperatorParamsC1Ev>:
    , en_vib(0)
    1746:	c7 07 77 77 00 00    	movl   $0x7777,(%rdi)
  {}
    174c:	c3                   	retq   
    174d:	90                   	nop

000000000000174e <_ZN11VoiceParamsC1Ev>:
  VoiceParams()
    174e:	53                   	push   %rbx
    174f:	48 89 fb             	mov    %rdi,%rbx
    , ops({})
    1752:	e8 ef ff ff ff       	callq  1746 <_ZN14OperatorParamsC1Ev>
    1757:	48 8d 7b 04          	lea    0x4(%rbx),%rdi
    175b:	e8 e6 ff ff ff       	callq  1746 <_ZN14OperatorParamsC1Ev>
    1760:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
    1764:	e8 dd ff ff ff       	callq  1746 <_ZN14OperatorParamsC1Ev>
    1769:	48 8d 7b 0c          	lea    0xc(%rbx),%rdi
    176d:	e8 d4 ff ff ff       	callq  1746 <_ZN14OperatorParamsC1Ev>
    1772:	8b 43 14             	mov    0x14(%rbx),%eax
    1775:	c7 43 10 00 00 dc 43 	movl   $0x43dc0000,0x10(%rbx)
    177c:	66 25 00 f0          	and    $0xf000,%ax
    1780:	80 cc 0f             	or     $0xf,%ah
    1783:	66 89 43 14          	mov    %ax,0x14(%rbx)
  {}
    1787:	5b                   	pop    %rbx
    1788:	c3                   	retq   
    1789:	90                   	nop

000000000000178a <_ZN4OPL39InterfaceINS_15ICTransportNullEE11setRegisterEhNS_8RegisterEhh>:
	  void setRegister(uint8_t arr, Register reg, uint8_t off, uint8_t val)
    178a:	44 0f b6 de          	movzbl %sil,%r11d
  		const uint16_t bit = (uint16_t(reg) >> 8) & 0xf;
    178e:	0f b6 c6             	movzbl %dh,%eax
  		const auto old = regs_[arr][addr];
    1791:	40 0f b6 f6          	movzbl %sil,%esi
	  void setRegister(uint8_t arr, Register reg, uint8_t off, uint8_t val)
    1795:	55                   	push   %rbp
  		const uint8_t addr = uint8_t(reg) + off;
    1796:	44 8d 14 11          	lea    (%rcx,%rdx,1),%r10d
  		const uint16_t mask = ~(((1 << bits) - 1) << bit);
    179a:	83 e0 0f             	and    $0xf,%eax
  		const auto old = regs_[arr][addr];
    179d:	48 c1 e6 08          	shl    $0x8,%rsi
  		const uint16_t bits = (uint16_t(reg) >> 12) & 0xf;
    17a1:	89 d1                	mov    %edx,%ecx
  		const uint16_t mask = ~(((1 << bits) - 1) << bit);
    17a3:	89 c5                	mov    %eax,%ebp
  		const auto old = regs_[arr][addr];
    17a5:	48 01 fe             	add    %rdi,%rsi
    17a8:	41 0f b6 c2          	movzbl %r10b,%eax
  		const uint16_t bits = (uint16_t(reg) >> 12) & 0xf;
    17ac:	66 c1 e9 0c          	shr    $0xc,%cx
  		const auto old = regs_[arr][addr];
    17b0:	48 01 c6             	add    %rax,%rsi
  		const uint16_t mask = ~(((1 << bits) - 1) << bit);
    17b3:	0f b7 c9             	movzwl %cx,%ecx
  		const auto old = regs_[arr][addr];
    17b6:	49 89 c1             	mov    %rax,%r9
  		const uint16_t mask = ~(((1 << bits) - 1) << bit);
    17b9:	b8 01 00 00 00       	mov    $0x1,%eax
    17be:	d3 e0                	shl    %cl,%eax
    17c0:	89 e9                	mov    %ebp,%ecx
	  void setRegister(uint8_t arr, Register reg, uint8_t off, uint8_t val)
    17c2:	53                   	push   %rbx
  		const auto old = regs_[arr][addr];
    17c3:	8a 5e 08             	mov    0x8(%rsi),%bl
  		const uint16_t mask = ~(((1 << bits) - 1) << bit);
    17c6:	ff c8                	dec    %eax
  		regs_[arr][addr] |= (val << bit); 
    17c8:	45 0f b6 c0          	movzbl %r8b,%r8d
  		const uint16_t mask = ~(((1 << bits) - 1) << bit);
    17cc:	d3 e0                	shl    %cl,%eax
  		regs_[arr][addr] |= (val << bit); 
    17ce:	41 d3 e0             	shl    %cl,%r8d
  		const uint16_t mask = ~(((1 << bits) - 1) << bit);
    17d1:	f7 d0                	not    %eax
  		regs_[arr][addr] &= mask;
    17d3:	21 d8                	and    %ebx,%eax
  		regs_[arr][addr] |= (val << bit); 
    17d5:	41 09 c0             	or     %eax,%r8d
    17d8:	44 88 46 08          	mov    %r8b,0x8(%rsi)
  		if(old != regs_[arr][addr] || reg == OPL3::Register::KEY_ON)
    17dc:	66 81 fa b0 15       	cmp    $0x15b0,%dx
    17e1:	74 05                	je     17e8 <_ZN4OPL39InterfaceINS_15ICTransportNullEE11setRegisterEhNS_8RegisterEhh+0x5e>
    17e3:	41 38 d8             	cmp    %bl,%r8b
    17e6:	74 1e                	je     1806 <_ZN4OPL39InterfaceINS_15ICTransportNullEE11setRegisterEhNS_8RegisterEhh+0x7c>
  		dirty_[arr][reg >> 6] |= (1ULL << (reg & 0x3f));    
    17e8:	41 c1 f9 06          	sar    $0x6,%r9d
    17ec:	b8 01 00 00 00       	mov    $0x1,%eax
    17f1:	44 89 d1             	mov    %r10d,%ecx
    17f4:	4d 63 c9             	movslq %r9d,%r9
    17f7:	48 d3 e0             	shl    %cl,%rax
    17fa:	4b 8d 14 99          	lea    (%r9,%r11,4),%rdx
    17fe:	48 09 84 d7 08 02 00 	or     %rax,0x208(%rdi,%rdx,8)
    1805:	00 
	  }
    1806:	5b                   	pop    %rbx
    1807:	5d                   	pop    %rbp
    1808:	c3                   	retq   

0000000000001809 <_out_buffer>:


// internal buffer output
static inline void _out_buffer(char character, void* buffer, size_t idx, size_t maxlen)
{
  if (idx < maxlen) {
    1809:	48 39 ca             	cmp    %rcx,%rdx
    180c:	73 04                	jae    1812 <_out_buffer+0x9>
    ((char*)buffer)[idx] = character;
    180e:	40 88 3c 16          	mov    %dil,(%rsi,%rdx,1)
  }
}
    1812:	c3                   	retq   

0000000000001813 <_out_null>:

// internal null output
static inline void _out_null(char character, void* buffer, size_t idx, size_t maxlen)
{
  (void)character; (void)buffer; (void)idx; (void)maxlen;
}
    1813:	c3                   	retq   

0000000000001814 <_ntoa_long>:
}


// internal itoa for 'long' type
static size_t _ntoa_long(out_fct_type out, char* buffer, size_t idx, size_t maxlen, unsigned long value, bool negative, unsigned long base, unsigned int prec, unsigned int width, unsigned int flags)
{
    1814:	41 57                	push   %r15
    1816:	41 56                	push   %r14
    1818:	41 55                	push   %r13
    181a:	41 54                	push   %r12
    181c:	55                   	push   %rbp
    181d:	48 89 fd             	mov    %rdi,%rbp
    1820:	53                   	push   %rbx
    1821:	48 89 d3             	mov    %rdx,%rbx
    1824:	48 83 ec 58          	sub    $0x58,%rsp
    1828:	48 89 34 24          	mov    %rsi,(%rsp)
    182c:	44 8b bc 24 98 00 00 	mov    0x98(%rsp),%r15d
    1833:	00 
    1834:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
    1839:	48 8b b4 24 90 00 00 	mov    0x90(%rsp),%rsi
    1840:	00 
    1841:	8b 8c 24 a8 00 00 00 	mov    0xa8(%rsp),%ecx
    1848:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    184f:	00 00 
    1851:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
    1856:	31 c0                	xor    %eax,%eax
  char buf[PRINTF_NTOA_BUFFER_SIZE];
  size_t len = 0U;

  // no hash for 0 values
  if (!value) {
    1858:	4d 85 c0             	test   %r8,%r8
    185b:	75 03                	jne    1860 <_ntoa_long+0x4c>
    flags &= ~FLAGS_HASH;
    185d:	83 e1 ef             	and    $0xffffffef,%ecx
  }

  // write if precision != 0 and value is != 0
  if (!(flags & FLAGS_PRECISION) || value) {
    1860:	41 89 cb             	mov    %ecx,%r11d
    1863:	41 81 e3 00 04 00 00 	and    $0x400,%r11d
    186a:	74 08                	je     1874 <_ntoa_long+0x60>
  size_t len = 0U;
    186c:	45 31 e4             	xor    %r12d,%r12d
  if (!(flags & FLAGS_PRECISION) || value) {
    186f:	4d 85 c0             	test   %r8,%r8
    1872:	74 46                	je     18ba <_ntoa_long+0xa6>
    do {
      const char digit = (char)(value % base);
      buf[len++] = digit < 10 ? '0' + digit : (flags & FLAGS_UPPERCASE ? 'A' : 'a') + digit - 10;
    1874:	89 c8                	mov    %ecx,%eax
    1876:	4c 8d 6c 24 27       	lea    0x27(%rsp),%r13
    187b:	83 e0 20             	and    $0x20,%eax
    187e:	83 f8 01             	cmp    $0x1,%eax
    1881:	19 ff                	sbb    %edi,%edi
    1883:	45 31 e4             	xor    %r12d,%r12d
    1886:	83 e7 20             	and    $0x20,%edi
    1889:	83 c7 37             	add    $0x37,%edi
      const char digit = (char)(value % base);
    188c:	4c 89 c0             	mov    %r8,%rax
    188f:	31 d2                	xor    %edx,%edx
    1891:	48 f7 f6             	div    %rsi
      buf[len++] = digit < 10 ? '0' + digit : (flags & FLAGS_UPPERCASE ? 'A' : 'a') + digit - 10;
    1894:	44 8d 34 17          	lea    (%rdi,%rdx,1),%r14d
    1898:	48 83 fa 09          	cmp    $0x9,%rdx
    189c:	77 04                	ja     18a2 <_ntoa_long+0x8e>
    189e:	44 8d 72 30          	lea    0x30(%rdx),%r14d
    18a2:	49 ff c4             	inc    %r12
    18a5:	47 88 74 25 00       	mov    %r14b,0x0(%r13,%r12,1)
      value /= base;
    } while (value && (len < PRINTF_NTOA_BUFFER_SIZE));
    18aa:	49 39 f0             	cmp    %rsi,%r8
    18ad:	72 0b                	jb     18ba <_ntoa_long+0xa6>
    18af:	49 83 fc 1f          	cmp    $0x1f,%r12
    18b3:	77 05                	ja     18ba <_ntoa_long+0xa6>
      value /= base;
    18b5:	49 89 c0             	mov    %rax,%r8
    18b8:	eb d2                	jmp    188c <_ntoa_long+0x78>
  if (!(flags & FLAGS_LEFT)) {
    18ba:	89 c8                	mov    %ecx,%eax
      buf[len++] = '0';
    18bc:	48 8d 54 24 27       	lea    0x27(%rsp),%rdx
  if (!(flags & FLAGS_LEFT)) {
    18c1:	83 e0 02             	and    $0x2,%eax
    18c4:	89 44 24 14          	mov    %eax,0x14(%rsp)
    while ((len < prec) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
    18c8:	44 89 f8             	mov    %r15d,%eax
  if (!(flags & FLAGS_LEFT)) {
    18cb:	75 3f                	jne    190c <_ntoa_long+0xf8>
    while ((len < prec) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
    18cd:	49 83 fc 1f          	cmp    $0x1f,%r12
    18d1:	77 0f                	ja     18e2 <_ntoa_long+0xce>
    18d3:	49 39 c4             	cmp    %rax,%r12
    18d6:	73 0a                	jae    18e2 <_ntoa_long+0xce>
      buf[len++] = '0';
    18d8:	49 ff c4             	inc    %r12
    18db:	42 c6 04 22 30       	movb   $0x30,(%rdx,%r12,1)
    18e0:	eb eb                	jmp    18cd <_ntoa_long+0xb9>
    while ((flags & FLAGS_ZEROPAD) && (len < width) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
    18e2:	89 c8                	mov    %ecx,%eax
    18e4:	8b 94 24 a0 00 00 00 	mov    0xa0(%rsp),%edx
      buf[len++] = '0';
    18eb:	48 8d 7c 24 27       	lea    0x27(%rsp),%rdi
    while ((flags & FLAGS_ZEROPAD) && (len < width) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
    18f0:	83 e0 01             	and    $0x1,%eax
    18f3:	85 c0                	test   %eax,%eax
    18f5:	74 15                	je     190c <_ntoa_long+0xf8>
    18f7:	49 39 d4             	cmp    %rdx,%r12
    18fa:	73 10                	jae    190c <_ntoa_long+0xf8>
    18fc:	49 83 fc 1f          	cmp    $0x1f,%r12
    1900:	77 0a                	ja     190c <_ntoa_long+0xf8>
      buf[len++] = '0';
    1902:	49 ff c4             	inc    %r12
    1905:	42 c6 04 27 30       	movb   $0x30,(%rdi,%r12,1)
    190a:	eb e7                	jmp    18f3 <_ntoa_long+0xdf>
  if (flags & FLAGS_HASH) {
    190c:	f6 c1 10             	test   $0x10,%cl
    190f:	0f 84 87 00 00 00    	je     199c <_ntoa_long+0x188>
    if (!(flags & FLAGS_PRECISION) && len && ((len == prec) || (len == width))) {
    1915:	45 85 db             	test   %r11d,%r11d
    1918:	75 2d                	jne    1947 <_ntoa_long+0x133>
    191a:	4d 85 e4             	test   %r12,%r12
    191d:	74 28                	je     1947 <_ntoa_long+0x133>
    191f:	4d 39 fc             	cmp    %r15,%r12
    1922:	74 0c                	je     1930 <_ntoa_long+0x11c>
    1924:	8b 84 24 a0 00 00 00 	mov    0xa0(%rsp),%eax
    192b:	49 39 c4             	cmp    %rax,%r12
    192e:	75 17                	jne    1947 <_ntoa_long+0x133>
      if (len && (base == 16U)) {
    1930:	49 8d 44 24 ff       	lea    -0x1(%r12),%rax
    1935:	49 83 fc 01          	cmp    $0x1,%r12
    1939:	74 09                	je     1944 <_ntoa_long+0x130>
        len--;
    193b:	49 83 ec 02          	sub    $0x2,%r12
      if (len && (base == 16U)) {
    193f:	83 fe 10             	cmp    $0x10,%esi
    1942:	74 09                	je     194d <_ntoa_long+0x139>
      len--;
    1944:	49 89 c4             	mov    %rax,%r12
    if ((base == 16U) && !(flags & FLAGS_UPPERCASE) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
    1947:	48 83 fe 10          	cmp    $0x10,%rsi
    194b:	75 2a                	jne    1977 <_ntoa_long+0x163>
    194d:	49 83 fc 1f          	cmp    $0x1f,%r12
    1951:	89 ca                	mov    %ecx,%edx
    1953:	0f 96 c0             	setbe  %al
    1956:	83 e2 20             	and    $0x20,%edx
    1959:	75 0c                	jne    1967 <_ntoa_long+0x153>
    195b:	84 c0                	test   %al,%al
    195d:	74 08                	je     1967 <_ntoa_long+0x153>
      buf[len++] = 'x';
    195f:	42 c6 44 24 28 78    	movb   $0x78,0x28(%rsp,%r12,1)
    1965:	eb 21                	jmp    1988 <_ntoa_long+0x174>
    else if ((base == 16U) && (flags & FLAGS_UPPERCASE) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
    1967:	85 d2                	test   %edx,%edx
    1969:	74 20                	je     198b <_ntoa_long+0x177>
    196b:	84 c0                	test   %al,%al
    196d:	74 1c                	je     198b <_ntoa_long+0x177>
      buf[len++] = 'X';
    196f:	42 c6 44 24 28 58    	movb   $0x58,0x28(%rsp,%r12,1)
    1975:	eb 11                	jmp    1988 <_ntoa_long+0x174>
    else if ((base == 2U) && (len < PRINTF_NTOA_BUFFER_SIZE)) {
    1977:	83 fe 02             	cmp    $0x2,%esi
    197a:	75 0f                	jne    198b <_ntoa_long+0x177>
    197c:	49 83 fc 1f          	cmp    $0x1f,%r12
    1980:	77 09                	ja     198b <_ntoa_long+0x177>
      buf[len++] = 'b';
    1982:	42 c6 44 24 28 62    	movb   $0x62,0x28(%rsp,%r12,1)
    1988:	49 ff c4             	inc    %r12
    if (len < PRINTF_NTOA_BUFFER_SIZE) {
    198b:	49 83 fc 1f          	cmp    $0x1f,%r12
    198f:	77 10                	ja     19a1 <_ntoa_long+0x18d>
      buf[len++] = '0';
    1991:	42 c6 44 24 28 30    	movb   $0x30,0x28(%rsp,%r12,1)
    1997:	49 ff c4             	inc    %r12
    199a:	eb 05                	jmp    19a1 <_ntoa_long+0x18d>
  if (len && (len == width) && (negative || (flags & FLAGS_PLUS) || (flags & FLAGS_SPACE))) {
    199c:	4d 85 e4             	test   %r12,%r12
    199f:	74 1f                	je     19c0 <_ntoa_long+0x1ac>
    19a1:	8b 84 24 a0 00 00 00 	mov    0xa0(%rsp),%eax
    19a8:	4c 39 e0             	cmp    %r12,%rax
    19ab:	75 0d                	jne    19ba <_ntoa_long+0x1a6>
    19ad:	45 84 c9             	test   %r9b,%r9b
    19b0:	75 05                	jne    19b7 <_ntoa_long+0x1a3>
    19b2:	f6 c1 0c             	test   $0xc,%cl
    19b5:	74 16                	je     19cd <_ntoa_long+0x1b9>
    len--;
    19b7:	49 ff cc             	dec    %r12
  if (len < PRINTF_NTOA_BUFFER_SIZE) {
    19ba:	49 83 fc 1f          	cmp    $0x1f,%r12
    19be:	77 2e                	ja     19ee <_ntoa_long+0x1da>
    if (negative) {
    19c0:	45 84 c9             	test   %r9b,%r9b
    19c3:	74 0e                	je     19d3 <_ntoa_long+0x1bf>
      buf[len++] = '-';
    19c5:	42 c6 44 24 28 2d    	movb   $0x2d,0x28(%rsp,%r12,1)
    19cb:	eb 1e                	jmp    19eb <_ntoa_long+0x1d7>
  if (len < PRINTF_NTOA_BUFFER_SIZE) {
    19cd:	49 83 fc 1f          	cmp    $0x1f,%r12
    19d1:	77 1b                	ja     19ee <_ntoa_long+0x1da>
    else if (flags & FLAGS_PLUS) {
    19d3:	f6 c1 04             	test   $0x4,%cl
    19d6:	74 08                	je     19e0 <_ntoa_long+0x1cc>
      buf[len++] = '+';  // ignore the space if the '+' exists
    19d8:	42 c6 44 24 28 2b    	movb   $0x2b,0x28(%rsp,%r12,1)
    19de:	eb 0b                	jmp    19eb <_ntoa_long+0x1d7>
    else if (flags & FLAGS_SPACE) {
    19e0:	f6 c1 08             	test   $0x8,%cl
    19e3:	74 09                	je     19ee <_ntoa_long+0x1da>
      buf[len++] = ' ';
    19e5:	42 c6 44 24 28 20    	movb   $0x20,0x28(%rsp,%r12,1)
    19eb:	49 ff c4             	inc    %r12
  if (!(flags & FLAGS_LEFT) && !(flags & FLAGS_ZEROPAD)) {
    19ee:	80 e1 03             	and    $0x3,%cl
    19f1:	49 89 dd             	mov    %rbx,%r13
    19f4:	74 0e                	je     1a04 <_ntoa_long+0x1f0>
    19f6:	4c 8d 74 24 28       	lea    0x28(%rsp),%r14
    19fb:	4c 89 ea             	mov    %r13,%rdx
    19fe:	4f 8d 3c 26          	lea    (%r14,%r12,1),%r15
    1a02:	eb 32                	jmp    1a36 <_ntoa_long+0x222>
    for (size_t i = len; i < width; i++) {
    1a04:	4d 89 e6             	mov    %r12,%r14
    1a07:	49 29 de             	sub    %rbx,%r14
    1a0a:	8b 94 24 a0 00 00 00 	mov    0xa0(%rsp),%edx
    1a11:	4b 8d 0c 2e          	lea    (%r14,%r13,1),%rcx
    1a15:	48 39 d1             	cmp    %rdx,%rcx
    1a18:	73 dc                	jae    19f6 <_ntoa_long+0x1e2>
      out(' ', buffer, idx++, maxlen);
    1a1a:	4d 8d 7d 01          	lea    0x1(%r13),%r15
    1a1e:	4c 89 ea             	mov    %r13,%rdx
    1a21:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    1a26:	48 8b 34 24          	mov    (%rsp),%rsi
    1a2a:	bf 20 00 00 00       	mov    $0x20,%edi
    1a2f:	4d 89 fd             	mov    %r15,%r13
    1a32:	ff d5                	callq  *%rbp
    1a34:	eb d4                	jmp    1a0a <_ntoa_long+0x1f6>
  for (size_t i = 0U; i < len; i++) {
    1a36:	4d 39 fe             	cmp    %r15,%r14
    1a39:	74 23                	je     1a5e <_ntoa_long+0x24a>
    out(buf[len - i - 1U], buffer, idx++, maxlen);
    1a3b:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1a3f:	41 0f be 7f ff       	movsbl -0x1(%r15),%edi
    1a44:	48 8b 34 24          	mov    (%rsp),%rsi
    1a48:	49 ff cf             	dec    %r15
    1a4b:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    1a50:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    1a55:	ff d5                	callq  *%rbp
    1a57:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    1a5c:	eb d8                	jmp    1a36 <_ntoa_long+0x222>
  if (flags & FLAGS_LEFT) {
    1a5e:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
    1a63:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
    1a67:	74 2f                	je     1a98 <_ntoa_long+0x284>
    1a69:	48 29 d8             	sub    %rbx,%rax
    while (idx - start_idx < width) {
    1a6c:	44 8b ac 24 a0 00 00 	mov    0xa0(%rsp),%r13d
    1a73:	00 
    1a74:	49 89 c6             	mov    %rax,%r14
    1a77:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    1a7b:	4d 39 f5             	cmp    %r14,%r13
    1a7e:	76 18                	jbe    1a98 <_ntoa_long+0x284>
      out(' ', buffer, idx++, maxlen);
    1a80:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    1a85:	48 89 c2             	mov    %rax,%rdx
    1a88:	48 8b 34 24          	mov    (%rsp),%rsi
    1a8c:	49 ff c6             	inc    %r14
    1a8f:	bf 20 00 00 00       	mov    $0x20,%edi
    1a94:	ff d5                	callq  *%rbp
    1a96:	eb df                	jmp    1a77 <_ntoa_long+0x263>
  }

  return _ntoa_format(out, buffer, idx, maxlen, buf, len, negative, (unsigned int)base, prec, width, flags);
}
    1a98:	48 8b 5c 24 48       	mov    0x48(%rsp),%rbx
    1a9d:	64 48 33 1c 25 28 00 	xor    %fs:0x28,%rbx
    1aa4:	00 00 
    1aa6:	74 05                	je     1aad <_ntoa_long+0x299>
    1aa8:	e8 c3 f5 ff ff       	callq  1070 <__stack_chk_fail@plt>
    1aad:	48 83 c4 58          	add    $0x58,%rsp
    1ab1:	5b                   	pop    %rbx
    1ab2:	5d                   	pop    %rbp
    1ab3:	41 5c                	pop    %r12
    1ab5:	41 5d                	pop    %r13
    1ab7:	41 5e                	pop    %r14
    1ab9:	41 5f                	pop    %r15
    1abb:	c3                   	retq   

0000000000001abc <_out_char>:
  if (character) {
    1abc:	40 84 ff             	test   %dil,%dil
    1abf:	74 09                	je     1aca <_out_char+0xe>
    _putchar(character);
    1ac1:	40 0f be ff          	movsbl %dil,%edi
    1ac5:	e9 e7 fa ff ff       	jmpq   15b1 <_putchar>
}
    1aca:	c3                   	retq   

0000000000001acb <_out_fct>:
{
    1acb:	48 89 f0             	mov    %rsi,%rax
  if (character) {
    1ace:	40 84 ff             	test   %dil,%dil
    1ad1:	74 0a                	je     1add <_out_fct+0x12>
    ((out_fct_wrap_type*)buffer)->fct(character, ((out_fct_wrap_type*)buffer)->arg);
    1ad3:	48 8b 76 08          	mov    0x8(%rsi),%rsi
    1ad7:	40 0f be ff          	movsbl %dil,%edi
    1adb:	ff 20                	jmpq   *(%rax)
}
    1add:	c3                   	retq   

0000000000001ade <_vsnprintf>:
#endif  // PRINTF_SUPPORT_FLOAT


// internal vsnprintf
static int _vsnprintf(out_fct_type out, char* buffer, const size_t maxlen, const char* format, va_list va)
{
    1ade:	41 57                	push   %r15
  unsigned int flags, width, precision, n;
  size_t idx = 0U;

  if (!buffer) {
    // use null output function
    out = _out_null;
    1ae0:	48 8d 05 2c fd ff ff 	lea    -0x2d4(%rip),%rax        # 1813 <_out_null>
{
    1ae7:	41 56                	push   %r14
    1ae9:	49 89 ce             	mov    %rcx,%r14
    1aec:	41 55                	push   %r13
    1aee:	41 54                	push   %r12
    1af0:	4d 89 c4             	mov    %r8,%r12
    1af3:	55                   	push   %rbp
    1af4:	48 89 fd             	mov    %rdi,%rbp
    1af7:	53                   	push   %rbx
    1af8:	48 83 ec 48          	sub    $0x48,%rsp
    out = _out_null;
    1afc:	48 85 f6             	test   %rsi,%rsi
{
    1aff:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    out = _out_null;
    1b04:	48 0f 44 e8          	cmove  %rax,%rbp
        out('%', buffer, idx++, maxlen);
        format++;
        break;

      default :
        out(*format, buffer, idx++, maxlen);
    1b08:	31 c0                	xor    %eax,%eax
{
    1b0a:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
  while (*format)
    1b0f:	41 0f be 3e          	movsbl (%r14),%edi
    1b13:	40 84 ff             	test   %dil,%dil
    1b16:	0f 84 aa 06 00 00    	je     21c6 <_vsnprintf+0x6e8>
    if (*format != '%') {
    1b1c:	49 ff c6             	inc    %r14
    1b1f:	40 80 ff 25          	cmp    $0x25,%dil
    1b23:	0f 85 82 06 00 00    	jne    21ab <_vsnprintf+0x6cd>
    flags = 0U;
    1b29:	31 d2                	xor    %edx,%edx
      switch (*format) {
    1b2b:	41 8a 0e             	mov    (%r14),%cl
    1b2e:	49 8d 7e 01          	lea    0x1(%r14),%rdi
    1b32:	80 f9 2b             	cmp    $0x2b,%cl
    1b35:	74 33                	je     1b6a <_vsnprintf+0x8c>
    1b37:	7f 0c                	jg     1b45 <_vsnprintf+0x67>
    1b39:	80 f9 20             	cmp    $0x20,%cl
    1b3c:	74 31                	je     1b6f <_vsnprintf+0x91>
    1b3e:	80 f9 23             	cmp    $0x23,%cl
    1b41:	74 31                	je     1b74 <_vsnprintf+0x96>
    1b43:	eb 0a                	jmp    1b4f <_vsnprintf+0x71>
    1b45:	80 f9 2d             	cmp    $0x2d,%cl
    1b48:	74 1b                	je     1b65 <_vsnprintf+0x87>
    1b4a:	80 f9 30             	cmp    $0x30,%cl
    1b4d:	74 0e                	je     1b5d <_vsnprintf+0x7f>
  return (ch >= '0') && (ch <= '9');
    1b4f:	8d 71 d0             	lea    -0x30(%rcx),%esi
    if (_is_digit(*format)) {
    1b52:	40 80 fe 09          	cmp    $0x9,%sil
    1b56:	77 40                	ja     1b98 <_vsnprintf+0xba>
  unsigned int i = 0U;
    1b58:	45 31 ed             	xor    %r13d,%r13d
    1b5b:	eb 1c                	jmp    1b79 <_vsnprintf+0x9b>
        case '0': flags |= FLAGS_ZEROPAD; format++; n = 1U; break;
    1b5d:	83 ca 01             	or     $0x1,%edx
{
    1b60:	49 89 fe             	mov    %rdi,%r14
    1b63:	eb c6                	jmp    1b2b <_vsnprintf+0x4d>
        case '-': flags |= FLAGS_LEFT;    format++; n = 1U; break;
    1b65:	83 ca 02             	or     $0x2,%edx
    1b68:	eb f6                	jmp    1b60 <_vsnprintf+0x82>
        case '+': flags |= FLAGS_PLUS;    format++; n = 1U; break;
    1b6a:	83 ca 04             	or     $0x4,%edx
    1b6d:	eb f1                	jmp    1b60 <_vsnprintf+0x82>
        case ' ': flags |= FLAGS_SPACE;   format++; n = 1U; break;
    1b6f:	83 ca 08             	or     $0x8,%edx
    1b72:	eb ec                	jmp    1b60 <_vsnprintf+0x82>
        case '#': flags |= FLAGS_HASH;    format++; n = 1U; break;
    1b74:	83 ca 10             	or     $0x10,%edx
    1b77:	eb e7                	jmp    1b60 <_vsnprintf+0x82>
  while (_is_digit(**str)) {
    1b79:	41 0f be 0e          	movsbl (%r14),%ecx
  return (ch >= '0') && (ch <= '9');
    1b7d:	49 8d 7e 01          	lea    0x1(%r14),%rdi
    1b81:	8d 71 d0             	lea    -0x30(%rcx),%esi
  while (_is_digit(**str)) {
    1b84:	40 80 fe 09          	cmp    $0x9,%sil
    1b88:	77 4e                	ja     1bd8 <_vsnprintf+0xfa>
    i = i * 10U + (unsigned int)(*((*str)++) - '0');
    1b8a:	45 6b dd 0a          	imul   $0xa,%r13d,%r11d
    1b8e:	49 89 fe             	mov    %rdi,%r14
    1b91:	45 8d 6c 0b d0       	lea    -0x30(%r11,%rcx,1),%r13d
    1b96:	eb e1                	jmp    1b79 <_vsnprintf+0x9b>
    width = 0U;
    1b98:	45 31 ed             	xor    %r13d,%r13d
    else if (*format == '*') {
    1b9b:	80 f9 2a             	cmp    $0x2a,%cl
    1b9e:	75 38                	jne    1bd8 <_vsnprintf+0xfa>
      const int w = va_arg(va, int);
    1ba0:	41 8b 34 24          	mov    (%r12),%esi
    1ba4:	83 fe 2f             	cmp    $0x2f,%esi
    1ba7:	77 10                	ja     1bb9 <_vsnprintf+0xdb>
    1ba9:	89 f1                	mov    %esi,%ecx
    1bab:	83 c6 08             	add    $0x8,%esi
    1bae:	49 03 4c 24 10       	add    0x10(%r12),%rcx
    1bb3:	41 89 34 24          	mov    %esi,(%r12)
    1bb7:	eb 0e                	jmp    1bc7 <_vsnprintf+0xe9>
    1bb9:	49 8b 4c 24 08       	mov    0x8(%r12),%rcx
    1bbe:	48 8d 71 08          	lea    0x8(%rcx),%rsi
    1bc2:	49 89 74 24 08       	mov    %rsi,0x8(%r12)
    1bc7:	44 8b 29             	mov    (%rcx),%r13d
      if (w < 0) {
    1bca:	45 85 ed             	test   %r13d,%r13d
    1bcd:	79 06                	jns    1bd5 <_vsnprintf+0xf7>
        flags |= FLAGS_LEFT;    // reverse padding
    1bcf:	83 ca 02             	or     $0x2,%edx
        width = (unsigned int)-w;
    1bd2:	41 f7 dd             	neg    %r13d
  unsigned int i = 0U;
    1bd5:	49 89 fe             	mov    %rdi,%r14
    if (*format == '.') {
    1bd8:	41 80 3e 2e          	cmpb   $0x2e,(%r14)
    1bdc:	75 78                	jne    1c56 <_vsnprintf+0x178>
      if (_is_digit(*format)) {
    1bde:	41 8a 76 01          	mov    0x1(%r14),%sil
    1be2:	49 8d 4e 01          	lea    0x1(%r14),%rcx
      flags |= FLAGS_PRECISION;
    1be6:	80 ce 04             	or     $0x4,%dh
  return (ch >= '0') && (ch <= '9');
    1be9:	8d 7e d0             	lea    -0x30(%rsi),%edi
      if (_is_digit(*format)) {
    1bec:	40 80 ff 09          	cmp    $0x9,%dil
    1bf0:	77 21                	ja     1c13 <_vsnprintf+0x135>
  unsigned int i = 0U;
    1bf2:	45 31 ff             	xor    %r15d,%r15d
  while (_is_digit(**str)) {
    1bf5:	0f be 31             	movsbl (%rcx),%esi
  return (ch >= '0') && (ch <= '9');
    1bf8:	4c 8d 41 01          	lea    0x1(%rcx),%r8
    1bfc:	8d 7e d0             	lea    -0x30(%rsi),%edi
  while (_is_digit(**str)) {
    1bff:	40 80 ff 09          	cmp    $0x9,%dil
    1c03:	77 57                	ja     1c5c <_vsnprintf+0x17e>
    i = i * 10U + (unsigned int)(*((*str)++) - '0');
    1c05:	45 6b ff 0a          	imul   $0xa,%r15d,%r15d
    1c09:	4c 89 c1             	mov    %r8,%rcx
    1c0c:	45 8d 7c 37 d0       	lea    -0x30(%r15,%rsi,1),%r15d
    1c11:	eb e2                	jmp    1bf5 <_vsnprintf+0x117>
    precision = 0U;
    1c13:	45 31 ff             	xor    %r15d,%r15d
      else if (*format == '*') {
    1c16:	40 80 fe 2a          	cmp    $0x2a,%sil
    1c1a:	75 40                	jne    1c5c <_vsnprintf+0x17e>
        const int prec = (int)va_arg(va, int);
    1c1c:	41 8b 34 24          	mov    (%r12),%esi
    1c20:	83 fe 2f             	cmp    $0x2f,%esi
    1c23:	77 10                	ja     1c35 <_vsnprintf+0x157>
    1c25:	89 f1                	mov    %esi,%ecx
    1c27:	83 c6 08             	add    $0x8,%esi
    1c2a:	49 03 4c 24 10       	add    0x10(%r12),%rcx
    1c2f:	41 89 34 24          	mov    %esi,(%r12)
    1c33:	eb 0e                	jmp    1c43 <_vsnprintf+0x165>
    1c35:	49 8b 4c 24 08       	mov    0x8(%r12),%rcx
    1c3a:	48 8d 71 08          	lea    0x8(%rcx),%rsi
    1c3e:	49 89 74 24 08       	mov    %rsi,0x8(%r12)
        precision = prec > 0 ? (unsigned int)prec : 0U;
    1c43:	83 39 00             	cmpl   $0x0,(%rcx)
    1c46:	41 bf 00 00 00 00    	mov    $0x0,%r15d
    1c4c:	44 0f 49 39          	cmovns (%rcx),%r15d
        format++;
    1c50:	49 8d 4e 02          	lea    0x2(%r14),%rcx
    1c54:	eb 06                	jmp    1c5c <_vsnprintf+0x17e>
    1c56:	4c 89 f1             	mov    %r14,%rcx
    precision = 0U;
    1c59:	45 31 ff             	xor    %r15d,%r15d
    switch (*format) {
    1c5c:	40 8a 31             	mov    (%rcx),%sil
    1c5f:	48 8d 79 01          	lea    0x1(%rcx),%rdi
    1c63:	40 80 fe 6a          	cmp    $0x6a,%sil
    1c67:	74 37                	je     1ca0 <_vsnprintf+0x1c2>
    1c69:	7f 08                	jg     1c73 <_vsnprintf+0x195>
    1c6b:	40 80 fe 68          	cmp    $0x68,%sil
    1c6f:	74 1b                	je     1c8c <_vsnprintf+0x1ae>
    1c71:	eb 33                	jmp    1ca6 <_vsnprintf+0x1c8>
    1c73:	40 80 fe 6c          	cmp    $0x6c,%sil
    1c77:	74 08                	je     1c81 <_vsnprintf+0x1a3>
    1c79:	40 80 fe 7a          	cmp    $0x7a,%sil
    1c7d:	74 21                	je     1ca0 <_vsnprintf+0x1c2>
    1c7f:	eb 25                	jmp    1ca6 <_vsnprintf+0x1c8>
        if (*format == 'l') {
    1c81:	80 79 01 6c          	cmpb   $0x6c,0x1(%rcx)
    1c85:	75 19                	jne    1ca0 <_vsnprintf+0x1c2>
          flags |= FLAGS_LONG_LONG;
    1c87:	80 ce 03             	or     $0x3,%dh
          format++;
    1c8a:	eb 0e                	jmp    1c9a <_vsnprintf+0x1bc>
        if (*format == 'h') {
    1c8c:	80 79 01 68          	cmpb   $0x68,0x1(%rcx)
    1c90:	74 05                	je     1c97 <_vsnprintf+0x1b9>
        flags |= FLAGS_SHORT;
    1c92:	80 ca 80             	or     $0x80,%dl
    1c95:	eb 0c                	jmp    1ca3 <_vsnprintf+0x1c5>
          flags |= FLAGS_CHAR;
    1c97:	80 ca c0             	or     $0xc0,%dl
          format++;
    1c9a:	48 83 c1 02          	add    $0x2,%rcx
    1c9e:	eb 06                	jmp    1ca6 <_vsnprintf+0x1c8>
        flags |= (sizeof(size_t) == sizeof(long) ? FLAGS_LONG : FLAGS_LONG_LONG);
    1ca0:	80 ce 01             	or     $0x1,%dh
        format++;
    1ca3:	48 89 f9             	mov    %rdi,%rcx
    switch (*format) {
    1ca6:	0f be 39             	movsbl (%rcx),%edi
    1ca9:	4c 8d 71 01          	lea    0x1(%rcx),%r14
    1cad:	40 80 ff 69          	cmp    $0x69,%dil
    1cb1:	74 5b                	je     1d0e <_vsnprintf+0x230>
    1cb3:	7f 28                	jg     1cdd <_vsnprintf+0x1ff>
    1cb5:	40 80 ff 62          	cmp    $0x62,%dil
    1cb9:	74 53                	je     1d0e <_vsnprintf+0x230>
    1cbb:	7f 10                	jg     1ccd <_vsnprintf+0x1ef>
    1cbd:	40 80 ff 25          	cmp    $0x25,%dil
    1cc1:	0f 84 cc 04 00 00    	je     2193 <_vsnprintf+0x6b5>
    1cc7:	40 80 ff 58          	cmp    $0x58,%dil
    1ccb:	eb 3b                	jmp    1d08 <_vsnprintf+0x22a>
    1ccd:	40 80 ff 63          	cmp    $0x63,%dil
    1cd1:	0f 84 74 02 00 00    	je     1f4b <_vsnprintf+0x46d>
    1cd7:	40 80 ff 64          	cmp    $0x64,%dil
    1cdb:	eb 2b                	jmp    1d08 <_vsnprintf+0x22a>
    1cdd:	40 80 ff 73          	cmp    $0x73,%dil
    1ce1:	0f 84 1f 03 00 00    	je     2006 <_vsnprintf+0x528>
    1ce7:	7f 15                	jg     1cfe <_vsnprintf+0x220>
    1ce9:	40 80 ff 6f          	cmp    $0x6f,%dil
    1ced:	74 1f                	je     1d0e <_vsnprintf+0x230>
    1cef:	40 80 ff 70          	cmp    $0x70,%dil
    1cf3:	0f 84 43 04 00 00    	je     213c <_vsnprintf+0x65e>
    1cf9:	e9 ad 04 00 00       	jmpq   21ab <_vsnprintf+0x6cd>
    1cfe:	40 80 ff 75          	cmp    $0x75,%dil
    1d02:	74 0a                	je     1d0e <_vsnprintf+0x230>
    1d04:	40 80 ff 78          	cmp    $0x78,%dil
    1d08:	0f 85 9d 04 00 00    	jne    21ab <_vsnprintf+0x6cd>
        if (*format == 'x' || *format == 'X') {
    1d0e:	89 f9                	mov    %edi,%ecx
    1d10:	83 e1 df             	and    $0xffffffdf,%ecx
    1d13:	80 f9 58             	cmp    $0x58,%cl
    1d16:	74 1e                	je     1d36 <_vsnprintf+0x258>
        else if (*format == 'o') {
    1d18:	40 80 ff 6f          	cmp    $0x6f,%dil
    1d1c:	0f 84 b9 04 00 00    	je     21db <_vsnprintf+0x6fd>
        else if (*format == 'b') {
    1d22:	40 80 ff 62          	cmp    $0x62,%dil
    1d26:	0f 84 b9 04 00 00    	je     21e5 <_vsnprintf+0x707>
          flags &= ~FLAGS_HASH;   // no hash for dec format
    1d2c:	83 e2 ef             	and    $0xffffffef,%edx
          base = 10U;
    1d2f:	be 0a 00 00 00       	mov    $0xa,%esi
    1d34:	eb 15                	jmp    1d4b <_vsnprintf+0x26d>
        if (*format == 'X') {
    1d36:	40 80 ff 58          	cmp    $0x58,%dil
    1d3a:	75 0a                	jne    1d46 <_vsnprintf+0x268>
          flags |= FLAGS_UPPERCASE;
    1d3c:	83 ca 20             	or     $0x20,%edx
          base = 16U;
    1d3f:	be 10 00 00 00       	mov    $0x10,%esi
    1d44:	eb 11                	jmp    1d57 <_vsnprintf+0x279>
    1d46:	be 10 00 00 00       	mov    $0x10,%esi
        if ((*format != 'i') && (*format != 'd')) {
    1d4b:	40 80 ff 69          	cmp    $0x69,%dil
    1d4f:	74 09                	je     1d5a <_vsnprintf+0x27c>
    1d51:	40 80 ff 64          	cmp    $0x64,%dil
    1d55:	74 03                	je     1d5a <_vsnprintf+0x27c>
          flags &= ~(FLAGS_PLUS | FLAGS_SPACE);
    1d57:	83 e2 f3             	and    $0xfffffff3,%edx
        if (flags & FLAGS_PRECISION) {
    1d5a:	0f ba e2 0a          	bt     $0xa,%edx
    1d5e:	73 03                	jae    1d63 <_vsnprintf+0x285>
          flags &= ~FLAGS_ZEROPAD;
    1d60:	83 e2 fe             	and    $0xfffffffe,%edx
        if ((*format == 'i') || (*format == 'd')) {
    1d63:	89 d1                	mov    %edx,%ecx
    1d65:	81 e1 00 02 00 00    	and    $0x200,%ecx
    1d6b:	40 80 ff 69          	cmp    $0x69,%dil
    1d6f:	74 0a                	je     1d7b <_vsnprintf+0x29d>
    1d71:	40 80 ff 64          	cmp    $0x64,%dil
    1d75:	0f 85 fa 00 00 00    	jne    1e75 <_vsnprintf+0x397>
          if (flags & FLAGS_LONG_LONG) {
    1d7b:	85 c9                	test   %ecx,%ecx
    1d7d:	0f 85 8c fd ff ff    	jne    1b0f <_vsnprintf+0x31>
          else if (flags & FLAGS_LONG) {
    1d83:	0f ba e2 08          	bt     $0x8,%edx
    1d87:	41 8b 0c 24          	mov    (%r12),%ecx
    1d8b:	73 45                	jae    1dd2 <_vsnprintf+0x2f4>
            const long value = va_arg(va, long);
    1d8d:	83 f9 2f             	cmp    $0x2f,%ecx
    1d90:	77 10                	ja     1da2 <_vsnprintf+0x2c4>
    1d92:	89 cf                	mov    %ecx,%edi
    1d94:	83 c1 08             	add    $0x8,%ecx
    1d97:	49 03 7c 24 10       	add    0x10(%r12),%rdi
    1d9c:	41 89 0c 24          	mov    %ecx,(%r12)
    1da0:	eb 0e                	jmp    1db0 <_vsnprintf+0x2d2>
    1da2:	49 8b 7c 24 08       	mov    0x8(%r12),%rdi
    1da7:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    1dab:	49 89 4c 24 08       	mov    %rcx,0x8(%r12)
    1db0:	4c 8b 0f             	mov    (%rdi),%r9
            idx = _ntoa_long(out, buffer, idx, maxlen, (unsigned long)(value > 0 ? value : 0 - value), value < 0, base, precision, width, flags);
    1db3:	52                   	push   %rdx
    1db4:	41 55                	push   %r13
    1db6:	4c 89 c9             	mov    %r9,%rcx
    1db9:	41 57                	push   %r15
    1dbb:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1dbf:	56                   	push   %rsi
    1dc0:	49 89 c8             	mov    %rcx,%r8
    1dc3:	4d 31 c8             	xor    %r9,%r8
    1dc6:	49 c1 e9 3f          	shr    $0x3f,%r9
    1dca:	49 29 c8             	sub    %rcx,%r8
    1dcd:	e9 a3 03 00 00       	jmpq   2175 <_vsnprintf+0x697>
            const int value = (flags & FLAGS_CHAR) ? (char)va_arg(va, int) : (flags & FLAGS_SHORT) ? (short int)va_arg(va, int) : va_arg(va, int);
    1dd2:	f6 c2 40             	test   $0x40,%dl
    1dd5:	74 29                	je     1e00 <_vsnprintf+0x322>
    1dd7:	83 f9 2f             	cmp    $0x2f,%ecx
    1dda:	77 10                	ja     1dec <_vsnprintf+0x30e>
    1ddc:	89 cf                	mov    %ecx,%edi
    1dde:	83 c1 08             	add    $0x8,%ecx
    1de1:	49 03 7c 24 10       	add    0x10(%r12),%rdi
    1de6:	41 89 0c 24          	mov    %ecx,(%r12)
    1dea:	eb 0e                	jmp    1dfa <_vsnprintf+0x31c>
    1dec:	49 8b 7c 24 08       	mov    0x8(%r12),%rdi
    1df1:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    1df5:	49 89 4c 24 08       	mov    %rcx,0x8(%r12)
    1dfa:	44 0f be 0f          	movsbl (%rdi),%r9d
    1dfe:	eb 54                	jmp    1e54 <_vsnprintf+0x376>
    1e00:	f6 c2 80             	test   $0x80,%dl
    1e03:	74 29                	je     1e2e <_vsnprintf+0x350>
    1e05:	83 f9 2f             	cmp    $0x2f,%ecx
    1e08:	77 10                	ja     1e1a <_vsnprintf+0x33c>
    1e0a:	89 cf                	mov    %ecx,%edi
    1e0c:	83 c1 08             	add    $0x8,%ecx
    1e0f:	49 03 7c 24 10       	add    0x10(%r12),%rdi
    1e14:	41 89 0c 24          	mov    %ecx,(%r12)
    1e18:	eb 0e                	jmp    1e28 <_vsnprintf+0x34a>
    1e1a:	49 8b 7c 24 08       	mov    0x8(%r12),%rdi
    1e1f:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    1e23:	49 89 4c 24 08       	mov    %rcx,0x8(%r12)
    1e28:	44 0f bf 0f          	movswl (%rdi),%r9d
    1e2c:	eb 26                	jmp    1e54 <_vsnprintf+0x376>
    1e2e:	83 f9 2f             	cmp    $0x2f,%ecx
    1e31:	77 10                	ja     1e43 <_vsnprintf+0x365>
    1e33:	89 cf                	mov    %ecx,%edi
    1e35:	83 c1 08             	add    $0x8,%ecx
    1e38:	49 03 7c 24 10       	add    0x10(%r12),%rdi
    1e3d:	41 89 0c 24          	mov    %ecx,(%r12)
    1e41:	eb 0e                	jmp    1e51 <_vsnprintf+0x373>
    1e43:	49 8b 7c 24 08       	mov    0x8(%r12),%rdi
    1e48:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    1e4c:	49 89 4c 24 08       	mov    %rcx,0x8(%r12)
    1e51:	44 8b 0f             	mov    (%rdi),%r9d
            idx = _ntoa_long(out, buffer, idx, maxlen, (unsigned int)(value > 0 ? value : 0 - value), value < 0, base, precision, width, flags);
    1e54:	44 89 c9             	mov    %r9d,%ecx
    1e57:	52                   	push   %rdx
    1e58:	c1 f9 1f             	sar    $0x1f,%ecx
    1e5b:	41 55                	push   %r13
    1e5d:	41 89 c8             	mov    %ecx,%r8d
    1e60:	41 57                	push   %r15
    1e62:	45 31 c8             	xor    %r9d,%r8d
    1e65:	56                   	push   %rsi
    1e66:	41 c1 e9 1f          	shr    $0x1f,%r9d
    1e6a:	41 29 c8             	sub    %ecx,%r8d
    1e6d:	4d 63 c0             	movslq %r8d,%r8
    1e70:	e9 00 03 00 00       	jmpq   2175 <_vsnprintf+0x697>
          if (flags & FLAGS_LONG_LONG) {
    1e75:	85 c9                	test   %ecx,%ecx
    1e77:	0f 85 92 fc ff ff    	jne    1b0f <_vsnprintf+0x31>
          else if (flags & FLAGS_LONG) {
    1e7d:	0f ba e2 08          	bt     $0x8,%edx
    1e81:	41 8b 0c 24          	mov    (%r12),%ecx
    1e85:	73 34                	jae    1ebb <_vsnprintf+0x3dd>
            idx = _ntoa_long(out, buffer, idx, maxlen, va_arg(va, unsigned long), false, base, precision, width, flags);
    1e87:	83 f9 2f             	cmp    $0x2f,%ecx
    1e8a:	77 10                	ja     1e9c <_vsnprintf+0x3be>
    1e8c:	89 cf                	mov    %ecx,%edi
    1e8e:	83 c1 08             	add    $0x8,%ecx
    1e91:	49 03 7c 24 10       	add    0x10(%r12),%rdi
    1e96:	41 89 0c 24          	mov    %ecx,(%r12)
    1e9a:	eb 0e                	jmp    1eaa <_vsnprintf+0x3cc>
    1e9c:	49 8b 7c 24 08       	mov    0x8(%r12),%rdi
    1ea1:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    1ea5:	49 89 4c 24 08       	mov    %rcx,0x8(%r12)
    1eaa:	52                   	push   %rdx
    1eab:	45 31 c9             	xor    %r9d,%r9d
    1eae:	41 55                	push   %r13
    1eb0:	41 57                	push   %r15
    1eb2:	56                   	push   %rsi
    1eb3:	4c 8b 07             	mov    (%rdi),%r8
    1eb6:	e9 ba 02 00 00       	jmpq   2175 <_vsnprintf+0x697>
            const unsigned int value = (flags & FLAGS_CHAR) ? (unsigned char)va_arg(va, unsigned int) : (flags & FLAGS_SHORT) ? (unsigned short int)va_arg(va, unsigned int) : va_arg(va, unsigned int);
    1ebb:	f6 c2 40             	test   $0x40,%dl
    1ebe:	74 29                	je     1ee9 <_vsnprintf+0x40b>
    1ec0:	83 f9 2f             	cmp    $0x2f,%ecx
    1ec3:	77 10                	ja     1ed5 <_vsnprintf+0x3f7>
    1ec5:	89 cf                	mov    %ecx,%edi
    1ec7:	83 c1 08             	add    $0x8,%ecx
    1eca:	49 03 7c 24 10       	add    0x10(%r12),%rdi
    1ecf:	41 89 0c 24          	mov    %ecx,(%r12)
    1ed3:	eb 0e                	jmp    1ee3 <_vsnprintf+0x405>
    1ed5:	49 8b 7c 24 08       	mov    0x8(%r12),%rdi
    1eda:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    1ede:	49 89 4c 24 08       	mov    %rcx,0x8(%r12)
    1ee3:	44 0f b6 07          	movzbl (%rdi),%r8d
    1ee7:	eb 54                	jmp    1f3d <_vsnprintf+0x45f>
    1ee9:	f6 c2 80             	test   $0x80,%dl
    1eec:	74 29                	je     1f17 <_vsnprintf+0x439>
    1eee:	83 f9 2f             	cmp    $0x2f,%ecx
    1ef1:	77 10                	ja     1f03 <_vsnprintf+0x425>
    1ef3:	89 cf                	mov    %ecx,%edi
    1ef5:	83 c1 08             	add    $0x8,%ecx
    1ef8:	49 03 7c 24 10       	add    0x10(%r12),%rdi
    1efd:	41 89 0c 24          	mov    %ecx,(%r12)
    1f01:	eb 0e                	jmp    1f11 <_vsnprintf+0x433>
    1f03:	49 8b 7c 24 08       	mov    0x8(%r12),%rdi
    1f08:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    1f0c:	49 89 4c 24 08       	mov    %rcx,0x8(%r12)
    1f11:	44 0f b7 07          	movzwl (%rdi),%r8d
    1f15:	eb 26                	jmp    1f3d <_vsnprintf+0x45f>
    1f17:	83 f9 2f             	cmp    $0x2f,%ecx
    1f1a:	77 10                	ja     1f2c <_vsnprintf+0x44e>
    1f1c:	89 cf                	mov    %ecx,%edi
    1f1e:	83 c1 08             	add    $0x8,%ecx
    1f21:	49 03 7c 24 10       	add    0x10(%r12),%rdi
    1f26:	41 89 0c 24          	mov    %ecx,(%r12)
    1f2a:	eb 0e                	jmp    1f3a <_vsnprintf+0x45c>
    1f2c:	49 8b 7c 24 08       	mov    0x8(%r12),%rdi
    1f31:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    1f35:	49 89 4c 24 08       	mov    %rcx,0x8(%r12)
    1f3a:	44 8b 07             	mov    (%rdi),%r8d
            idx = _ntoa_long(out, buffer, idx, maxlen, value, false, base, precision, width, flags);
    1f3d:	52                   	push   %rdx
    1f3e:	45 31 c9             	xor    %r9d,%r9d
    1f41:	41 55                	push   %r13
    1f43:	41 57                	push   %r15
    1f45:	56                   	push   %rsi
    1f46:	e9 2a 02 00 00       	jmpq   2175 <_vsnprintf+0x697>
        if (!(flags & FLAGS_LEFT)) {
    1f4b:	83 e2 02             	and    $0x2,%edx
    1f4e:	89 54 24 18          	mov    %edx,0x18(%rsp)
    1f52:	74 0b                	je     1f5f <_vsnprintf+0x481>
    1f54:	48 89 c2             	mov    %rax,%rdx
        unsigned int l = 1U;
    1f57:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    1f5d:	eb 2f                	jmp    1f8e <_vsnprintf+0x4b0>
    1f5f:	31 db                	xor    %ebx,%ebx
    1f61:	48 8d 14 18          	lea    (%rax,%rbx,1),%rdx
          while (l++ < width) {
    1f65:	44 8d 7b 02          	lea    0x2(%rbx),%r15d
    1f69:	48 ff c3             	inc    %rbx
    1f6c:	41 39 dd             	cmp    %ebx,%r13d
    1f6f:	76 1d                	jbe    1f8e <_vsnprintf+0x4b0>
    1f71:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
            out(' ', buffer, idx++, maxlen);
    1f76:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    1f7b:	bf 20 00 00 00       	mov    $0x20,%edi
    1f80:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    1f85:	ff d5                	callq  *%rbp
    1f87:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    1f8c:	eb d3                	jmp    1f61 <_vsnprintf+0x483>
        out((char)va_arg(va, int), buffer, idx++, maxlen);
    1f8e:	41 8b 34 24          	mov    (%r12),%esi
    1f92:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1f96:	83 fe 2f             	cmp    $0x2f,%esi
    1f99:	77 10                	ja     1fab <_vsnprintf+0x4cd>
    1f9b:	89 f1                	mov    %esi,%ecx
    1f9d:	83 c6 08             	add    $0x8,%esi
    1fa0:	49 03 4c 24 10       	add    0x10(%r12),%rcx
    1fa5:	41 89 34 24          	mov    %esi,(%r12)
    1fa9:	eb 0e                	jmp    1fb9 <_vsnprintf+0x4db>
    1fab:	49 8b 4c 24 08       	mov    0x8(%r12),%rcx
    1fb0:	48 8d 71 08          	lea    0x8(%rcx),%rsi
    1fb4:	49 89 74 24 08       	mov    %rsi,0x8(%r12)
    1fb9:	0f be 39             	movsbl (%rcx),%edi
    1fbc:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    1fc1:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    1fc6:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    1fcb:	ff d5                	callq  *%rbp
        if (flags & FLAGS_LEFT) {
    1fcd:	83 7c 24 18 00       	cmpl   $0x0,0x18(%rsp)
    1fd2:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    1fd7:	0f 84 32 fb ff ff    	je     1b0f <_vsnprintf+0x31>
          while (l++ < width) {
    1fdd:	45 39 fd             	cmp    %r15d,%r13d
    1fe0:	0f 86 29 fb ff ff    	jbe    1b0f <_vsnprintf+0x31>
            out(' ', buffer, idx++, maxlen);
    1fe6:	48 8d 58 01          	lea    0x1(%rax),%rbx
    1fea:	48 89 c2             	mov    %rax,%rdx
    1fed:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    1ff2:	41 ff c7             	inc    %r15d
    1ff5:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    1ffa:	bf 20 00 00 00       	mov    $0x20,%edi
    1fff:	ff d5                	callq  *%rbp
    2001:	48 89 d8             	mov    %rbx,%rax
    2004:	eb d7                	jmp    1fdd <_vsnprintf+0x4ff>
        char* p = va_arg(va, char*);
    2006:	41 8b 34 24          	mov    (%r12),%esi
    200a:	83 fe 2f             	cmp    $0x2f,%esi
    200d:	77 10                	ja     201f <_vsnprintf+0x541>
    200f:	89 f1                	mov    %esi,%ecx
    2011:	83 c6 08             	add    $0x8,%esi
    2014:	49 03 4c 24 10       	add    0x10(%r12),%rcx
    2019:	41 89 34 24          	mov    %esi,(%r12)
    201d:	eb 0e                	jmp    202d <_vsnprintf+0x54f>
    201f:	49 8b 4c 24 08       	mov    0x8(%r12),%rcx
    2024:	48 8d 71 08          	lea    0x8(%rcx),%rsi
    2028:	49 89 74 24 08       	mov    %rsi,0x8(%r12)
    202d:	4c 8b 01             	mov    (%rcx),%r8
        unsigned int l = _strnlen_s(p, precision ? precision : (size_t)-1);
    2030:	48 83 c9 ff          	or     $0xffffffffffffffff,%rcx
    2034:	45 85 ff             	test   %r15d,%r15d
    2037:	74 03                	je     203c <_vsnprintf+0x55e>
    2039:	44 89 f9             	mov    %r15d,%ecx
    203c:	49 8d 34 08          	lea    (%r8,%rcx,1),%rsi
    2040:	4c 89 c1             	mov    %r8,%rcx
  for (s = str; *s && maxsize--; ++s);
    2043:	80 39 00             	cmpb   $0x0,(%rcx)
    2046:	74 0a                	je     2052 <_vsnprintf+0x574>
    2048:	48 39 ce             	cmp    %rcx,%rsi
    204b:	74 05                	je     2052 <_vsnprintf+0x574>
    204d:	48 ff c1             	inc    %rcx
    2050:	eb f1                	jmp    2043 <_vsnprintf+0x565>
        if (flags & FLAGS_PRECISION) {
    2052:	89 d6                	mov    %edx,%esi
  return (unsigned int)(s - str);
    2054:	4c 29 c1             	sub    %r8,%rcx
        if (flags & FLAGS_PRECISION) {
    2057:	81 e6 00 04 00 00    	and    $0x400,%esi
  return (unsigned int)(s - str);
    205d:	89 cb                	mov    %ecx,%ebx
        if (flags & FLAGS_PRECISION) {
    205f:	89 74 24 18          	mov    %esi,0x18(%rsp)
    2063:	74 07                	je     206c <_vsnprintf+0x58e>
          l = (l < precision ? l : precision);
    2065:	44 39 f9             	cmp    %r15d,%ecx
    2068:	41 0f 47 df          	cmova  %r15d,%ebx
        if (!(flags & FLAGS_LEFT)) {
    206c:	83 e2 02             	and    $0x2,%edx
    206f:	89 54 24 20          	mov    %edx,0x20(%rsp)
    2073:	75 47                	jne    20bc <_vsnprintf+0x5de>
          while (l++ < width) {
    2075:	44 8d 4b 01          	lea    0x1(%rbx),%r9d
    2079:	41 39 dd             	cmp    %ebx,%r13d
    207c:	76 3b                	jbe    20b9 <_vsnprintf+0x5db>
            out(' ', buffer, idx++, maxlen);
    207e:	48 8d 58 01          	lea    0x1(%rax),%rbx
    2082:	4c 89 44 24 38       	mov    %r8,0x38(%rsp)
    2087:	48 89 c2             	mov    %rax,%rdx
    208a:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    208f:	44 89 4c 24 30       	mov    %r9d,0x30(%rsp)
    2094:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    2099:	bf 20 00 00 00       	mov    $0x20,%edi
    209e:	48 89 5c 24 28       	mov    %rbx,0x28(%rsp)
    20a3:	ff d5                	callq  *%rbp
          while (l++ < width) {
    20a5:	44 8b 4c 24 30       	mov    0x30(%rsp),%r9d
            out(' ', buffer, idx++, maxlen);
    20aa:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    20af:	4c 8b 44 24 38       	mov    0x38(%rsp),%r8
          while (l++ < width) {
    20b4:	44 89 cb             	mov    %r9d,%ebx
    20b7:	eb bc                	jmp    2075 <_vsnprintf+0x597>
    20b9:	44 89 cb             	mov    %r9d,%ebx
        while ((*p != 0) && (!(flags & FLAGS_PRECISION) || precision--)) {
    20bc:	49 29 c0             	sub    %rax,%r8
    20bf:	4c 89 44 24 30       	mov    %r8,0x30(%rsp)
    20c4:	48 8b 54 24 30       	mov    0x30(%rsp),%rdx
    20c9:	0f be 3c 02          	movsbl (%rdx,%rax,1),%edi
    20cd:	40 84 ff             	test   %dil,%dil
    20d0:	74 34                	je     2106 <_vsnprintf+0x628>
    20d2:	83 7c 24 18 00       	cmpl   $0x0,0x18(%rsp)
    20d7:	75 1f                	jne    20f8 <_vsnprintf+0x61a>
          out(*(p++), buffer, idx++, maxlen);
    20d9:	48 8d 50 01          	lea    0x1(%rax),%rdx
    20dd:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    20e2:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    20e7:	48 89 54 24 28       	mov    %rdx,0x28(%rsp)
    20ec:	48 89 c2             	mov    %rax,%rdx
    20ef:	ff d5                	callq  *%rbp
    20f1:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    20f6:	eb cc                	jmp    20c4 <_vsnprintf+0x5e6>
        while ((*p != 0) && (!(flags & FLAGS_PRECISION) || precision--)) {
    20f8:	41 8d 57 ff          	lea    -0x1(%r15),%edx
    20fc:	45 85 ff             	test   %r15d,%r15d
    20ff:	74 05                	je     2106 <_vsnprintf+0x628>
    2101:	41 89 d7             	mov    %edx,%r15d
    2104:	eb d3                	jmp    20d9 <_vsnprintf+0x5fb>
        if (flags & FLAGS_LEFT) {
    2106:	83 7c 24 20 00       	cmpl   $0x0,0x20(%rsp)
    210b:	0f 84 fe f9 ff ff    	je     1b0f <_vsnprintf+0x31>
    2111:	29 c3                	sub    %eax,%ebx
          while (l++ < width) {
    2113:	8d 14 03             	lea    (%rbx,%rax,1),%edx
    2116:	41 39 d5             	cmp    %edx,%r13d
    2119:	0f 86 f0 f9 ff ff    	jbe    1b0f <_vsnprintf+0x31>
            out(' ', buffer, idx++, maxlen);
    211f:	4c 8d 78 01          	lea    0x1(%rax),%r15
    2123:	48 89 c2             	mov    %rax,%rdx
    2126:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    212b:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    2130:	bf 20 00 00 00       	mov    $0x20,%edi
    2135:	ff d5                	callq  *%rbp
    2137:	4c 89 f8             	mov    %r15,%rax
    213a:	eb d7                	jmp    2113 <_vsnprintf+0x635>
          idx = _ntoa_long(out, buffer, idx, maxlen, (unsigned long)((uintptr_t)va_arg(va, void*)), false, 16U, precision, width, flags);
    213c:	41 8b 34 24          	mov    (%r12),%esi
        flags |= FLAGS_ZEROPAD | FLAGS_UPPERCASE;
    2140:	89 d3                	mov    %edx,%ebx
    2142:	83 cb 21             	or     $0x21,%ebx
          idx = _ntoa_long(out, buffer, idx, maxlen, (unsigned long)((uintptr_t)va_arg(va, void*)), false, 16U, precision, width, flags);
    2145:	83 fe 2f             	cmp    $0x2f,%esi
    2148:	77 10                	ja     215a <_vsnprintf+0x67c>
    214a:	89 f1                	mov    %esi,%ecx
    214c:	83 c6 08             	add    $0x8,%esi
    214f:	49 03 4c 24 10       	add    0x10(%r12),%rcx
    2154:	41 89 34 24          	mov    %esi,(%r12)
    2158:	eb 0e                	jmp    2168 <_vsnprintf+0x68a>
    215a:	49 8b 4c 24 08       	mov    0x8(%r12),%rcx
    215f:	48 8d 51 08          	lea    0x8(%rcx),%rdx
    2163:	49 89 54 24 08       	mov    %rdx,0x8(%r12)
    2168:	53                   	push   %rbx
    2169:	45 31 c9             	xor    %r9d,%r9d
    216c:	6a 10                	pushq  $0x10
    216e:	41 57                	push   %r15
    2170:	6a 10                	pushq  $0x10
    2172:	4c 8b 01             	mov    (%rcx),%r8
    2175:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
    217a:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    217f:	48 89 c2             	mov    %rax,%rdx
    2182:	48 89 ef             	mov    %rbp,%rdi
    2185:	e8 8a f6 ff ff       	callq  1814 <_ntoa_long>
        break;
    218a:	48 83 c4 20          	add    $0x20,%rsp
    218e:	e9 7c f9 ff ff       	jmpq   1b0f <_vsnprintf+0x31>
        out('%', buffer, idx++, maxlen);
    2193:	48 8d 58 01          	lea    0x1(%rax),%rbx
    2197:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    219c:	48 89 c2             	mov    %rax,%rdx
    219f:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    21a4:	bf 25 00 00 00       	mov    $0x25,%edi
    21a9:	eb 11                	jmp    21bc <_vsnprintf+0x6de>
        out(*format, buffer, idx++, maxlen);
    21ab:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    21b0:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    21b5:	48 8d 58 01          	lea    0x1(%rax),%rbx
    21b9:	48 89 c2             	mov    %rax,%rdx
    21bc:	ff d5                	callq  *%rbp
    21be:	48 89 d8             	mov    %rbx,%rax
        format++;
        break;
    21c1:	e9 49 f9 ff ff       	jmpq   1b0f <_vsnprintf+0x31>
    }
  }

  // termination
  out((char)0, buffer, idx < maxlen ? idx : maxlen - 1U, maxlen);
    21c6:	48 89 c2             	mov    %rax,%rdx
    21c9:	48 3b 44 24 08       	cmp    0x8(%rsp),%rax
    21ce:	72 1f                	jb     21ef <_vsnprintf+0x711>
    21d0:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    21d5:	48 8d 53 ff          	lea    -0x1(%rbx),%rdx
    21d9:	eb 14                	jmp    21ef <_vsnprintf+0x711>
          base =  8U;
    21db:	be 08 00 00 00       	mov    $0x8,%esi
    21e0:	e9 72 fb ff ff       	jmpq   1d57 <_vsnprintf+0x279>
          base =  2U;
    21e5:	be 02 00 00 00       	mov    $0x2,%esi
        if ((*format != 'i') && (*format != 'd')) {
    21ea:	e9 68 fb ff ff       	jmpq   1d57 <_vsnprintf+0x279>
    21ef:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  out((char)0, buffer, idx < maxlen ? idx : maxlen - 1U, maxlen);
    21f4:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    21f9:	31 ff                	xor    %edi,%edi
    21fb:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    2200:	ff d5                	callq  *%rbp

  // return written chars without terminating \0
  return (int)idx;
    2202:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
}
    2207:	48 83 c4 48          	add    $0x48,%rsp
    220b:	5b                   	pop    %rbx
    220c:	5d                   	pop    %rbp
    220d:	41 5c                	pop    %r12
    220f:	41 5d                	pop    %r13
    2211:	41 5e                	pop    %r14
    2213:	41 5f                	pop    %r15
    2215:	c3                   	retq   

0000000000002216 <printf_>:


///////////////////////////////////////////////////////////////////////////////

int printf_(const char* format, ...)
{
    2216:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    221d:	48 89 74 24 38       	mov    %rsi,0x38(%rsp)
    2222:	48 89 54 24 40       	mov    %rdx,0x40(%rsp)
    2227:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
    222c:	4c 89 44 24 50       	mov    %r8,0x50(%rsp)
    2231:	4c 89 4c 24 58       	mov    %r9,0x58(%rsp)
    2236:	84 c0                	test   %al,%al
    2238:	74 3a                	je     2274 <printf_+0x5e>
    223a:	0f 29 44 24 60       	movaps %xmm0,0x60(%rsp)
    223f:	0f 29 4c 24 70       	movaps %xmm1,0x70(%rsp)
    2244:	0f 29 94 24 80 00 00 	movaps %xmm2,0x80(%rsp)
    224b:	00 
    224c:	0f 29 9c 24 90 00 00 	movaps %xmm3,0x90(%rsp)
    2253:	00 
    2254:	0f 29 a4 24 a0 00 00 	movaps %xmm4,0xa0(%rsp)
    225b:	00 
    225c:	0f 29 ac 24 b0 00 00 	movaps %xmm5,0xb0(%rsp)
    2263:	00 
    2264:	0f 29 b4 24 c0 00 00 	movaps %xmm6,0xc0(%rsp)
    226b:	00 
    226c:	0f 29 bc 24 d0 00 00 	movaps %xmm7,0xd0(%rsp)
    2273:	00 
    2274:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    227b:	00 00 
    227d:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    2282:	31 c0                	xor    %eax,%eax
  va_list va;
  va_start(va, format);
  char buffer[1];
  const int ret = _vsnprintf(_out_char, buffer, (size_t)-1, format, va);
    2284:	48 89 f9             	mov    %rdi,%rcx
    2287:	48 83 ca ff          	or     $0xffffffffffffffff,%rdx
    228b:	48 8d 74 24 27       	lea    0x27(%rsp),%rsi
  va_start(va, format);
    2290:	48 8d 84 24 f0 00 00 	lea    0xf0(%rsp),%rax
    2297:	00 
  const int ret = _vsnprintf(_out_char, buffer, (size_t)-1, format, va);
    2298:	4c 8d 44 24 08       	lea    0x8(%rsp),%r8
  va_start(va, format);
    229d:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%rsp)
    22a4:	00 
    22a5:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  const int ret = _vsnprintf(_out_char, buffer, (size_t)-1, format, va);
    22aa:	48 8d 3d 0b f8 ff ff 	lea    -0x7f5(%rip),%rdi        # 1abc <_out_char>
  va_start(va, format);
    22b1:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
    22b6:	c7 44 24 0c 30 00 00 	movl   $0x30,0xc(%rsp)
    22bd:	00 
    22be:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  const int ret = _vsnprintf(_out_char, buffer, (size_t)-1, format, va);
    22c3:	e8 16 f8 ff ff       	callq  1ade <_vsnprintf>
  va_end(va);
  return ret;
}
    22c8:	48 8b 54 24 28       	mov    0x28(%rsp),%rdx
    22cd:	64 48 33 14 25 28 00 	xor    %fs:0x28,%rdx
    22d4:	00 00 
    22d6:	74 05                	je     22dd <printf_+0xc7>
    22d8:	e8 93 ed ff ff       	callq  1070 <__stack_chk_fail@plt>
    22dd:	48 81 c4 e8 00 00 00 	add    $0xe8,%rsp
    22e4:	c3                   	retq   

00000000000022e5 <sprintf_>:


int sprintf_(char* buffer, const char* format, ...)
{
    22e5:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    22ec:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    22f1:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    22f6:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    22fb:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    2300:	84 c0                	test   %al,%al
    2302:	74 37                	je     233b <sprintf_+0x56>
    2304:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    2309:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    230e:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    2313:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    231a:	00 
    231b:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    2322:	00 
    2323:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    232a:	00 
    232b:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    2332:	00 
    2333:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    233a:	00 
    233b:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    2342:	00 00 
    2344:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    2349:	31 c0                	xor    %eax,%eax
  va_list va;
  va_start(va, format);
    234b:	48 8d 84 24 e0 00 00 	lea    0xe0(%rsp),%rax
    2352:	00 
  const int ret = _vsnprintf(_out_buffer, buffer, (size_t)-1, format, va);
    2353:	48 89 f1             	mov    %rsi,%rcx
    2356:	49 89 e0             	mov    %rsp,%r8
  va_start(va, format);
    2359:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  const int ret = _vsnprintf(_out_buffer, buffer, (size_t)-1, format, va);
    235e:	48 83 ca ff          	or     $0xffffffffffffffff,%rdx
    2362:	48 89 fe             	mov    %rdi,%rsi
  va_start(va, format);
    2365:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
  const int ret = _vsnprintf(_out_buffer, buffer, (size_t)-1, format, va);
    236a:	48 8d 3d 98 f4 ff ff 	lea    -0xb68(%rip),%rdi        # 1809 <_out_buffer>
  va_start(va, format);
    2371:	c7 04 24 10 00 00 00 	movl   $0x10,(%rsp)
    2378:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%rsp)
    237f:	00 
    2380:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  const int ret = _vsnprintf(_out_buffer, buffer, (size_t)-1, format, va);
    2385:	e8 54 f7 ff ff       	callq  1ade <_vsnprintf>
  va_end(va);
  return ret;
}
    238a:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
    238f:	64 48 33 14 25 28 00 	xor    %fs:0x28,%rdx
    2396:	00 00 
    2398:	74 05                	je     239f <sprintf_+0xba>
    239a:	e8 d1 ec ff ff       	callq  1070 <__stack_chk_fail@plt>
    239f:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    23a6:	c3                   	retq   

00000000000023a7 <snprintf_>:


int snprintf_(char* buffer, size_t count, const char* format, ...)
{
    23a7:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    23ae:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    23b3:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    23b8:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    23bd:	84 c0                	test   %al,%al
    23bf:	74 37                	je     23f8 <snprintf_+0x51>
    23c1:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    23c6:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    23cb:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    23d0:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    23d7:	00 
    23d8:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    23df:	00 
    23e0:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    23e7:	00 
    23e8:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    23ef:	00 
    23f0:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    23f7:	00 
    23f8:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    23ff:	00 00 
    2401:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    2406:	31 c0                	xor    %eax,%eax
  va_list va;
  va_start(va, format);
    2408:	48 8d 84 24 e0 00 00 	lea    0xe0(%rsp),%rax
    240f:	00 
  const int ret = _vsnprintf(_out_buffer, buffer, count, format, va);
    2410:	48 89 d1             	mov    %rdx,%rcx
    2413:	49 89 e0             	mov    %rsp,%r8
  va_start(va, format);
    2416:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  const int ret = _vsnprintf(_out_buffer, buffer, count, format, va);
    241b:	48 89 f2             	mov    %rsi,%rdx
  va_start(va, format);
    241e:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
  const int ret = _vsnprintf(_out_buffer, buffer, count, format, va);
    2423:	48 89 fe             	mov    %rdi,%rsi
    2426:	48 8d 3d dc f3 ff ff 	lea    -0xc24(%rip),%rdi        # 1809 <_out_buffer>
  va_start(va, format);
    242d:	c7 04 24 18 00 00 00 	movl   $0x18,(%rsp)
    2434:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%rsp)
    243b:	00 
    243c:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  const int ret = _vsnprintf(_out_buffer, buffer, count, format, va);
    2441:	e8 98 f6 ff ff       	callq  1ade <_vsnprintf>
  va_end(va);
  return ret;
}
    2446:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    244b:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
    2452:	00 00 
    2454:	74 05                	je     245b <snprintf_+0xb4>
    2456:	e8 15 ec ff ff       	callq  1070 <__stack_chk_fail@plt>
    245b:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    2462:	c3                   	retq   

0000000000002463 <vsnprintf_>:


int vsnprintf_(char* buffer, size_t count, const char* format, va_list va)
{
    2463:	49 89 c8             	mov    %rcx,%r8
  return _vsnprintf(_out_buffer, buffer, count, format, va);
    2466:	48 89 d1             	mov    %rdx,%rcx
    2469:	48 89 f2             	mov    %rsi,%rdx
    246c:	48 89 fe             	mov    %rdi,%rsi
    246f:	48 8d 3d 93 f3 ff ff 	lea    -0xc6d(%rip),%rdi        # 1809 <_out_buffer>
    2476:	e9 63 f6 ff ff       	jmpq   1ade <_vsnprintf>

000000000000247b <fctprintf>:
}


int fctprintf(void (*out)(char character, void* arg), void* arg, const char* format, ...)
{
    247b:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    2482:	48 89 4c 24 48       	mov    %rcx,0x48(%rsp)
    2487:	4c 89 44 24 50       	mov    %r8,0x50(%rsp)
    248c:	4c 89 4c 24 58       	mov    %r9,0x58(%rsp)
    2491:	84 c0                	test   %al,%al
    2493:	74 3a                	je     24cf <fctprintf+0x54>
    2495:	0f 29 44 24 60       	movaps %xmm0,0x60(%rsp)
    249a:	0f 29 4c 24 70       	movaps %xmm1,0x70(%rsp)
    249f:	0f 29 94 24 80 00 00 	movaps %xmm2,0x80(%rsp)
    24a6:	00 
    24a7:	0f 29 9c 24 90 00 00 	movaps %xmm3,0x90(%rsp)
    24ae:	00 
    24af:	0f 29 a4 24 a0 00 00 	movaps %xmm4,0xa0(%rsp)
    24b6:	00 
    24b7:	0f 29 ac 24 b0 00 00 	movaps %xmm5,0xb0(%rsp)
    24be:	00 
    24bf:	0f 29 b4 24 c0 00 00 	movaps %xmm6,0xc0(%rsp)
    24c6:	00 
    24c7:	0f 29 bc 24 d0 00 00 	movaps %xmm7,0xd0(%rsp)
    24ce:	00 
    24cf:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    24d6:	00 00 
    24d8:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    24dd:	31 c0                	xor    %eax,%eax
  va_list va;
  va_start(va, format);
  const out_fct_wrap_type out_fct_wrap = { out, arg };
  const int ret = _vsnprintf(_out_fct, (char*)&out_fct_wrap, (size_t)-1, format, va);
    24df:	48 89 d1             	mov    %rdx,%rcx
  const out_fct_wrap_type out_fct_wrap = { out, arg };
    24e2:	48 89 3c 24          	mov    %rdi,(%rsp)
  const int ret = _vsnprintf(_out_fct, (char*)&out_fct_wrap, (size_t)-1, format, va);
    24e6:	48 83 ca ff          	or     $0xffffffffffffffff,%rdx
  va_start(va, format);
    24ea:	48 8d 84 24 f0 00 00 	lea    0xf0(%rsp),%rax
    24f1:	00 
  const out_fct_wrap_type out_fct_wrap = { out, arg };
    24f2:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  const int ret = _vsnprintf(_out_fct, (char*)&out_fct_wrap, (size_t)-1, format, va);
    24f7:	4c 8d 44 24 10       	lea    0x10(%rsp),%r8
    24fc:	48 89 e6             	mov    %rsp,%rsi
  va_start(va, format);
    24ff:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  const int ret = _vsnprintf(_out_fct, (char*)&out_fct_wrap, (size_t)-1, format, va);
    2504:	48 8d 3d c0 f5 ff ff 	lea    -0xa40(%rip),%rdi        # 1acb <_out_fct>
  va_start(va, format);
    250b:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
    2510:	c7 44 24 10 18 00 00 	movl   $0x18,0x10(%rsp)
    2517:	00 
    2518:	c7 44 24 14 30 00 00 	movl   $0x30,0x14(%rsp)
    251f:	00 
    2520:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  const int ret = _vsnprintf(_out_fct, (char*)&out_fct_wrap, (size_t)-1, format, va);
    2525:	e8 b4 f5 ff ff       	callq  1ade <_vsnprintf>
  va_end(va);
  return ret;
}
    252a:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
    252f:	64 48 33 0c 25 28 00 	xor    %fs:0x28,%rcx
    2536:	00 00 
    2538:	74 05                	je     253f <fctprintf+0xc4>
    253a:	e8 31 eb ff ff       	callq  1070 <__stack_chk_fail@plt>
    253f:	48 81 c4 e8 00 00 00 	add    $0xe8,%rsp
    2546:	c3                   	retq   
    2547:	90                   	nop

0000000000002548 <_ZN2UIC1ER8Encoders>:
#define COLOR_MIDI_IDLE           Color565From888(255, 255, 255)
#define COLOR_MIDI_ACTIVITY       Color565From888(255, 255, 255)


UI::UI(Encoders& encoders)
    : encoders_(encoders)
    2548:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
UI::UI(Encoders& encoders)
    254d:	53                   	push   %rbx
    254e:	48 89 fb             	mov    %rdi,%rbx
    : encoders_(encoders)
    2551:	48 8d 7f 30          	lea    0x30(%rdi),%rdi
    2555:	48 89 47 f8          	mov    %rax,-0x8(%rdi)
    2559:	48 89 77 d0          	mov    %rsi,-0x30(%rdi)
    , ops({})
    255d:	e8 e4 f1 ff ff       	callq  1746 <_ZN14OperatorParamsC1Ev>
    2562:	48 8d 7b 34          	lea    0x34(%rbx),%rdi
    2566:	e8 db f1 ff ff       	callq  1746 <_ZN14OperatorParamsC1Ev>
    256b:	48 8d 7b 38          	lea    0x38(%rbx),%rdi
    256f:	e8 d2 f1 ff ff       	callq  1746 <_ZN14OperatorParamsC1Ev>
    2574:	48 8d 7b 3c          	lea    0x3c(%rbx),%rdi
    2578:	e8 c9 f1 ff ff       	callq  1746 <_ZN14OperatorParamsC1Ev>
    257d:	8b 43 44             	mov    0x44(%rbx),%eax
    2580:	c7 43 40 00 00 dc 43 	movl   $0x43dc0000,0x40(%rbx)
    2587:	66 25 00 f0          	and    $0xf000,%ax
    258b:	80 cc 0f             	or     $0xf,%ah
    258e:	66 89 43 44          	mov    %ax,0x44(%rbx)
{
}
    2592:	5b                   	pop    %rbx
    2593:	c3                   	retq   

0000000000002594 <_ZN2UI4initEv>:

void UI::init()
{
}
    2594:	c3                   	retq   
    2595:	90                   	nop

0000000000002596 <_ZN2UI8drawIconER11CommandListiiit>:

void UI::drawIcon(CommandList& cmdList, int x, int y, int idx, uint16_t col)
{
    2596:	41 54                	push   %r12
    2598:	49 89 f4             	mov    %rsi,%r12
    const uint8_t* data = &icons_data[32 * idx];
    cmdList.setColors(col, 0x0000);
    259b:	41 0f b7 f1          	movzwl %r9w,%esi
{
    259f:	55                   	push   %rbp
    cmdList.setColors(col, 0x0000);
    25a0:	4c 89 e7             	mov    %r12,%rdi
{
    25a3:	89 cd                	mov    %ecx,%ebp
    25a5:	53                   	push   %rbx
    25a6:	89 d3                	mov    %edx,%ebx
    cmdList.setColors(col, 0x0000);
    25a8:	31 d2                	xor    %edx,%edx
{
    25aa:	48 83 ec 10          	sub    $0x10,%rsp
    25ae:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
    cmdList.setColors(col, 0x0000);
    25b3:	e8 a4 0b 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
    const uint8_t* data = &icons_data[32 * idx];
    25b8:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
    cmdList.drawBitmap(x, y, 16, 16, data);
    25bd:	0f bf d5             	movswl %bp,%edx
    25c0:	0f bf f3             	movswl %bx,%esi
}
    25c3:	48 83 c4 10          	add    $0x10,%rsp
    cmdList.drawBitmap(x, y, 16, 16, data);
    25c7:	48 8d 05 72 24 00 00 	lea    0x2472(%rip),%rax        # 4a40 <_ZL10icons_data>
    25ce:	4c 89 e7             	mov    %r12,%rdi
    25d1:	b9 10 00 00 00       	mov    $0x10,%ecx
    const uint8_t* data = &icons_data[32 * idx];
    25d6:	41 c1 e0 05          	shl    $0x5,%r8d
}
    25da:	5b                   	pop    %rbx
    25db:	5d                   	pop    %rbp
    const uint8_t* data = &icons_data[32 * idx];
    25dc:	4d 63 c0             	movslq %r8d,%r8
}
    25df:	41 5c                	pop    %r12
    cmdList.drawBitmap(x, y, 16, 16, data);
    25e1:	4e 8d 0c 00          	lea    (%rax,%r8,1),%r9
    25e5:	41 b8 10 00 00 00    	mov    $0x10,%r8d
    25eb:	e9 fe 09 00 00       	jmpq   2fee <_ZN11CommandList10drawBitmapEssssPKh>

00000000000025f0 <_ZN2UI6updateEv>:

void UI::update()
{
    25f0:	31 c0                	xor    %eax,%eax
    // Update inputs.
    for(int i = 0; i < 5; ++i)
    {
        prevButtonVals_[i] = buttonVals_[i];
    25f2:	8a 54 07 1c          	mov    0x1c(%rdi,%rax,1),%dl
        encoderDeltaVals_[i] = encoders_.getValue(i);
    25f6:	48 8b 0f             	mov    (%rdi),%rcx
        prevButtonVals_[i] = buttonVals_[i];
    25f9:	88 54 07 21          	mov    %dl,0x21(%rdi,%rax,1)
    void setRowPin(int row, GPIO::Pin pin);
    void setColPin(int col, GPIO::Pin pin);
	
    int getValue(int idx)
    { 
        int v = values_[idx];
    25fd:	48 63 d0             	movslq %eax,%rdx
    2600:	0f be 74 11 18       	movsbl 0x18(%rcx,%rdx,1),%esi
        values_[idx] = 0;
    2605:	c6 44 11 18 00       	movb   $0x0,0x18(%rcx,%rdx,1)
        return v;
    }

    int getButton(int idx) const
    {
        return button_[idx];
    260a:	48 8b 0f             	mov    (%rdi),%rcx
        encoderDeltaVals_[i] = encoders_.getValue(i);
    260d:	89 74 87 08          	mov    %esi,0x8(%rdi,%rax,4)
        buttonVals_[i] = encoders_.getButton(i);
    2611:	80 7c 11 1d 00       	cmpb   $0x0,0x1d(%rcx,%rdx,1)
    2616:	0f 95 44 07 1c       	setne  0x1c(%rdi,%rax,1)
    261b:	48 ff c0             	inc    %rax
    for(int i = 0; i < 5; ++i)
    261e:	48 83 f8 05          	cmp    $0x5,%rax
    2622:	75 ce                	jne    25f2 <_ZN2UI6updateEv+0x2>
    }
}
    2624:	c3                   	retq   
    2625:	90                   	nop

0000000000002626 <_ZN2UI5printER11CommandListPKc>:
    prevSelectedVoice_ = dispParams.selectedVoice;
    voiceParams_ = voiceParams;
}

void UI::print(CommandList& cmdList, const char* msg)
{
    2626:	55                   	push   %rbp
    2627:	48 89 d5             	mov    %rdx,%rbp
    cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    262a:	ba ff ff 00 00       	mov    $0xffff,%edx
{
    262f:	53                   	push   %rbx
    2630:	48 89 f3             	mov    %rsi,%rbx
    cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    2633:	be ff ff 00 00       	mov    $0xffff,%esi
{
    2638:	50                   	push   %rax
    cmdList.setColors(COLOR_DEFAULT, COLOR_DEFAULT);
    2639:	48 89 df             	mov    %rbx,%rdi
    263c:	e8 1b 0b 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
    cmdList.setFont(&DEFAULT_FONT);
    2641:	48 89 df             	mov    %rbx,%rdi
    2644:	48 8d 35 b5 46 00 00 	lea    0x46b5(%rip),%rsi        # 6d00 <_ZL9Picopixel>
    264b:	e8 24 0b 00 00       	callq  3174 <_ZN11CommandList7setFontEPK7GFXfont>
    cmdList.drawText(0, 0, msg);
}
    2650:	41 58                	pop    %r8
    cmdList.drawText(0, 0, msg);
    2652:	48 89 e9             	mov    %rbp,%rcx
    2655:	48 89 df             	mov    %rbx,%rdi
    2658:	31 d2                	xor    %edx,%edx
}
    265a:	5b                   	pop    %rbx
    cmdList.drawText(0, 0, msg);
    265b:	31 f6                	xor    %esi,%esi
}
    265d:	5d                   	pop    %rbp
    cmdList.drawText(0, 0, msg);
    265e:	e9 77 0a 00 00       	jmpq   30da <_ZN11CommandList8drawTextEssPKc>
    2663:	90                   	nop

0000000000002664 <_ZN2UI5errorER11CommandListPKcti>:

void UI::error(CommandList& cmdList, const char* text, uint16_t color, int ms)
{
    2664:	55                   	push   %rbp
    2665:	48 89 d5             	mov    %rdx,%rbp
    2668:	53                   	push   %rbx
    2669:	48 89 f3             	mov    %rsi,%rbx
    cmdList.setColors(color, color);
    266c:	0f b7 f1             	movzwl %cx,%esi
{
    266f:	50                   	push   %rax
    cmdList.setColors(color, color);
    2670:	89 f2                	mov    %esi,%edx
    2672:	48 89 df             	mov    %rbx,%rdi
    2675:	e8 e2 0a 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
    cmdList.drawFilledBox(0, 0, 128, 128);
    267a:	41 b8 80 00 00 00    	mov    $0x80,%r8d
    2680:	48 89 df             	mov    %rbx,%rdi
    2683:	31 d2                	xor    %edx,%edx
    2685:	b9 80 00 00 00       	mov    $0x80,%ecx
    268a:	31 f6                	xor    %esi,%esi
    268c:	e8 eb 08 00 00       	callq  2f7c <_ZN11CommandList13drawFilledBoxEssss>

    cmdList.setColors(0xffff, 0xffff);
    2691:	ba ff ff 00 00       	mov    $0xffff,%edx
    2696:	48 89 df             	mov    %rbx,%rdi
    2699:	be ff ff 00 00       	mov    $0xffff,%esi
    269e:	e8 b9 0a 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
    cmdList.setFont(&DEFAULT_FONT);
    26a3:	48 89 df             	mov    %rbx,%rdi
    26a6:	48 8d 35 53 46 00 00 	lea    0x4653(%rip),%rsi        # 6d00 <_ZL9Picopixel>
    26ad:	e8 c2 0a 00 00       	callq  3174 <_ZN11CommandList7setFontEPK7GFXfont>
    cmdList.drawText(0, 0, text);
    26b2:	48 89 e9             	mov    %rbp,%rcx
    26b5:	48 89 df             	mov    %rbx,%rdi
    26b8:	31 d2                	xor    %edx,%edx
    26ba:	31 f6                	xor    %esi,%esi
    26bc:	e8 19 0a 00 00       	callq  30da <_ZN11CommandList8drawTextEssPKc>

    cmdList.setColors(COLOR_BACKGROUND, COLOR_BACKGROUND);
    26c1:	48 89 df             	mov    %rbx,%rdi
    26c4:	31 d2                	xor    %edx,%edx
    26c6:	31 f6                	xor    %esi,%esi
    26c8:	e8 8f 0a 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
    cmdList.drawFilledBox(0, 0, 128, 128);
}
    26cd:	41 59                	pop    %r9
    cmdList.drawFilledBox(0, 0, 128, 128);
    26cf:	48 89 df             	mov    %rbx,%rdi
    26d2:	41 b8 80 00 00 00    	mov    $0x80,%r8d
}
    26d8:	5b                   	pop    %rbx
    cmdList.drawFilledBox(0, 0, 128, 128);
    26d9:	b9 80 00 00 00       	mov    $0x80,%ecx
    26de:	31 d2                	xor    %edx,%edx
    26e0:	31 f6                	xor    %esi,%esi
}
    26e2:	5d                   	pop    %rbp
    cmdList.drawFilledBox(0, 0, 128, 128);
    26e3:	e9 94 08 00 00       	jmpq   2f7c <_ZN11CommandList13drawFilledBoxEssss>

00000000000026e8 <_ZN2UI8drawMenuER11CommandListRK9MenuState>:

void UI::drawMenu(CommandList& cmdList, const MenuState& menuState)
{
    26e8:	41 54                	push   %r12
    26ea:	49 89 d4             	mov    %rdx,%r12
    const int16_t TITLE_SEPARATOR_Y = DEFAULT_FONT.yAdvance + 2;
    const int16_t ITEM_SPACING = DEFAULT_FONT.yAdvance + 2;
    const int16_t ITEM_X = 4;
    const int16_t ITEM_Y = DEFAULT_FONT.yAdvance + 4;

    cmdList.setCursor(0, 0);
    26ed:	31 d2                	xor    %edx,%edx
{
    26ef:	55                   	push   %rbp
    cmdList.setFont(&TITLE_FONT);
    cmdList.setColors(COLOR_TITLE, COLOR_TITLE);
    cmdList.drawText(TITLE_X, TITLE_Y, menuState.menu->titleText);
    cmdList.drawHLine(0, TITLE_SEPARATOR_Y, 128);

    cmdList.setFont(&DEFAULT_FONT);
    26f0:	31 ed                	xor    %ebp,%ebp
{
    26f2:	53                   	push   %rbx
    26f3:	48 89 f3             	mov    %rsi,%rbx
    cmdList.setCursor(0, 0);
    26f6:	31 f6                	xor    %esi,%esi
    26f8:	48 89 df             	mov    %rbx,%rdi
    26fb:	e8 88 0a 00 00       	callq  3188 <_ZN11CommandList9setCursorEss>
    cmdList.setColors(0x0000, 0x0000);
    2700:	31 d2                	xor    %edx,%edx
    2702:	31 f6                	xor    %esi,%esi
    2704:	48 89 df             	mov    %rbx,%rdi
    2707:	e8 50 0a 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
    cmdList.drawFilledBox(0, 0, 128, 128);
    270c:	41 b8 80 00 00 00    	mov    $0x80,%r8d
    2712:	31 d2                	xor    %edx,%edx
    2714:	31 f6                	xor    %esi,%esi
    2716:	b9 80 00 00 00       	mov    $0x80,%ecx
    271b:	48 89 df             	mov    %rbx,%rdi
    271e:	e8 59 08 00 00       	callq  2f7c <_ZN11CommandList13drawFilledBoxEssss>
    cmdList.setFont(&TITLE_FONT);
    2723:	48 8d 35 b6 45 00 00 	lea    0x45b6(%rip),%rsi        # 6ce0 <_ZL6Org_01>
    272a:	48 89 df             	mov    %rbx,%rdi
    272d:	e8 42 0a 00 00       	callq  3174 <_ZN11CommandList7setFontEPK7GFXfont>
    cmdList.setColors(COLOR_TITLE, COLOR_TITLE);
    2732:	ba ff ff 00 00       	mov    $0xffff,%edx
    2737:	be ff ff 00 00       	mov    $0xffff,%esi
    273c:	48 89 df             	mov    %rbx,%rdi
    273f:	e8 18 0a 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
    cmdList.drawText(TITLE_X, TITLE_Y, menuState.menu->titleText);
    2744:	49 8b 04 24          	mov    (%r12),%rax
    2748:	31 d2                	xor    %edx,%edx
    274a:	be 04 00 00 00       	mov    $0x4,%esi
    274f:	48 89 df             	mov    %rbx,%rdi
    2752:	48 8b 08             	mov    (%rax),%rcx
    2755:	e8 80 09 00 00       	callq  30da <_ZN11CommandList8drawTextEssPKc>
    cmdList.drawHLine(0, TITLE_SEPARATOR_Y, 128);
    275a:	b9 80 00 00 00       	mov    $0x80,%ecx
    275f:	31 f6                	xor    %esi,%esi
    2761:	48 89 df             	mov    %rbx,%rdi
    2764:	ba 09 00 00 00       	mov    $0x9,%edx
    2769:	e8 64 06 00 00       	callq  2dd2 <_ZN11CommandList9drawHLineEsss>
    cmdList.setFont(&DEFAULT_FONT);
    276e:	48 8d 35 8b 45 00 00 	lea    0x458b(%rip),%rsi        # 6d00 <_ZL9Picopixel>
    2775:	48 89 df             	mov    %rbx,%rdi
    2778:	e8 f7 09 00 00       	callq  3174 <_ZN11CommandList7setFontEPK7GFXfont>

    int itemY = ITEM_Y;
    int firstItemIdx = 0;
    int selectedItemIdx = 0;
    for(int i = 0; i < menuState.menu->numItems; ++i)
    277d:	49 8b 04 24          	mov    (%r12),%rax
    2781:	8d 54 ed 00          	lea    0x0(%rbp,%rbp,8),%edx
    2785:	83 c2 0b             	add    $0xb,%edx
    2788:	0f be 48 10          	movsbl 0x10(%rax),%ecx
    278c:	39 e9                	cmp    %ebp,%ecx
    278e:	7e 1a                	jle    27aa <_ZN2UI8drawMenuER11CommandListRK9MenuState+0xc2>
    {
        cmdList.drawText(ITEM_X, itemY, menuState.menu->items[i].itemText);
    2790:	48 8b 40 08          	mov    0x8(%rax),%rax
    2794:	be 04 00 00 00       	mov    $0x4,%esi
    2799:	48 89 df             	mov    %rbx,%rdi
    279c:	48 8b 0c e8          	mov    (%rax,%rbp,8),%rcx
    27a0:	48 ff c5             	inc    %rbp
    27a3:	e8 32 09 00 00       	callq  30da <_ZN11CommandList8drawTextEssPKc>
    for(int i = 0; i < menuState.menu->numItems; ++i)
    27a8:	eb d3                	jmp    277d <_ZN2UI8drawMenuER11CommandListRK9MenuState+0x95>
        itemY += ITEM_SPACING;
    }
}
    27aa:	5b                   	pop    %rbx
    27ab:	5d                   	pop    %rbp
    27ac:	41 5c                	pop    %r12
    27ae:	c3                   	retq   
    27af:	90                   	nop

00000000000027b0 <_ZN2UI13drawADSR_BarsER11CommandListiiRK14OperatorParamst>:
    sprintf(s_textBuffer, "-%idB", (int)attn); 
    cmdList.drawText(x, y, s_textBuffer);
}

void UI::drawADSR_Bars(CommandList& cmdList, int x, int y, const OperatorParams& op, uint16_t col)
{
    27b0:	41 57                	push   %r15
    27b2:	41 56                	push   %r14
    27b4:	41 55                	push   %r13
    27b6:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    27bc:	41 54                	push   %r12
    27be:	49 89 f4             	mov    %rsi,%r12
    27c1:	55                   	push   %rbp
    27c2:	89 d5                	mov    %edx,%ebp
    27c4:	53                   	push   %rbx
    27c5:	89 cb                	mov    %ecx,%ebx
    27c7:	48 83 ec 18          	sub    $0x18,%rsp
#if UI_INVERTED_ADSR 
    const int a = op.a < 15 ? (15 - op.a) * 2 : 1;
    27cb:	41 8a 00             	mov    (%r8),%al
    27ce:	89 c2                	mov    %eax,%edx
    27d0:	83 e2 0f             	and    $0xf,%edx
    27d3:	80 fa 0f             	cmp    $0xf,%dl
    27d6:	74 09                	je     27e1 <_ZN2UI13drawADSR_BarsER11CommandListiiRK14OperatorParamst+0x31>
    27d8:	f7 d2                	not    %edx
    27da:	83 e2 0f             	and    $0xf,%edx
    27dd:	44 8d 2c 12          	lea    (%rdx,%rdx,1),%r13d
    const int d = op.d < 15 ? (15 - op.d) * 2 : 1;
    27e1:	89 c2                	mov    %eax,%edx
    27e3:	41 be 01 00 00 00    	mov    $0x1,%r14d
    27e9:	83 e2 f0             	and    $0xfffffff0,%edx
    27ec:	80 fa f0             	cmp    $0xf0,%dl
    27ef:	74 0c                	je     27fd <_ZN2UI13drawADSR_BarsER11CommandListiiRK14OperatorParamst+0x4d>
    27f1:	c0 e8 04             	shr    $0x4,%al
    27f4:	f7 d0                	not    %eax
    27f6:	83 e0 0f             	and    $0xf,%eax
    27f9:	44 8d 34 00          	lea    (%rax,%rax,1),%r14d
    const int s = op.s < 15 ? (15 - op.s) * 2 : 1;
    27fd:	41 8a 40 01          	mov    0x1(%r8),%al
    2801:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    2807:	89 c2                	mov    %eax,%edx
    2809:	83 e2 0f             	and    $0xf,%edx
    280c:	80 fa 0f             	cmp    $0xf,%dl
    280f:	74 09                	je     281a <_ZN2UI13drawADSR_BarsER11CommandListiiRK14OperatorParamst+0x6a>
    2811:	f7 d2                	not    %edx
    2813:	83 e2 0f             	and    $0xf,%edx
    2816:	44 8d 3c 12          	lea    (%rdx,%rdx,1),%r15d
    const int r = op.r < 15 ? (15 - op.r) * 2 : 1;
    281a:	89 c2                	mov    %eax,%edx
    281c:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    2822:	83 e2 f0             	and    $0xfffffff0,%edx
    2825:	80 fa f0             	cmp    $0xf0,%dl
    2828:	74 0c                	je     2836 <_ZN2UI13drawADSR_BarsER11CommandListiiRK14OperatorParamst+0x86>
    282a:	c0 e8 04             	shr    $0x4,%al
    282d:	f7 d0                	not    %eax
    282f:	83 e0 0f             	and    $0xf,%eax
    2832:	44 8d 14 00          	lea    (%rax,%rax,1),%r10d
    const int d = op.d > 0 ? op.d * 2 : 1;
    const int s = op.s > 0 ? op.s * 2 : 1;
    const int r = op.r > 0 ? op.r * 2 : 1;
#endif

    cmdList.setColors(col, col);
    2836:	41 0f b7 f1          	movzwl %r9w,%esi
    283a:	83 c3 20             	add    $0x20,%ebx
    283d:	4c 89 e7             	mov    %r12,%rdi
    2840:	44 89 54 24 0c       	mov    %r10d,0xc(%rsp)
    2845:	89 f2                	mov    %esi,%edx
    2847:	e8 10 09 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
    cmdList.drawFilledBox(x + 0, y + 32 - a, 7, a);
    284c:	89 da                	mov    %ebx,%edx
    284e:	0f bf f5             	movswl %bp,%esi
    2851:	45 89 e8             	mov    %r13d,%r8d
    2854:	44 29 ea             	sub    %r13d,%edx
    2857:	4c 89 e7             	mov    %r12,%rdi
    285a:	b9 07 00 00 00       	mov    $0x7,%ecx
    285f:	0f bf d2             	movswl %dx,%edx
    2862:	e8 15 07 00 00       	callq  2f7c <_ZN11CommandList13drawFilledBoxEssss>
    cmdList.drawFilledBox(x + 8, y + 32 - d, 7, d);
    2867:	89 da                	mov    %ebx,%edx
    2869:	8d 75 08             	lea    0x8(%rbp),%esi
    286c:	45 89 f0             	mov    %r14d,%r8d
    286f:	44 29 f2             	sub    %r14d,%edx
    2872:	4c 89 e7             	mov    %r12,%rdi
    2875:	0f bf f6             	movswl %si,%esi
    2878:	b9 07 00 00 00       	mov    $0x7,%ecx
    287d:	0f bf d2             	movswl %dx,%edx
    2880:	e8 f7 06 00 00       	callq  2f7c <_ZN11CommandList13drawFilledBoxEssss>
    cmdList.drawFilledBox(x + 16, y + 32 - s, 7, s);
    2885:	89 da                	mov    %ebx,%edx
    2887:	8d 75 10             	lea    0x10(%rbp),%esi
    288a:	45 89 f8             	mov    %r15d,%r8d
    288d:	44 29 fa             	sub    %r15d,%edx
    2890:	4c 89 e7             	mov    %r12,%rdi
    2893:	0f bf f6             	movswl %si,%esi
    2896:	b9 07 00 00 00       	mov    $0x7,%ecx
    289b:	0f bf d2             	movswl %dx,%edx
    289e:	e8 d9 06 00 00       	callq  2f7c <_ZN11CommandList13drawFilledBoxEssss>
    cmdList.drawFilledBox(x + 24, y + 32 - r, 7, r);
    28a3:	44 8b 54 24 0c       	mov    0xc(%rsp),%r10d
    28a8:	8d 75 18             	lea    0x18(%rbp),%esi
    28ab:	4c 89 e7             	mov    %r12,%rdi
}
    28ae:	48 83 c4 18          	add    $0x18,%rsp
    cmdList.drawFilledBox(x + 24, y + 32 - r, 7, r);
    28b2:	0f bf f6             	movswl %si,%esi
    28b5:	b9 07 00 00 00       	mov    $0x7,%ecx
    28ba:	44 29 d3             	sub    %r10d,%ebx
    28bd:	45 89 d0             	mov    %r10d,%r8d
    28c0:	0f bf d3             	movswl %bx,%edx
}
    28c3:	5b                   	pop    %rbx
    28c4:	5d                   	pop    %rbp
    28c5:	41 5c                	pop    %r12
    28c7:	41 5d                	pop    %r13
    28c9:	41 5e                	pop    %r14
    28cb:	41 5f                	pop    %r15
    cmdList.drawFilledBox(x + 24, y + 32 - r, 7, r);
    28cd:	e9 aa 06 00 00       	jmpq   2f7c <_ZN11CommandList13drawFilledBoxEssss>

00000000000028d2 <_ZN2UI14drawADSR_LinesER11CommandListiiRK14OperatorParamst>:
    
void UI::drawADSR_Lines(CommandList& cmdList, int x, int y, const OperatorParams& op, uint16_t col)
{
    28d2:	41 57                	push   %r15
#endif

    float susLen = 16.0f;
    float adsrTotal = (a + d + susLen + r) / 32.0f;
    float aStart = 0.0f;
    float dStart = aStart + (a / adsrTotal);
    28d4:	0f 57 e4             	xorps  %xmm4,%xmm4
{
    28d7:	41 56                	push   %r14
    28d9:	41 55                	push   %r13
    28db:	41 54                	push   %r12
    28dd:	49 89 f4             	mov    %rsi,%r12
    const int a = (15 - op.a) * 2;
    28e0:	be 0f 00 00 00       	mov    $0xf,%esi
{
    28e5:	55                   	push   %rbp
    28e6:	89 d5                	mov    %edx,%ebp
    const int a = (15 - op.a) * 2;
    28e8:	89 f7                	mov    %esi,%edi
    const int r = (15 - op.r) * 2;
    28ea:	41 89 f2             	mov    %esi,%r10d
{
    28ed:	53                   	push   %rbx
    28ee:	89 cb                	mov    %ecx,%ebx
    float sEnd = sStart + (susLen / adsrTotal);
    float rStart = sEnd + (r / adsrTotal);
    float invS = 31 - s;

    cmdList.setColors(col, col);
    cmdList.drawLine(x + aStart, y + 32, x + dStart, y);
    28f0:	44 8d 73 20          	lea    0x20(%rbx),%r14d
    28f4:	44 0f bf fb          	movswl %bx,%r15d
    28f8:	45 0f bf f6          	movswl %r14w,%r14d
{
    28fc:	48 83 ec 28          	sub    $0x28,%rsp
    const int a = (15 - op.a) * 2;
    2900:	41 8a 00             	mov    (%r8),%al
    float adsrTotal = (a + d + susLen + r) / 32.0f;
    2903:	f3 0f 10 0d 35 23 00 	movss  0x2335(%rip),%xmm1        # 4c40 <_ZL10icons_data+0x200>
    290a:	00 
    const int a = (15 - op.a) * 2;
    290b:	89 c2                	mov    %eax,%edx
    const int d = (15 - op.d) * 2;
    290d:	c0 e8 04             	shr    $0x4,%al
    const int a = (15 - op.a) * 2;
    2910:	83 e2 0f             	and    $0xf,%edx
    const int d = (15 - op.d) * 2;
    2913:	0f b6 c0             	movzbl %al,%eax
    const int a = (15 - op.a) * 2;
    2916:	29 d7                	sub    %edx,%edi
    2918:	89 fa                	mov    %edi,%edx
    const int d = (15 - op.d) * 2;
    291a:	89 f7                	mov    %esi,%edi
    291c:	29 c7                	sub    %eax,%edi
    const int a = (15 - op.a) * 2;
    291e:	01 d2                	add    %edx,%edx
    const int d = (15 - op.d) * 2;
    2920:	89 f8                	mov    %edi,%eax
    const int r = (15 - op.r) * 2;
    2922:	41 8a 78 01          	mov    0x1(%r8),%dil
    float dStart = aStart + (a / adsrTotal);
    2926:	f3 0f 2a d2          	cvtsi2ss %edx,%xmm2
    const int d = (15 - op.d) * 2;
    292a:	01 c0                	add    %eax,%eax
    const int r = (15 - op.r) * 2;
    292c:	89 f9                	mov    %edi,%ecx
    float sStart = dStart + (d / adsrTotal);
    292e:	f3 0f 2a c0          	cvtsi2ss %eax,%xmm0
    const int s = (15 - op.s) * 2;
    2932:	83 e7 0f             	and    $0xf,%edi
    const int r = (15 - op.r) * 2;
    2935:	c0 e9 04             	shr    $0x4,%cl
    const int s = (15 - op.s) * 2;
    2938:	29 fe                	sub    %edi,%esi
    cmdList.setColors(col, col);
    293a:	4c 89 e7             	mov    %r12,%rdi
    const int r = (15 - op.r) * 2;
    293d:	0f b6 c9             	movzbl %cl,%ecx
    const int s = (15 - op.s) * 2;
    2940:	01 f6                	add    %esi,%esi
    const int r = (15 - op.r) * 2;
    2942:	41 29 ca             	sub    %ecx,%r10d
    2945:	44 89 d1             	mov    %r10d,%ecx
    2948:	01 c9                	add    %ecx,%ecx
    float adsrTotal = (a + d + susLen + r) / 32.0f;
    294a:	f3 0f 2a e9          	cvtsi2ss %ecx,%xmm5
    294e:	8d 0c 02             	lea    (%rdx,%rax,1),%ecx
    float invS = 31 - s;
    2951:	b8 1f 00 00 00       	mov    $0x1f,%eax
    float adsrTotal = (a + d + susLen + r) / 32.0f;
    2956:	f3 0f 2a d9          	cvtsi2ss %ecx,%xmm3
    float invS = 31 - s;
    295a:	29 f0                	sub    %esi,%eax
    cmdList.setColors(col, col);
    295c:	41 0f b7 f1          	movzwl %r9w,%esi
    float invS = 31 - s;
    2960:	f3 0f 2a f0          	cvtsi2ss %eax,%xmm6
    cmdList.setColors(col, col);
    2964:	89 f2                	mov    %esi,%edx
    float adsrTotal = (a + d + susLen + r) / 32.0f;
    2966:	f3 0f 58 d9          	addss  %xmm1,%xmm3
    float invS = 31 - s;
    296a:	f3 0f 11 74 24 10    	movss  %xmm6,0x10(%rsp)
    float adsrTotal = (a + d + susLen + r) / 32.0f;
    2970:	f3 0f 58 dd          	addss  %xmm5,%xmm3
    2974:	f3 0f 59 1d c8 22 00 	mulss  0x22c8(%rip),%xmm3        # 4c44 <_ZL10icons_data+0x204>
    297b:	00 
    float dStart = aStart + (a / adsrTotal);
    297c:	f3 0f 5e d3          	divss  %xmm3,%xmm2
    float sStart = dStart + (d / adsrTotal);
    2980:	f3 0f 5e c3          	divss  %xmm3,%xmm0
    float dStart = aStart + (a / adsrTotal);
    2984:	f3 0f 58 d4          	addss  %xmm4,%xmm2
    float sStart = dStart + (d / adsrTotal);
    2988:	f3 0f 11 54 24 1c    	movss  %xmm2,0x1c(%rsp)
    float sEnd = sStart + (susLen / adsrTotal);
    298e:	f3 0f 5e cb          	divss  %xmm3,%xmm1
    float sStart = dStart + (d / adsrTotal);
    2992:	f3 0f 58 c2          	addss  %xmm2,%xmm0
    float sEnd = sStart + (susLen / adsrTotal);
    2996:	f3 0f 11 44 24 18    	movss  %xmm0,0x18(%rsp)
    float rStart = sEnd + (r / adsrTotal);
    299c:	f3 0f 5e eb          	divss  %xmm3,%xmm5
    float sEnd = sStart + (susLen / adsrTotal);
    29a0:	f3 0f 58 c8          	addss  %xmm0,%xmm1
    float rStart = sEnd + (r / adsrTotal);
    29a4:	f3 0f 11 4c 24 14    	movss  %xmm1,0x14(%rsp)
    29aa:	f3 0f 58 e9          	addss  %xmm1,%xmm5
    29ae:	f3 0f 11 6c 24 0c    	movss  %xmm5,0xc(%rsp)
    cmdList.setColors(col, col);
    29b4:	e8 a3 07 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
    cmdList.drawLine(x + aStart, y + 32, x + dStart, y);
    29b9:	f3 0f 2a fd          	cvtsi2ss %ebp,%xmm7
    29bd:	0f 57 e4             	xorps  %xmm4,%xmm4
    29c0:	45 89 f8             	mov    %r15d,%r8d
    29c3:	f3 0f 10 54 24 1c    	movss  0x1c(%rsp),%xmm2
    29c9:	44 89 f2             	mov    %r14d,%edx
    29cc:	4c 89 e7             	mov    %r12,%rdi
    29cf:	f3 0f 58 d7          	addss  %xmm7,%xmm2
    29d3:	f3 0f 58 e7          	addss  %xmm7,%xmm4
    29d7:	f3 0f 11 7c 24 08    	movss  %xmm7,0x8(%rsp)
    29dd:	f3 0f 2c ea          	cvttss2si %xmm2,%ebp
    29e1:	f3 0f 2c f4          	cvttss2si %xmm4,%esi
    29e5:	0f bf ed             	movswl %bp,%ebp
    29e8:	89 e9                	mov    %ebp,%ecx
    29ea:	0f bf f6             	movswl %si,%esi
    29ed:	e8 98 04 00 00       	callq  2e8a <_ZN11CommandList8drawLineEssss>
    cmdList.drawLine(x + dStart, y,            x + sStart, y + invS);
    29f2:	f3 0f 10 44 24 18    	movss  0x18(%rsp),%xmm0
    29f8:	44 89 fa             	mov    %r15d,%edx
    29fb:	89 ee                	mov    %ebp,%esi
    29fd:	f3 0f 2a d3          	cvtsi2ss %ebx,%xmm2
    2a01:	f3 0f 58 44 24 08    	addss  0x8(%rsp),%xmm0
    2a07:	4c 89 e7             	mov    %r12,%rdi
    2a0a:	f3 0f 58 54 24 10    	addss  0x10(%rsp),%xmm2
    2a10:	f3 0f 2c d8          	cvttss2si %xmm0,%ebx
    2a14:	f3 44 0f 2c ea       	cvttss2si %xmm2,%r13d
    2a19:	0f bf db             	movswl %bx,%ebx
    2a1c:	45 0f bf ed          	movswl %r13w,%r13d
    2a20:	89 d9                	mov    %ebx,%ecx
    2a22:	45 89 e8             	mov    %r13d,%r8d
    2a25:	e8 60 04 00 00       	callq  2e8a <_ZN11CommandList8drawLineEssss>
    cmdList.drawLine(x + sStart, y + invS,    x + sEnd, y + invS);
    2a2a:	f3 0f 10 4c 24 14    	movss  0x14(%rsp),%xmm1
    2a30:	45 89 e8             	mov    %r13d,%r8d
    2a33:	89 de                	mov    %ebx,%esi
    2a35:	f3 0f 58 4c 24 08    	addss  0x8(%rsp),%xmm1
    2a3b:	44 89 ea             	mov    %r13d,%edx
    2a3e:	4c 89 e7             	mov    %r12,%rdi
    2a41:	f3 0f 2c e9          	cvttss2si %xmm1,%ebp
    2a45:	0f bf ed             	movswl %bp,%ebp
    2a48:	89 e9                	mov    %ebp,%ecx
    2a4a:	e8 3b 04 00 00       	callq  2e8a <_ZN11CommandList8drawLineEssss>
    cmdList.drawLine(x + sEnd,     y + invS,    x + rStart, y + 32);
    2a4f:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    2a55:	45 89 f0             	mov    %r14d,%r8d
    2a58:	89 ee                	mov    %ebp,%esi
    2a5a:	f3 0f 58 44 24 0c    	addss  0xc(%rsp),%xmm0
}
    2a60:	48 83 c4 28          	add    $0x28,%rsp
    cmdList.drawLine(x + sEnd,     y + invS,    x + rStart, y + 32);
    2a64:	44 89 ea             	mov    %r13d,%edx
    2a67:	4c 89 e7             	mov    %r12,%rdi
}
    2a6a:	5b                   	pop    %rbx
    2a6b:	5d                   	pop    %rbp
    2a6c:	41 5c                	pop    %r12
    2a6e:	41 5d                	pop    %r13
    cmdList.drawLine(x + sEnd,     y + invS,    x + rStart, y + 32);
    2a70:	f3 0f 2c c8          	cvttss2si %xmm0,%ecx
}
    2a74:	41 5e                	pop    %r14
    2a76:	41 5f                	pop    %r15
    cmdList.drawLine(x + sEnd,     y + invS,    x + rStart, y + 32);
    2a78:	0f bf c9             	movswl %cx,%ecx
    2a7b:	e9 0a 04 00 00       	jmpq   2e8a <_ZN11CommandList8drawLineEssss>

0000000000002a80 <_ZN2UI12drawOperatorER11CommandListiiiRK13DisplayParamsRK14OperatorParams>:
{
    2a80:	41 57                	push   %r15
    char titleText[32] = {};
    int selectedVoice = 0;

    bool shouldSelect(SelectFlags flags, int idx = 0) const
    {
        return containsAnyFlags(selectFlags, (SelectFlags)((uint32_t)flags << idx));
    2a82:	b8 00 10 00 00       	mov    $0x1000,%eax
    2a87:	4d 89 cf             	mov    %r9,%r15
    2a8a:	41 56                	push   %r14
    2a8c:	41 55                	push   %r13
    2a8e:	41 54                	push   %r12
    2a90:	49 89 f4             	mov    %rsi,%r12
    2a93:	55                   	push   %rbp
    2a94:	89 d5                	mov    %edx,%ebp
    2a96:	53                   	push   %rbx
    2a97:	89 cb                	mov    %ecx,%ebx
    2a99:	44 89 c1             	mov    %r8d,%ecx
    2a9c:	d3 e0                	shl    %cl,%eax
    2a9e:	48 83 ec 18          	sub    $0x18,%rsp
    if(dispParams.shouldSelect(SelectFlags::OP1, opIdx))
    2aa2:	41 8b 11             	mov    (%r9),%edx
    uint16_t col = dispParams.shouldSelect(SelectFlags::ENV) ? selectCol : COLOR_DEFAULT;
    2aa5:	41 b9 ff ff ff ff    	mov    $0xffffffff,%r9d
{
    2aab:	48 89 3c 24          	mov    %rdi,(%rsp)
    2aaf:	4c 8b 74 24 50       	mov    0x50(%rsp),%r14

template<typename ENUM>
inline bool containsAnyFlags(ENUM value, ENUM Flags)
{
  static_assert(sizeof(ENUM) <= sizeof(uint32_t), "Enum size too large.");
  return ((uint32_t)value & (uint32_t)Flags) != 0;
    2ab4:	21 d0                	and    %edx,%eax
    uint16_t selectCol = COLOR_DEFAULT;
    2ab6:	83 f8 01             	cmp    $0x1,%eax
    if(dispParams.env == EnvelopeMode::BARS)
    2ab9:	41 8a 47 04          	mov    0x4(%r15),%al
    uint16_t selectCol = COLOR_DEFAULT;
    2abd:	45 19 ed             	sbb    %r13d,%r13d
    2ac0:	66 41 81 cd e0 07    	or     $0x7e0,%r13w
    uint16_t col = dispParams.shouldSelect(SelectFlags::ENV) ? selectCol : COLOR_DEFAULT;
    2ac6:	80 e2 10             	and    $0x10,%dl
    2ac9:	45 0f 45 cd          	cmovne %r13d,%r9d
    if(dispParams.env == EnvelopeMode::BARS)
    2acd:	84 c0                	test   %al,%al
    2acf:	75 12                	jne    2ae3 <_ZN2UI12drawOperatorER11CommandListiiiRK13DisplayParamsRK14OperatorParams+0x63>
        drawADSR_Bars(cmdList, x, y, op, col);
    2ad1:	45 0f b7 c9          	movzwl %r9w,%r9d
    2ad5:	4d 89 f0             	mov    %r14,%r8
    2ad8:	89 d9                	mov    %ebx,%ecx
    2ada:	89 ea                	mov    %ebp,%edx
    2adc:	e8 cf fc ff ff       	callq  27b0 <_ZN2UI13drawADSR_BarsER11CommandListiiRK14OperatorParamst>
    2ae1:	eb 18                	jmp    2afb <_ZN2UI12drawOperatorER11CommandListiiiRK13DisplayParamsRK14OperatorParams+0x7b>
    else if(dispParams.env == EnvelopeMode::LINES)
    2ae3:	fe c8                	dec    %al
    2ae5:	75 14                	jne    2afb <_ZN2UI12drawOperatorER11CommandListiiiRK13DisplayParamsRK14OperatorParams+0x7b>
        drawADSR_Lines(cmdList, x, y, op, col);
    2ae7:	48 8b 3c 24          	mov    (%rsp),%rdi
    2aeb:	45 0f b7 c9          	movzwl %r9w,%r9d
    2aef:	4d 89 f0             	mov    %r14,%r8
    2af2:	89 d9                	mov    %ebx,%ecx
    2af4:	89 ea                	mov    %ebp,%edx
    2af6:	e8 d7 fd ff ff       	callq  28d2 <_ZN2UI14drawADSR_LinesER11CommandListiiRK14OperatorParamst>
    col = dispParams.shouldSelect(SelectFlags::MULT) ? selectCol : COLOR_DEFAULT;
    2afb:	41 83 c8 ff          	or     $0xffffffff,%r8d
    2aff:	41 f6 07 08          	testb  $0x8,(%r15)
    cmdList.setColors(col, col);
    2b03:	4c 89 e7             	mov    %r12,%rdi
    col = dispParams.shouldSelect(SelectFlags::MULT) ? selectCol : COLOR_DEFAULT;
    2b06:	44 89 c6             	mov    %r8d,%esi
    2b09:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
    2b0e:	41 0f 45 f5          	cmovne %r13d,%esi
    cmdList.setColors(col, col);
    2b12:	0f b7 f6             	movzwl %si,%esi
    2b15:	89 f2                	mov    %esi,%edx
    2b17:	e8 40 06 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
    cmdList.drawText(x + 36, y, mult[op.mult]);
    2b1c:	66 41 8b 46 02       	mov    0x2(%r14),%ax
    2b21:	8d 75 24             	lea    0x24(%rbp),%esi
    2b24:	4c 89 e7             	mov    %r12,%rdi
    2b27:	48 8d 15 32 41 00 00 	lea    0x4132(%rip),%rdx        # 6c60 <_ZL4mult>
    2b2e:	0f bf f6             	movswl %si,%esi
    2b31:	66 c1 e8 06          	shr    $0x6,%ax
    2b35:	83 e0 0f             	and    $0xf,%eax
    2b38:	48 8b 0c c2          	mov    (%rdx,%rax,8),%rcx
    2b3c:	0f bf d3             	movswl %bx,%edx
    2b3f:	e8 96 05 00 00       	callq  30da <_ZN11CommandList8drawTextEssPKc>
    col = dispParams.shouldSelect(SelectFlags::WAVE) ? selectCol : COLOR_DEFAULT;
    2b44:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
    drawIcon(cmdList, x + 40, y + 8, op.wave + 6, col);
    2b49:	8d 4b 08             	lea    0x8(%rbx),%ecx
    2b4c:	8d 55 28             	lea    0x28(%rbp),%edx
    2b4f:	41 8a 46 03          	mov    0x3(%r14),%al
    col = dispParams.shouldSelect(SelectFlags::WAVE) ? selectCol : COLOR_DEFAULT;
    2b53:	41 f6 07 40          	testb  $0x40,(%r15)
    drawIcon(cmdList, x + 40, y + 8, op.wave + 6, col);
    2b57:	4c 89 e6             	mov    %r12,%rsi
    col = dispParams.shouldSelect(SelectFlags::WAVE) ? selectCol : COLOR_DEFAULT;
    2b5a:	45 0f 44 e8          	cmove  %r8d,%r13d
    drawIcon(cmdList, x + 40, y + 8, op.wave + 6, col);
    2b5e:	48 8b 3c 24          	mov    (%rsp),%rdi
    2b62:	c0 e8 02             	shr    $0x2,%al
    2b65:	83 e0 07             	and    $0x7,%eax
    2b68:	45 0f b7 cd          	movzwl %r13w,%r9d
    2b6c:	44 8d 40 06          	lea    0x6(%rax),%r8d
    2b70:	e8 21 fa ff ff       	callq  2596 <_ZN2UI8drawIconER11CommandListiiit>
    const float attn = op.attn * 0.75f;
    2b75:	41 8a 46 02          	mov    0x2(%r14),%al
    sprintf(s_textBuffer, "-%idB", (int)attn); 
    2b79:	48 8d 35 6c 16 00 00 	lea    0x166c(%rip),%rsi        # 41ec <_ZN4OPL3L6OP_OFFE+0x4c>
    2b80:	48 8d 3d 19 64 00 00 	lea    0x6419(%rip),%rdi        # 8fa0 <_ZL12s_textBuffer>
    const float attn = op.attn * 0.75f;
    2b87:	83 e0 3f             	and    $0x3f,%eax
    2b8a:	f3 0f 2a c0          	cvtsi2ss %eax,%xmm0
    2b8e:	f3 0f 59 05 b2 20 00 	mulss  0x20b2(%rip),%xmm0        # 4c48 <_ZL10icons_data+0x208>
    2b95:	00 
    sprintf(s_textBuffer, "-%idB", (int)attn); 
    2b96:	31 c0                	xor    %eax,%eax
    2b98:	f3 0f 2c d0          	cvttss2si %xmm0,%edx
    2b9c:	e8 44 f7 ff ff       	callq  22e5 <sprintf_>
}
    2ba1:	48 83 c4 18          	add    $0x18,%rsp
    y += 40;
    2ba5:	8d 53 28             	lea    0x28(%rbx),%edx
    cmdList.drawText(x, y, s_textBuffer);
    2ba8:	0f bf f5             	movswl %bp,%esi
}
    2bab:	5b                   	pop    %rbx
    cmdList.drawText(x, y, s_textBuffer);
    2bac:	4c 89 e7             	mov    %r12,%rdi
}
    2baf:	5d                   	pop    %rbp
    cmdList.drawText(x, y, s_textBuffer);
    2bb0:	0f bf d2             	movswl %dx,%edx
}
    2bb3:	41 5c                	pop    %r12
    cmdList.drawText(x, y, s_textBuffer);
    2bb5:	48 8d 0d e4 63 00 00 	lea    0x63e4(%rip),%rcx        # 8fa0 <_ZL12s_textBuffer>
}
    2bbc:	41 5d                	pop    %r13
    2bbe:	41 5e                	pop    %r14
    2bc0:	41 5f                	pop    %r15
    cmdList.drawText(x, y, s_textBuffer);
    2bc2:	e9 13 05 00 00       	jmpq   30da <_ZN11CommandList8drawTextEssPKc>
    2bc7:	90                   	nop

0000000000002bc8 <_ZN2UI4drawER11CommandListRK13DisplayParamsRK11VoiceParams>:
{
    2bc8:	41 57                	push   %r15
        int y = opOffY[i];
    2bca:	4c 8d 3d 6f 16 00 00 	lea    0x166f(%rip),%r15        # 4240 <_ZL6opOffY>
{
    2bd1:	41 56                	push   %r14
    2bd3:	49 89 d6             	mov    %rdx,%r14
        cmdList.setColors(0x0000, 0x0000);
    2bd6:	31 d2                	xor    %edx,%edx
{
    2bd8:	41 55                	push   %r13
    2bda:	41 54                	push   %r12
    2bdc:	49 89 cc             	mov    %rcx,%r12
    2bdf:	55                   	push   %rbp
    2be0:	48 89 fd             	mov    %rdi,%rbp
    2be3:	53                   	push   %rbx
    2be4:	48 89 f3             	mov    %rsi,%rbx
        cmdList.setColors(0x0000, 0x0000);
    2be7:	31 f6                	xor    %esi,%esi
{
    2be9:	41 51                	push   %r9
        cmdList.setColors(0x0000, 0x0000);
    2beb:	48 89 df             	mov    %rbx,%rdi
    2bee:	e8 69 05 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
        cmdList.drawFilledBox(0, 0, 128, 128);
    2bf3:	41 b8 80 00 00 00    	mov    $0x80,%r8d
    2bf9:	31 d2                	xor    %edx,%edx
    2bfb:	31 f6                	xor    %esi,%esi
    2bfd:	b9 80 00 00 00       	mov    $0x80,%ecx
    2c02:	48 89 df             	mov    %rbx,%rdi
    2c05:	e8 72 03 00 00       	callq  2f7c <_ZN11CommandList13drawFilledBoxEssss>
    cmdList.setFont(&TITLE_FONT);
    2c0a:	48 8d 35 cf 40 00 00 	lea    0x40cf(%rip),%rsi        # 6ce0 <_ZL6Org_01>
    2c11:	48 89 df             	mov    %rbx,%rdi
    2c14:	e8 5b 05 00 00       	callq  3174 <_ZN11CommandList7setFontEPK7GFXfont>
    cmdList.setColors(COLOR_TITLE, COLOR_TITLE);
    2c19:	ba ff ff 00 00       	mov    $0xffff,%edx
    2c1e:	be ff ff 00 00       	mov    $0xffff,%esi
    2c23:	48 89 df             	mov    %rbx,%rdi
    2c26:	e8 31 05 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
    cmdList.drawText(4, 0, dispParams.titleText);
    2c2b:	31 d2                	xor    %edx,%edx
    2c2d:	49 8d 4e 05          	lea    0x5(%r14),%rcx
    2c31:	be 04 00 00 00       	mov    $0x4,%esi
    2c36:	48 89 df             	mov    %rbx,%rdi
    2c39:	e8 9c 04 00 00       	callq  30da <_ZN11CommandList8drawTextEssPKc>
    cmdList.setFont(&DEFAULT_FONT);
    2c3e:	48 8d 35 bb 40 00 00 	lea    0x40bb(%rip),%rsi        # 6d00 <_ZL9Picopixel>
    2c45:	48 89 df             	mov    %rbx,%rdi
    2c48:	e8 27 05 00 00       	callq  3174 <_ZN11CommandList7setFontEPK7GFXfont>
    2c4d:	41 8b 06             	mov    (%r14),%eax
        drawIcon(cmdList, 24, 8, voiceParams.conn, col);
    2c50:	45 8a 44 24 14       	mov    0x14(%r12),%r8b
    2c55:	48 89 de             	mov    %rbx,%rsi
    2c58:	b9 08 00 00 00       	mov    $0x8,%ecx
    2c5d:	ba 18 00 00 00       	mov    $0x18,%edx
    2c62:	48 89 ef             	mov    %rbp,%rdi
    2c65:	83 e0 04             	and    $0x4,%eax
        col = dispParams.shouldSelect(SelectFlags::CONN) ? COLOR_SELECTED : COLOR_DEFAULT;
    2c68:	83 f8 01             	cmp    $0x1,%eax
    2c6b:	45 19 c9             	sbb    %r9d,%r9d
        drawIcon(cmdList, 24, 8, voiceParams.conn, col);
    2c6e:	41 83 e0 0f          	and    $0xf,%r8d
        col = dispParams.shouldSelect(SelectFlags::CONN) ? COLOR_SELECTED : COLOR_DEFAULT;
    2c72:	66 41 81 c9 e0 07    	or     $0x7e0,%r9w
        drawIcon(cmdList, 24, 8, voiceParams.conn, col);
    2c78:	45 0f b7 c9          	movzwl %r9w,%r9d
    2c7c:	e8 15 f9 ff ff       	callq  2596 <_ZN2UI8drawIconER11CommandListiiit>
        sprintf(s_textBuffer, "%iHz", (int)voiceParams.freq); 
    2c81:	f3 41 0f 2c 54 24 10 	cvttss2si 0x10(%r12),%edx
    2c88:	48 8d 35 63 15 00 00 	lea    0x1563(%rip),%rsi        # 41f2 <_ZN4OPL3L6OP_OFFE+0x52>
    2c8f:	31 c0                	xor    %eax,%eax
    2c91:	48 8d 3d 08 63 00 00 	lea    0x6308(%rip),%rdi        # 8fa0 <_ZL12s_textBuffer>
    2c98:	e8 48 f6 ff ff       	callq  22e5 <sprintf_>
        cmdList.drawText(88, 8, s_textBuffer);  
    2c9d:	48 8d 0d fc 62 00 00 	lea    0x62fc(%rip),%rcx        # 8fa0 <_ZL12s_textBuffer>
    2ca4:	ba 08 00 00 00       	mov    $0x8,%edx
    2ca9:	48 89 df             	mov    %rbx,%rdi
    2cac:	be 58 00 00 00       	mov    $0x58,%esi
    2cb1:	e8 24 04 00 00       	callq  30da <_ZN11CommandList8drawTextEssPKc>
    2cb6:	41 8b 06             	mov    (%r14),%eax
        drawIcon(cmdList, 50, 8, 14, col);
    2cb9:	b9 08 00 00 00       	mov    $0x8,%ecx
    2cbe:	48 89 de             	mov    %rbx,%rsi
    2cc1:	41 b8 0e 00 00 00    	mov    $0xe,%r8d
    2cc7:	ba 32 00 00 00       	mov    $0x32,%edx
    2ccc:	48 89 ef             	mov    %rbp,%rdi
    2ccf:	83 e0 02             	and    $0x2,%eax
        col = dispParams.shouldSelect(SelectFlags::FEEDBACK) ? COLOR_SELECTED : COLOR_DEFAULT;
    2cd2:	83 f8 01             	cmp    $0x1,%eax
    2cd5:	45 19 c9             	sbb    %r9d,%r9d
        cmdList.drawText(66, 8, s_textBuffer);  
    2cd8:	45 31 ed             	xor    %r13d,%r13d
        col = dispParams.shouldSelect(SelectFlags::FEEDBACK) ? COLOR_SELECTED : COLOR_DEFAULT;
    2cdb:	66 41 81 c9 e0 07    	or     $0x7e0,%r9w
        drawIcon(cmdList, 50, 8, 14, col);
    2ce1:	45 0f b7 c9          	movzwl %r9w,%r9d
    2ce5:	e8 ac f8 ff ff       	callq  2596 <_ZN2UI8drawIconER11CommandListiiit>
        sprintf(s_textBuffer, "%i", (int)voiceParams.feedback); 
    2cea:	41 8a 54 24 14       	mov    0x14(%r12),%dl
    2cef:	48 8d 35 01 15 00 00 	lea    0x1501(%rip),%rsi        # 41f7 <_ZN4OPL3L6OP_OFFE+0x57>
    2cf6:	31 c0                	xor    %eax,%eax
    2cf8:	48 8d 3d a1 62 00 00 	lea    0x62a1(%rip),%rdi        # 8fa0 <_ZL12s_textBuffer>
    2cff:	c0 ea 04             	shr    $0x4,%dl
    2d02:	0f b6 d2             	movzbl %dl,%edx
    2d05:	e8 db f5 ff ff       	callq  22e5 <sprintf_>
        cmdList.drawText(66, 8, s_textBuffer);  
    2d0a:	48 8d 0d 8f 62 00 00 	lea    0x628f(%rip),%rcx        # 8fa0 <_ZL12s_textBuffer>
    2d11:	ba 08 00 00 00       	mov    $0x8,%edx
    2d16:	48 89 df             	mov    %rbx,%rdi
    2d19:	be 42 00 00 00       	mov    $0x42,%esi
    2d1e:	e8 b7 03 00 00       	callq  30da <_ZN11CommandList8drawTextEssPKc>
        int x = opOffX[i];
    2d23:	48 8d 05 26 15 00 00 	lea    0x1526(%rip),%rax        # 4250 <_ZL6opOffX>
        drawOperator(cmdList, x, y, i, dispParams, voiceParams.ops[i]);
    2d2a:	56                   	push   %rsi
    2d2b:	43 8b 0c af          	mov    (%r15,%r13,4),%ecx
    2d2f:	45 89 e8             	mov    %r13d,%r8d
    2d32:	42 8b 14 a8          	mov    (%rax,%r13,4),%edx
    2d36:	4b 8d 04 ac          	lea    (%r12,%r13,4),%rax
    2d3a:	48 89 ef             	mov    %rbp,%rdi
    2d3d:	4d 89 f1             	mov    %r14,%r9
    2d40:	50                   	push   %rax
    2d41:	48 89 de             	mov    %rbx,%rsi
    2d44:	49 ff c5             	inc    %r13
    2d47:	e8 34 fd ff ff       	callq  2a80 <_ZN2UI12drawOperatorER11CommandListiiiRK13DisplayParamsRK14OperatorParams>
    for (int i = 0; i < 4; ++i)
    2d4c:	5f                   	pop    %rdi
    2d4d:	41 58                	pop    %r8
    2d4f:	49 83 fd 04          	cmp    $0x4,%r13
    2d53:	75 ce                	jne    2d23 <_ZN2UI4drawER11CommandListRK13DisplayParamsRK11VoiceParams+0x15b>
    cmdList.setColors(COLOR_DEFAULT, COLOR_BACKGROUND);
    2d55:	48 89 df             	mov    %rbx,%rdi
    2d58:	31 d2                	xor    %edx,%edx
    2d5a:	be ff ff 00 00       	mov    $0xffff,%esi
    2d5f:	e8 f8 03 00 00       	callq  315c <_ZN11CommandList9setColorsEtt>
    cmdList.drawHLine(4, opOffY[2] - 4, 120);
    2d64:	48 89 df             	mov    %rbx,%rdi
    2d67:	b9 78 00 00 00       	mov    $0x78,%ecx
    2d6c:	ba 4a 00 00 00       	mov    $0x4a,%edx
    2d71:	be 04 00 00 00       	mov    $0x4,%esi
    2d76:	e8 57 00 00 00       	callq  2dd2 <_ZN11CommandList9drawHLineEsss>
    cmdList.drawVLine(opOffX[1] - 4, 24, 128 - 24);
    2d7b:	48 89 df             	mov    %rbx,%rdi
    2d7e:	b9 68 00 00 00       	mov    $0x68,%ecx
    2d83:	be 40 00 00 00       	mov    $0x40,%esi
    2d88:	ba 18 00 00 00       	mov    $0x18,%edx
    2d8d:	e8 9c 00 00 00       	callq  2e2e <_ZN11CommandList9drawVLineEsss>
    prevSelectFlags_ = dispParams.selectFlags;
    2d92:	41 8b 06             	mov    (%r14),%eax
    voiceParams_ = voiceParams;
    2d95:	48 8d 7d 30          	lea    0x30(%rbp),%rdi
    2d99:	4c 89 e6             	mov    %r12,%rsi
    2d9c:	b9 16 00 00 00       	mov    $0x16,%ecx
    prevSelectFlags_ = dispParams.selectFlags;
    2da1:	89 45 2c             	mov    %eax,0x2c(%rbp)
    prevSelectedVoice_ = dispParams.selectedVoice;
    2da4:	41 8b 46 28          	mov    0x28(%r14),%eax
    2da8:	89 45 28             	mov    %eax,0x28(%rbp)
    voiceParams_ = voiceParams;
    2dab:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
}
    2dad:	58                   	pop    %rax
    2dae:	5b                   	pop    %rbx
    2daf:	5d                   	pop    %rbp
    2db0:	41 5c                	pop    %r12
    2db2:	41 5d                	pop    %r13
    2db4:	41 5e                	pop    %r14
    2db6:	41 5f                	pop    %r15
    2db8:	c3                   	retq   
    2db9:	90                   	nop

0000000000002dba <_ZN11CommandListC1EPhj>:

#include <memory.h>

CommandList::CommandList(uint8_t* buffer, uint32_t bufferSize)
    : bufferBegin_(buffer)
    , bufferEnd_(buffer + bufferSize)
    2dba:	89 d2                	mov    %edx,%edx
    , bufferCurr_(buffer)
    , cursorX_(0)
    , cursorY_(0)
    2dbc:	48 89 37             	mov    %rsi,(%rdi)
    , bufferEnd_(buffer + bufferSize)
    2dbf:	48 01 f2             	add    %rsi,%rdx
    , cursorY_(0)
    2dc2:	48 89 77 10          	mov    %rsi,0x10(%rdi)
    , bufferEnd_(buffer + bufferSize)
    2dc6:	48 89 57 08          	mov    %rdx,0x8(%rdi)
    , cursorY_(0)
    2dca:	c7 47 18 00 00 00 00 	movl   $0x0,0x18(%rdi)
{

}
    2dd1:	c3                   	retq   

0000000000002dd2 <_ZN11CommandList9drawHLineEsss>:

private:
    template<typename COMMAND_T>
    COMMAND_T* alloc()
    {
        uint8_t* bufferNext = bufferCurr_ + sizeof(COMMAND_T);
    2dd2:	48 8b 47 10          	mov    0x10(%rdi),%rax

void CommandList::drawHLine(int16_t x, int16_t y, int16_t w)
{
    auto* cmd = alloc<CommandDrawHLine>();
    cmd->x = x + cursorX_;
    2dd6:	03 77 18             	add    0x18(%rdi),%esi
    2dd9:	66 81 e6 ff 07       	and    $0x7ff,%si
    cmd->y = y + cursorY_;
    2dde:	66 03 57 1a          	add    0x1a(%rdi),%dx
    2de2:	4c 8d 40 08          	lea    0x8(%rax),%r8
    2de6:	66 81 e2 ff 07       	and    $0x7ff,%dx
    2deb:	4c 89 47 10          	mov    %r8,0x10(%rdi)
    cmd->x = x + cursorX_;
    2def:	41 89 f0             	mov    %esi,%r8d
    2df2:	66 8b 70 02          	mov    0x2(%rax),%si
static_assert((int)CommandType::MAX < 16, "Exceeded maximum number of commands supported.");

struct BaseCommand
{
    BaseCommand(CommandType inType)
        : type(inType)
    2df6:	c6 00 01             	movb   $0x1,(%rax)
    2df9:	66 81 e6 00 f8       	and    $0xf800,%si
    2dfe:	44 09 c6             	or     %r8d,%esi
    2e01:	66 89 70 02          	mov    %si,0x2(%rax)
    cmd->y = y + cursorY_;
    2e05:	89 d6                	mov    %edx,%esi
    2e07:	66 8b 50 04          	mov    0x4(%rax),%dx
    2e0b:	66 81 e2 00 f8       	and    $0xf800,%dx
    2e10:	09 f2                	or     %esi,%edx
    2e12:	66 89 50 04          	mov    %dx,0x4(%rax)
    cmd->w = w;
    2e16:	89 ca                	mov    %ecx,%edx
    2e18:	66 8b 48 06          	mov    0x6(%rax),%cx
    2e1c:	66 81 e2 ff 03       	and    $0x3ff,%dx
    2e21:	66 81 e1 00 fc       	and    $0xfc00,%cx
    2e26:	09 d1                	or     %edx,%ecx
    2e28:	66 89 48 06          	mov    %cx,0x6(%rax)
}
    2e2c:	c3                   	retq   
    2e2d:	90                   	nop

0000000000002e2e <_ZN11CommandList9drawVLineEsss>:
    2e2e:	48 8b 47 10          	mov    0x10(%rdi),%rax

void CommandList::drawVLine(int16_t x, int16_t y, int16_t h)
{
    auto* cmd = alloc<CommandDrawVLine>();
    cmd->x = x + cursorX_;
    2e32:	03 77 18             	add    0x18(%rdi),%esi
    2e35:	66 81 e6 ff 07       	and    $0x7ff,%si
    cmd->y = y + cursorY_;
    2e3a:	66 03 57 1a          	add    0x1a(%rdi),%dx
    2e3e:	4c 8d 40 08          	lea    0x8(%rax),%r8
    2e42:	66 81 e2 ff 07       	and    $0x7ff,%dx
    2e47:	4c 89 47 10          	mov    %r8,0x10(%rdi)
    cmd->x = x + cursorX_;
    2e4b:	41 89 f0             	mov    %esi,%r8d
    2e4e:	66 8b 70 02          	mov    0x2(%rax),%si
    2e52:	c6 00 02             	movb   $0x2,(%rax)
    2e55:	66 81 e6 00 f8       	and    $0xf800,%si
    2e5a:	44 09 c6             	or     %r8d,%esi
    2e5d:	66 89 70 02          	mov    %si,0x2(%rax)
    cmd->y = y + cursorY_;
    2e61:	89 d6                	mov    %edx,%esi
    2e63:	66 8b 50 04          	mov    0x4(%rax),%dx
    2e67:	66 81 e2 00 f8       	and    $0xf800,%dx
    2e6c:	09 f2                	or     %esi,%edx
    2e6e:	66 89 50 04          	mov    %dx,0x4(%rax)
    cmd->h = h;
    2e72:	89 ca                	mov    %ecx,%edx
    2e74:	66 8b 48 06          	mov    0x6(%rax),%cx
    2e78:	66 81 e2 ff 03       	and    $0x3ff,%dx
    2e7d:	66 81 e1 00 fc       	and    $0xfc00,%cx
    2e82:	09 d1                	or     %edx,%ecx
    2e84:	66 89 48 06          	mov    %cx,0x6(%rax)
}
    2e88:	c3                   	retq   
    2e89:	90                   	nop

0000000000002e8a <_ZN11CommandList8drawLineEssss>:
    2e8a:	48 8b 47 10          	mov    0x10(%rdi),%rax
    2e8e:	4c 8d 48 0a          	lea    0xa(%rax),%r9
    2e92:	4c 89 4f 10          	mov    %r9,0x10(%rdi)

void CommandList::drawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1)
{
    auto* cmd = alloc<CommandDrawLine>();
    cmd->x0 = x0 + cursorX_;
    2e96:	44 8b 4f 18          	mov    0x18(%rdi),%r9d
    2e9a:	c6 00 03             	movb   $0x3,(%rax)
    2e9d:	44 01 ce             	add    %r9d,%esi
    cmd->y0 = y0 + cursorY_;
    cmd->x1 = x1 + cursorX_;
    2ea0:	41 01 c9             	add    %ecx,%r9d
    2ea3:	66 8b 48 06          	mov    0x6(%rax),%cx
    cmd->x0 = x0 + cursorX_;
    2ea7:	66 81 e6 ff 07       	and    $0x7ff,%si
    cmd->x1 = x1 + cursorX_;
    2eac:	66 41 81 e1 ff 07    	and    $0x7ff,%r9w
    cmd->x0 = x0 + cursorX_;
    2eb2:	41 89 f2             	mov    %esi,%r10d
    2eb5:	66 8b 70 02          	mov    0x2(%rax),%si
    cmd->x1 = x1 + cursorX_;
    2eb9:	66 81 e1 00 f8       	and    $0xf800,%cx
    2ebe:	41 09 c9             	or     %ecx,%r9d
    cmd->x0 = x0 + cursorX_;
    2ec1:	66 81 e6 00 f8       	and    $0xf800,%si
    2ec6:	44 09 d6             	or     %r10d,%esi
    2ec9:	66 89 70 02          	mov    %si,0x2(%rax)
    cmd->y0 = y0 + cursorY_;
    2ecd:	66 8b 77 1a          	mov    0x1a(%rdi),%si
    cmd->x1 = x1 + cursorX_;
    2ed1:	66 44 89 48 06       	mov    %r9w,0x6(%rax)
    cmd->y0 = y0 + cursorY_;
    2ed6:	01 f2                	add    %esi,%edx
    cmd->y1 = y1 + cursorY_;
    2ed8:	41 01 f0             	add    %esi,%r8d
    2edb:	66 8b 70 08          	mov    0x8(%rax),%si
    cmd->y0 = y0 + cursorY_;
    2edf:	89 d7                	mov    %edx,%edi
    2ee1:	66 8b 50 04          	mov    0x4(%rax),%dx
    cmd->y1 = y1 + cursorY_;
    2ee5:	66 41 81 e0 ff 07    	and    $0x7ff,%r8w
    cmd->y0 = y0 + cursorY_;
    2eeb:	66 81 e7 ff 07       	and    $0x7ff,%di
    cmd->y1 = y1 + cursorY_;
    2ef0:	66 81 e6 00 f8       	and    $0xf800,%si
    cmd->y0 = y0 + cursorY_;
    2ef5:	66 81 e2 00 f8       	and    $0xf800,%dx
    cmd->y1 = y1 + cursorY_;
    2efa:	41 09 f0             	or     %esi,%r8d
    cmd->y0 = y0 + cursorY_;
    2efd:	09 fa                	or     %edi,%edx
    cmd->y1 = y1 + cursorY_;
    2eff:	66 44 89 40 08       	mov    %r8w,0x8(%rax)
    cmd->y0 = y0 + cursorY_;
    2f04:	66 89 50 04          	mov    %dx,0x4(%rax)
}
    2f08:	c3                   	retq   
    2f09:	90                   	nop

0000000000002f0a <_ZN11CommandList7drawBoxEssss>:
    2f0a:	48 8b 47 10          	mov    0x10(%rdi),%rax

void CommandList::drawBox(int16_t x, int16_t y, int16_t w, int16_t h)
{
    auto* cmd = alloc<CommandDrawBox>();
    cmd->x = x + cursorX_;
    2f0e:	03 77 18             	add    0x18(%rdi),%esi
    cmd->y = y + cursorY_;
    cmd->w = w;
    cmd->h = h;
    2f11:	66 41 81 e0 ff 03    	and    $0x3ff,%r8w
    cmd->x = x + cursorX_;
    2f17:	66 81 e6 ff 07       	and    $0x7ff,%si
    cmd->y = y + cursorY_;
    2f1c:	66 03 57 1a          	add    0x1a(%rdi),%dx
    2f20:	4c 8d 48 0a          	lea    0xa(%rax),%r9
    2f24:	66 81 e2 ff 07       	and    $0x7ff,%dx
    2f29:	4c 89 4f 10          	mov    %r9,0x10(%rdi)
    cmd->x = x + cursorX_;
    2f2d:	41 89 f1             	mov    %esi,%r9d
    2f30:	66 8b 70 02          	mov    0x2(%rax),%si
    2f34:	c6 00 04             	movb   $0x4,(%rax)
    2f37:	66 81 e6 00 f8       	and    $0xf800,%si
    2f3c:	44 09 ce             	or     %r9d,%esi
    2f3f:	66 89 70 02          	mov    %si,0x2(%rax)
    cmd->y = y + cursorY_;
    2f43:	89 d6                	mov    %edx,%esi
    2f45:	66 8b 50 04          	mov    0x4(%rax),%dx
    2f49:	66 81 e2 00 f8       	and    $0xf800,%dx
    2f4e:	09 f2                	or     %esi,%edx
    2f50:	66 89 50 04          	mov    %dx,0x4(%rax)
    cmd->w = w;
    2f54:	89 ca                	mov    %ecx,%edx
    2f56:	66 8b 48 06          	mov    0x6(%rax),%cx
    2f5a:	66 81 e2 ff 03       	and    $0x3ff,%dx
    2f5f:	66 81 e1 00 fc       	and    $0xfc00,%cx
    2f64:	09 d1                	or     %edx,%ecx
    cmd->h = h;
    2f66:	66 8b 50 08          	mov    0x8(%rax),%dx
    cmd->w = w;
    2f6a:	66 89 48 06          	mov    %cx,0x6(%rax)
    cmd->h = h;
    2f6e:	66 81 e2 00 fc       	and    $0xfc00,%dx
    2f73:	44 09 c2             	or     %r8d,%edx
    2f76:	66 89 50 08          	mov    %dx,0x8(%rax)
}
    2f7a:	c3                   	retq   
    2f7b:	90                   	nop

0000000000002f7c <_ZN11CommandList13drawFilledBoxEssss>:
    2f7c:	48 8b 47 10          	mov    0x10(%rdi),%rax

void CommandList::drawFilledBox(int16_t x, int16_t y, int16_t w, int16_t h)
{
    auto* cmd = alloc<CommandDrawFilledBox>();
    cmd->x = x + cursorX_;
    2f80:	03 77 18             	add    0x18(%rdi),%esi
    cmd->y = y + cursorY_;
    cmd->w = w;
    cmd->h = h;
    2f83:	66 41 81 e0 ff 03    	and    $0x3ff,%r8w
    cmd->x = x + cursorX_;
    2f89:	66 81 e6 ff 07       	and    $0x7ff,%si
    cmd->y = y + cursorY_;
    2f8e:	66 03 57 1a          	add    0x1a(%rdi),%dx
    2f92:	4c 8d 48 0a          	lea    0xa(%rax),%r9
    2f96:	66 81 e2 ff 07       	and    $0x7ff,%dx
    2f9b:	4c 89 4f 10          	mov    %r9,0x10(%rdi)
    cmd->x = x + cursorX_;
    2f9f:	41 89 f1             	mov    %esi,%r9d
    2fa2:	66 8b 70 02          	mov    0x2(%rax),%si
    2fa6:	c6 00 05             	movb   $0x5,(%rax)
    2fa9:	66 81 e6 00 f8       	and    $0xf800,%si
    2fae:	44 09 ce             	or     %r9d,%esi
    2fb1:	66 89 70 02          	mov    %si,0x2(%rax)
    cmd->y = y + cursorY_;
    2fb5:	89 d6                	mov    %edx,%esi
    2fb7:	66 8b 50 04          	mov    0x4(%rax),%dx
    2fbb:	66 81 e2 00 f8       	and    $0xf800,%dx
    2fc0:	09 f2                	or     %esi,%edx
    2fc2:	66 89 50 04          	mov    %dx,0x4(%rax)
    cmd->w = w;
    2fc6:	89 ca                	mov    %ecx,%edx
    2fc8:	66 8b 48 06          	mov    0x6(%rax),%cx
    2fcc:	66 81 e2 ff 03       	and    $0x3ff,%dx
    2fd1:	66 81 e1 00 fc       	and    $0xfc00,%cx
    2fd6:	09 d1                	or     %edx,%ecx
    cmd->h = h;
    2fd8:	66 8b 50 08          	mov    0x8(%rax),%dx
    cmd->w = w;
    2fdc:	66 89 48 06          	mov    %cx,0x6(%rax)
    cmd->h = h;
    2fe0:	66 81 e2 00 fc       	and    $0xfc00,%dx
    2fe5:	44 09 c2             	or     %r8d,%edx
    2fe8:	66 89 50 08          	mov    %dx,0x8(%rax)
}
    2fec:	c3                   	retq   
    2fed:	90                   	nop

0000000000002fee <_ZN11CommandList10drawBitmapEssssPKh>:
    2fee:	48 8b 47 10          	mov    0x10(%rdi),%rax

void CommandList::drawBitmap(int16_t x, int16_t y, int16_t w, int16_t h, const uint8_t* bitmapData)
{
    auto* cmd = alloc<CommandDrawBitmap>();
    cmd->x = x + cursorX_;
    2ff2:	03 77 18             	add    0x18(%rdi),%esi
    cmd->y = y + cursorY_;
    cmd->w = w;
    cmd->h = h;
    2ff5:	66 41 81 e0 ff 03    	and    $0x3ff,%r8w
    cmd->x = x + cursorX_;
    2ffb:	66 81 e6 ff 07       	and    $0x7ff,%si
    cmd->y = y + cursorY_;
    3000:	66 03 57 1a          	add    0x1a(%rdi),%dx
    3004:	4c 8d 50 18          	lea    0x18(%rax),%r10
    3008:	66 81 e2 ff 07       	and    $0x7ff,%dx
    300d:	4c 89 57 10          	mov    %r10,0x10(%rdi)
    cmd->x = x + cursorX_;
    3011:	41 89 f2             	mov    %esi,%r10d
    3014:	66 8b 70 02          	mov    0x2(%rax),%si
    3018:	c6 00 06             	movb   $0x6,(%rax)
    301b:	66 81 e6 00 f8       	and    $0xf800,%si
    cmd->data = bitmapData;
    3020:	4c 89 48 10          	mov    %r9,0x10(%rax)
    cmd->x = x + cursorX_;
    3024:	44 09 d6             	or     %r10d,%esi
    3027:	66 89 70 02          	mov    %si,0x2(%rax)
    cmd->y = y + cursorY_;
    302b:	89 d6                	mov    %edx,%esi
    302d:	66 8b 50 04          	mov    0x4(%rax),%dx
    3031:	66 81 e2 00 f8       	and    $0xf800,%dx
    3036:	09 f2                	or     %esi,%edx
    3038:	66 89 50 04          	mov    %dx,0x4(%rax)
    cmd->w = w;
    303c:	89 ca                	mov    %ecx,%edx
    303e:	66 8b 48 06          	mov    0x6(%rax),%cx
    3042:	66 81 e2 ff 03       	and    $0x3ff,%dx
    3047:	66 81 e1 00 fc       	and    $0xfc00,%cx
    304c:	09 d1                	or     %edx,%ecx
    cmd->h = h;
    304e:	66 8b 50 08          	mov    0x8(%rax),%dx
    cmd->w = w;
    3052:	66 89 48 06          	mov    %cx,0x6(%rax)
    cmd->h = h;
    3056:	66 81 e2 00 fc       	and    $0xfc00,%dx
    305b:	44 09 c2             	or     %r8d,%edx
    305e:	66 89 50 08          	mov    %dx,0x8(%rax)
}
    3062:	c3                   	retq   
    3063:	90                   	nop

0000000000003064 <_ZN11CommandList10drawPixelsEssssPKt>:
    3064:	48 8b 47 10          	mov    0x10(%rdi),%rax

void CommandList::drawPixels(int16_t x, int16_t y, int16_t w, int16_t h, const uint16_t* pixelData)
{
    auto* cmd = alloc<CommandDrawPixels>();
    cmd->x = x + cursorX_;
    3068:	03 77 18             	add    0x18(%rdi),%esi
    cmd->y = y + cursorY_;
    cmd->w = w;
    cmd->h = h;
    306b:	66 41 81 e0 ff 03    	and    $0x3ff,%r8w
    cmd->x = x + cursorX_;
    3071:	66 81 e6 ff 07       	and    $0x7ff,%si
    cmd->y = y + cursorY_;
    3076:	66 03 57 1a          	add    0x1a(%rdi),%dx
    307a:	4c 8d 50 18          	lea    0x18(%rax),%r10
    307e:	66 81 e2 ff 07       	and    $0x7ff,%dx
    3083:	4c 89 57 10          	mov    %r10,0x10(%rdi)
    cmd->x = x + cursorX_;
    3087:	41 89 f2             	mov    %esi,%r10d
    308a:	66 8b 70 02          	mov    0x2(%rax),%si
    308e:	c6 00 07             	movb   $0x7,(%rax)
    3091:	66 81 e6 00 f8       	and    $0xf800,%si
    cmd->data = pixelData;
    3096:	4c 89 48 10          	mov    %r9,0x10(%rax)
    cmd->x = x + cursorX_;
    309a:	44 09 d6             	or     %r10d,%esi
    309d:	66 89 70 02          	mov    %si,0x2(%rax)
    cmd->y = y + cursorY_;
    30a1:	89 d6                	mov    %edx,%esi
    30a3:	66 8b 50 04          	mov    0x4(%rax),%dx
    30a7:	66 81 e2 00 f8       	and    $0xf800,%dx
    30ac:	09 f2                	or     %esi,%edx
    30ae:	66 89 50 04          	mov    %dx,0x4(%rax)
    cmd->w = w;
    30b2:	89 ca                	mov    %ecx,%edx
    30b4:	66 8b 48 06          	mov    0x6(%rax),%cx
    30b8:	66 81 e2 ff 03       	and    $0x3ff,%dx
    30bd:	66 81 e1 00 fc       	and    $0xfc00,%cx
    30c2:	09 d1                	or     %edx,%ecx
    cmd->h = h;
    30c4:	66 8b 50 08          	mov    0x8(%rax),%dx
    cmd->w = w;
    30c8:	66 89 48 06          	mov    %cx,0x6(%rax)
    cmd->h = h;
    30cc:	66 81 e2 00 fc       	and    $0xfc00,%dx
    30d1:	44 09 c2             	or     %r8d,%edx
    30d4:	66 89 50 08          	mov    %dx,0x8(%rax)
}
    30d8:	c3                   	retq   
    30d9:	90                   	nop

00000000000030da <_ZN11CommandList8drawTextEssPKc>:
    30da:	4c 8b 47 10          	mov    0x10(%rdi),%r8

void CommandList::drawText(int16_t x, int16_t y, const char* text)
{
    auto* cmd = alloc<CommandDrawText>();
    cmd->x = x + cursorX_;
    30de:	03 77 18             	add    0x18(%rdi),%esi
{
    30e1:	49 89 cb             	mov    %rcx,%r11
    30e4:	49 89 f9             	mov    %rdi,%r9
    cmd->x = x + cursorX_;
    30e7:	89 f0                	mov    %esi,%eax
    cmd->y = y + cursorY_;
    30e9:	66 03 57 1a          	add    0x1a(%rdi),%dx
    cmd->length = strlen(text) + 1;
    30ed:	48 83 c9 ff          	or     $0xffffffffffffffff,%rcx
    cmd->x = x + cursorX_;
    30f1:	66 41 8b 70 02       	mov    0x2(%r8),%si
    30f6:	4d 8d 50 08          	lea    0x8(%r8),%r10
    30fa:	66 25 ff 07          	and    $0x7ff,%ax
        {
            return nullptr;
        }
#endif
        void* cmd = reinterpret_cast<COMMAND_T*>(bufferCurr_);
        bufferCurr_ = bufferNext;
    30fe:	4c 89 57 10          	mov    %r10,0x10(%rdi)
    cmd->length = strlen(text) + 1;
    3102:	4c 89 df             	mov    %r11,%rdi
    cmd->x = x + cursorX_;
    3105:	66 81 e6 00 f8       	and    $0xf800,%si
    310a:	41 c6 00 08          	movb   $0x8,(%r8)
    310e:	09 c6                	or     %eax,%esi
    cmd->y = y + cursorY_;
    3110:	89 d0                	mov    %edx,%eax
    3112:	66 41 8b 50 04       	mov    0x4(%r8),%dx
    3117:	66 25 ff 07          	and    $0x7ff,%ax
    cmd->x = x + cursorX_;
    311b:	66 41 89 70 02       	mov    %si,0x2(%r8)
#endif

__fortify_function char *
__NTH (strcpy (char *__restrict __dest, const char *__restrict __src))
{
  return __builtin___strcpy_chk (__dest, __src, __bos (__dest));
    3120:	4c 89 de             	mov    %r11,%rsi
    cmd->y = y + cursorY_;
    3123:	66 81 e2 00 f8       	and    $0xf800,%dx
    3128:	09 c2                	or     %eax,%edx
    cmd->length = strlen(text) + 1;
    312a:	31 c0                	xor    %eax,%eax
    cmd->y = y + cursorY_;
    312c:	66 41 89 50 04       	mov    %dx,0x4(%r8)
    cmd->length = strlen(text) + 1;
    3131:	f2 ae                	repnz scas %es:(%rdi),%al
    3133:	66 41 8b 40 06       	mov    0x6(%r8),%ax
    3138:	4c 89 d7             	mov    %r10,%rdi
    313b:	66 25 00 fc          	and    $0xfc00,%ax
    313f:	f7 d1                	not    %ecx
    3141:	66 81 e1 ff 03       	and    $0x3ff,%cx
    3146:	09 c8                	or     %ecx,%eax
    }

    template<typename DATA_T>
    DATA_T* allocData(uint16_t num)
    {
        uint8_t* bufferNext = bufferCurr_ + sizeof(DATA_T) * num;
    3148:	0f b7 c9             	movzwl %cx,%ecx
    314b:	4c 01 d1             	add    %r10,%rcx
    314e:	66 41 89 40 06       	mov    %ax,0x6(%r8)
    3153:	49 89 49 10          	mov    %rcx,0x10(%r9)
    3157:	e9 04 df ff ff       	jmpq   1060 <strcpy@plt>

000000000000315c <_ZN11CommandList9setColorsEtt>:
        uint8_t* bufferNext = bufferCurr_ + sizeof(COMMAND_T);
    315c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    3160:	48 8d 48 06          	lea    0x6(%rax),%rcx
    3164:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    3168:	c6 00 09             	movb   $0x9,(%rax)
}

void CommandList::setColors(uint16_t fg, uint16_t bg)
{
    auto* cmd = alloc<CommandSetColors>();
    cmd->fg = fg;
    316b:	66 89 70 02          	mov    %si,0x2(%rax)
    cmd->bg = bg;
    316f:	66 89 50 04          	mov    %dx,0x4(%rax)
}
    3173:	c3                   	retq   

0000000000003174 <_ZN11CommandList7setFontEPK7GFXfont>:
    3174:	48 8b 47 10          	mov    0x10(%rdi),%rax
    3178:	48 8d 50 10          	lea    0x10(%rax),%rdx
    317c:	48 89 57 10          	mov    %rdx,0x10(%rdi)
    3180:	c6 00 0a             	movb   $0xa,(%rax)

void CommandList::setFont(const GFXfont* font)
{
    auto* cmd = alloc<CommandSetFont>();
    cmd->font = font;
    3183:	48 89 70 08          	mov    %rsi,0x8(%rax)
}
    3187:	c3                   	retq   

0000000000003188 <_ZN11CommandList9setCursorEss>:

void CommandList::setCursor(int16_t x, int16_t y)
{
    cursorX_ = x;
    3188:	66 89 77 18          	mov    %si,0x18(%rdi)
    cursorY_ = y;
    318c:	66 89 57 1a          	mov    %dx,0x1a(%rdi)
}
    3190:	c3                   	retq   
    3191:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
    3198:	00 00 00 
    319b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000031a0 <_ZN14BaseTileCanvas11writePixelsEssssPKt>:
    
    const int16_t wminx = x;
    const int16_t wminy = y;
    const int16_t wmaxx = wminx + w;
    const int16_t wmaxy = wminy + h;
    const int16_t tminx = currTile_->x_;
    31a0:	4c 8b 97 b8 00 00 00 	mov    0xb8(%rdi),%r10
    const int16_t tminy = currTile_->y_;
    const int16_t tmaxx = tminx + tileW_;
    31a7:	44 0f b7 9f b0 00 00 	movzwl 0xb0(%rdi),%r11d
    31ae:	00 
    const int16_t tminx = currTile_->x_;
    31af:	41 0f b7 02          	movzwl (%r10),%eax
    const int16_t tminy = currTile_->y_;
    31b3:	45 0f b7 52 02       	movzwl 0x2(%r10),%r10d
    const int16_t tmaxx = tminx + tileW_;
    31b8:	41 01 c3             	add    %eax,%r11d
    const int16_t tmaxy = tminy + tileH_;
    if(wminx > tmaxx || wminy > tmaxy ||
    31bb:	66 41 39 f3          	cmp    %si,%r11w
    31bf:	0f 8c fb 00 00 00    	jl     32c0 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0x120>
    const int16_t tmaxy = tminy + tileH_;
    31c5:	44 0f b7 9f b2 00 00 	movzwl 0xb2(%rdi),%r11d
    31cc:	00 
    31cd:	45 01 d3             	add    %r10d,%r11d
    if(wminx > tmaxx || wminy > tmaxy ||
    31d0:	66 41 39 d3          	cmp    %dx,%r11w
    31d4:	0f 8c e6 00 00 00    	jl     32c0 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0x120>
    const int16_t wmaxx = wminx + w;
    31da:	44 8d 1c 31          	lea    (%rcx,%rsi,1),%r11d
       wmaxx < tminx || wmaxy < tminy)
    31de:	66 41 39 c3          	cmp    %ax,%r11w
    31e2:	0f 8c d8 00 00 00    	jl     32c0 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0x120>
    const int16_t wmaxy = wminy + h;
    31e8:	45 8d 1c 10          	lea    (%r8,%rdx,1),%r11d
       wmaxx < tminx || wmaxy < tminy)
    31ec:	66 45 39 d3          	cmp    %r10w,%r11w
    31f0:	0f 8c ca 00 00 00    	jl     32c0 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0x120>
    {
        return;
    }
    {
        x -= tminx;
    31f6:	29 c6                	sub    %eax,%esi
        y -= tminy;
    31f8:	44 29 d2             	sub    %r10d,%edx

        for(int j = 0; j < h; ++j)
    31fb:	66 45 85 c0          	test   %r8w,%r8w
    31ff:	0f 8e bb 00 00 00    	jle    32c0 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0x120>
    3205:	66 85 c9             	test   %cx,%cx
    3208:	0f 8e b2 00 00 00    	jle    32c0 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0x120>
    320e:	0f bf c9             	movswl %cx,%ecx
{
    3211:	41 56                	push   %r14
    3213:	41 55                	push   %r13
    3215:	44 8d 14 0e          	lea    (%rsi,%rcx,1),%r10d
    3219:	41 54                	push   %r12
    321b:	44 8d 61 ff          	lea    -0x1(%rcx),%r12d
    321f:	49 83 c4 01          	add    $0x1,%r12
    3223:	55                   	push   %rbp
    3224:	4d 01 e4             	add    %r12,%r12
    3227:	53                   	push   %rbx
    3228:	42 8d 1c 02          	lea    (%rdx,%r8,1),%ebx
    322c:	0f 1f 40 00          	nopl   0x0(%rax)
        {
            int16_t ny = y + j;
            int16_t nx = x;
            for(int i = 0; i < w; ++i)
            {
                if(nx >= 0 && nx < tileW_ && ny >= 0 && ny < tileH_)
    3230:	41 89 d3             	mov    %edx,%r11d
            int16_t nx = x;
    3233:	89 f0                	mov    %esi,%eax
            int16_t ny = y + j;
    3235:	4c 89 c9             	mov    %r9,%rcx
                    pixBuffer_[nx + ny * tileW_] = *data;
    3238:	0f bf ea             	movswl %dx,%ebp
                if(nx >= 0 && nx < tileW_ && ny >= 0 && ny < tileH_)
    323b:	41 f7 d3             	not    %r11d
    323e:	66 41 c1 eb 0f       	shr    $0xf,%r11w
    3243:	eb 10                	jmp    3255 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0xb5>
    3245:	0f 1f 00             	nopl   (%rax)
                ++nx;
                ++data;
    3248:	83 c0 01             	add    $0x1,%eax
    324b:	48 83 c1 02          	add    $0x2,%rcx
            for(int i = 0; i < w; ++i)
    324f:	66 41 39 c2          	cmp    %ax,%r10w
    3253:	74 53                	je     32a8 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0x108>
                if(nx >= 0 && nx < tileW_ && ny >= 0 && ny < tileH_)
    3255:	66 85 c0             	test   %ax,%ax
    3258:	78 ee                	js     3248 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0xa8>
    325a:	44 0f bf 87 b0 00 00 	movswl 0xb0(%rdi),%r8d
    3261:	00 
    3262:	45 84 db             	test   %r11b,%r11b
    3265:	74 e1                	je     3248 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0xa8>
    3267:	66 41 39 c0          	cmp    %ax,%r8w
    326b:	7e db                	jle    3248 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0xa8>
    326d:	66 39 97 b2 00 00 00 	cmp    %dx,0xb2(%rdi)
    3274:	7e d2                	jle    3248 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0xa8>
                    pixBuffer_[nx + ny * tileW_] = *data;
    3276:	44 0f af c5          	imul   %ebp,%r8d
    327a:	44 0f bf e8          	movswl %ax,%r13d
    327e:	44 0f b7 31          	movzwl (%rcx),%r14d
    3282:	83 c0 01             	add    $0x1,%eax
                ++data;
    3285:	48 83 c1 02          	add    $0x2,%rcx
                    pixBuffer_[nx + ny * tileW_] = *data;
    3289:	45 01 e8             	add    %r13d,%r8d
    328c:	4c 8b af a0 00 00 00 	mov    0xa0(%rdi),%r13
    3293:	4d 63 c0             	movslq %r8d,%r8
    3296:	66 47 89 74 45 00    	mov    %r14w,0x0(%r13,%r8,2)
            for(int i = 0; i < w; ++i)
    329c:	66 41 39 c2          	cmp    %ax,%r10w
    32a0:	75 b3                	jne    3255 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0xb5>
    32a2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    32a8:	83 c2 01             	add    $0x1,%edx
    32ab:	4d 01 e1             	add    %r12,%r9
        for(int j = 0; j < h; ++j)
    32ae:	66 39 da             	cmp    %bx,%dx
    32b1:	0f 85 79 ff ff ff    	jne    3230 <_ZN14BaseTileCanvas11writePixelsEssssPKt+0x90>
            }
        }
    }
}
    32b7:	5b                   	pop    %rbx
    32b8:	5d                   	pop    %rbp
    32b9:	41 5c                	pop    %r12
    32bb:	41 5d                	pop    %r13
    32bd:	41 5e                	pop    %r14
    32bf:	c3                   	retq   
    32c0:	c3                   	retq   
    32c1:	90                   	nop
    32c2:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
    32c9:	00 00 00 00 
    32cd:	0f 1f 00             	nopl   (%rax)

00000000000032d0 <_ZN14BaseTileCanvas11writePixelsEsssst>:

    const int16_t wminx = x;
    const int16_t wminy = y;
    const int16_t wmaxx = wminx + w;
    const int16_t wmaxy = wminy + h;
    const int16_t tminx = currTile_->x_;
    32d0:	48 8b 87 b8 00 00 00 	mov    0xb8(%rdi),%rax
{
    32d7:	41 57                	push   %r15
    const int16_t wmaxy = wminy + h;
    32d9:	41 01 d0             	add    %edx,%r8d
    const int16_t wmaxx = wminx + w;
    32dc:	01 f1                	add    %esi,%ecx
{
    32de:	41 56                	push   %r14
    const int16_t tminy = currTile_->y_;
    const int16_t tmaxx = tminx + tileW_;
    const int16_t tmaxy = tminy + tileH_;
    32e0:	44 0f b7 97 b2 00 00 	movzwl 0xb2(%rdi),%r10d
    32e7:	00 
{
    32e8:	41 55                	push   %r13
    32ea:	41 54                	push   %r12
    32ec:	55                   	push   %rbp
    const int16_t tmaxx = tminx + tileW_;
    32ed:	0f bf af b0 00 00 00 	movswl 0xb0(%rdi),%ebp
{
    32f4:	53                   	push   %rbx
    const int16_t tminy = currTile_->y_;
    32f5:	0f b7 58 02          	movzwl 0x2(%rax),%ebx
    const int16_t tminx = currTile_->x_;
    32f9:	44 0f b7 20          	movzwl (%rax),%r12d
    const int16_t tmaxy = tminy + tileH_;
    32fd:	41 01 da             	add    %ebx,%r10d
    if(wminx > tmaxx || wminy > tmaxy ||
    3300:	66 41 39 d2          	cmp    %dx,%r10w
    const int16_t tmaxx = tminx + tileW_;
    3304:	46 8d 74 25 00       	lea    0x0(%rbp,%r12,1),%r14d
    if(wminx > tmaxx || wminy > tmaxy ||
    3309:	0f 9c c0             	setl   %al
    330c:	66 41 39 f6          	cmp    %si,%r14w
    3310:	41 0f 9c c3          	setl   %r11b
       wmaxx < tminx || wmaxy < tminy)
    3314:	44 09 d8             	or     %r11d,%eax
    3317:	66 41 39 d8          	cmp    %bx,%r8w
    331b:	41 0f 9c c3          	setl   %r11b
    331f:	44 08 d8             	or     %r11b,%al
    3322:	75 06                	jne    332a <_ZN14BaseTileCanvas11writePixelsEsssst+0x5a>
    3324:	66 44 39 e1          	cmp    %r12w,%cx
    3328:	7d 0e                	jge    3338 <_ZN14BaseTileCanvas11writePixelsEsssst+0x68>
                pixBuffer[nx] = c;
            }
            pixBuffer += tileW_;
        }
    }
}
    332a:	5b                   	pop    %rbx
    332b:	5d                   	pop    %rbp
    332c:	41 5c                	pop    %r12
    332e:	41 5d                	pop    %r13
    3330:	41 5e                	pop    %r14
    3332:	41 5f                	pop    %r15
    3334:	c3                   	retq   
    3335:	0f 1f 00             	nopl   (%rax)
        const int16_t minx = std::max(wminx - tminx, 0);
    3338:	0f bf c6             	movswl %si,%eax
    333b:	41 0f bf f4          	movswl %r12w,%esi
    333f:	45 31 ed             	xor    %r13d,%r13d
    3342:	29 f0                	sub    %esi,%eax
        const int16_t miny = std::max(wminy - tminy, 0);
    3344:	0f bf f2             	movswl %dx,%esi
    3347:	0f bf d3             	movswl %bx,%edx
        const int16_t minx = std::max(wminx - tminx, 0);
    334a:	41 0f 48 c5          	cmovs  %r13d,%eax
        const int16_t maxx = std::min(wmaxx, tmaxx) - tminx;
    334e:	66 44 39 f1          	cmp    %r14w,%cx
    3352:	41 0f 4f ce          	cmovg  %r14d,%ecx
        const int16_t minx = std::max(wminx - tminx, 0);
    3356:	4c 0f bf d8          	movswq %ax,%r11
        const int16_t maxx = std::min(wmaxx, tmaxx) - tminx;
    335a:	44 29 e1             	sub    %r12d,%ecx
        const int16_t miny = std::max(wminy - tminy, 0);
    335d:	29 d6                	sub    %edx,%esi
    335f:	41 0f 48 f5          	cmovs  %r13d,%esi
        uint16_t* pixBuffer = pixBuffer_ + (miny * tileW_);
    3363:	0f bf f6             	movswl %si,%esi
    3366:	0f af ee             	imul   %esi,%ebp
    3369:	48 63 d5             	movslq %ebp,%rdx
    336c:	48 01 d2             	add    %rdx,%rdx
    336f:	48 03 97 a0 00 00 00 	add    0xa0(%rdi),%rdx
        const int16_t maxy = std::min(wmaxy, tmaxy) - tminy;
    3376:	66 45 39 d0          	cmp    %r10w,%r8w
    337a:	45 0f 4e d0          	cmovle %r8d,%r10d
    337e:	41 29 da             	sub    %ebx,%r10d
        for(int ny = miny; ny < maxy; ++ny)
    3381:	45 0f bf d2          	movswl %r10w,%r10d
    3385:	41 39 f2             	cmp    %esi,%r10d
    3388:	7e a0                	jle    332a <_ZN14BaseTileCanvas11writePixelsEsssst+0x5a>
            for(int nx = minx; nx < maxx; ++nx)
    338a:	98                   	cwtl   
    338b:	0f bf c9             	movswl %cx,%ecx
    338e:	39 c8                	cmp    %ecx,%eax
    3390:	7d 98                	jge    332a <_ZN14BaseTileCanvas11writePixelsEsssst+0x5a>
    3392:	89 cb                	mov    %ecx,%ebx
    3394:	41 89 c0             	mov    %eax,%r8d
    3397:	4d 01 db             	add    %r11,%r11
    339a:	44 89 4c 24 f4       	mov    %r9d,-0xc(%rsp)
    339f:	29 c3                	sub    %eax,%ebx
    33a1:	41 f7 d0             	not    %r8d
    33a4:	41 89 df             	mov    %ebx,%r15d
    33a7:	45 8d 34 08          	lea    (%r8,%rcx,1),%r14d
    33ab:	89 5c 24 c4          	mov    %ebx,-0x3c(%rsp)
    33af:	c1 eb 03             	shr    $0x3,%ebx
    33b2:	41 83 e7 f8          	and    $0xfffffff8,%r15d
    33b6:	48 c1 e3 04          	shl    $0x4,%rbx
    33ba:	41 83 fe 06          	cmp    $0x6,%r14d
    33be:	44 89 74 24 c0       	mov    %r14d,-0x40(%rsp)
    33c3:	46 8d 04 38          	lea    (%rax,%r15,1),%r8d
    33c7:	44 89 7c 24 c8       	mov    %r15d,-0x38(%rsp)
    33cc:	66 0f 6e 44 24 f4    	movd   -0xc(%rsp),%xmm0
    33d2:	41 0f 47 c0          	cmova  %r8d,%eax
    33d6:	66 0f 61 c0          	punpcklwd %xmm0,%xmm0
    33da:	66 0f 70 c0 00       	pshufd $0x0,%xmm0,%xmm0
    33df:	44 8d 78 01          	lea    0x1(%rax),%r15d
    33e3:	44 8d 70 03          	lea    0x3(%rax),%r14d
                pixBuffer[nx] = c;
    33e7:	48 63 e8             	movslq %eax,%rbp
    33ea:	4d 63 e7             	movslq %r15d,%r12
            for(int nx = minx; nx < maxx; ++nx)
    33ed:	44 89 7c 24 cc       	mov    %r15d,-0x34(%rsp)
    33f2:	44 8d 78 02          	lea    0x2(%rax),%r15d
    33f6:	44 8d 40 05          	lea    0x5(%rax),%r8d
                pixBuffer[nx] = c;
    33fa:	4d 63 ef             	movslq %r15d,%r13
            for(int nx = minx; nx < maxx; ++nx)
    33fd:	44 89 7c 24 d0       	mov    %r15d,-0x30(%rsp)
    3402:	44 8d 78 04          	lea    0x4(%rax),%r15d
    3406:	83 c0 06             	add    $0x6,%eax
    3409:	44 89 44 24 dc       	mov    %r8d,-0x24(%rsp)
                pixBuffer[nx] = c;
    340e:	4d 63 c0             	movslq %r8d,%r8
    3411:	48 01 ed             	add    %rbp,%rbp
    3414:	4d 01 e4             	add    %r12,%r12
            for(int nx = minx; nx < maxx; ++nx)
    3417:	89 44 24 f0          	mov    %eax,-0x10(%rsp)
                pixBuffer[nx] = c;
    341b:	48 98                	cltq   
    341d:	4d 01 c0             	add    %r8,%r8
    3420:	4d 01 ed             	add    %r13,%r13
    3423:	48 01 c0             	add    %rax,%rax
    3426:	4c 89 44 24 e0       	mov    %r8,-0x20(%rsp)
    342b:	48 89 44 24 e8       	mov    %rax,-0x18(%rsp)
            for(int nx = minx; nx < maxx; ++nx)
    3430:	44 89 74 24 d4       	mov    %r14d,-0x2c(%rsp)
                pixBuffer[nx] = c;
    3435:	4d 63 f6             	movslq %r14d,%r14
            for(int nx = minx; nx < maxx; ++nx)
    3438:	44 89 7c 24 d8       	mov    %r15d,-0x28(%rsp)
                pixBuffer[nx] = c;
    343d:	4d 63 ff             	movslq %r15d,%r15
    3440:	4d 01 f6             	add    %r14,%r14
    3443:	4d 01 ff             	add    %r15,%r15
    3446:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
    344d:	00 00 00 
            for(int nx = minx; nx < maxx; ++nx)
    3450:	83 7c 24 c0 06       	cmpl   $0x6,-0x40(%rsp)
    3455:	76 21                	jbe    3478 <_ZN14BaseTileCanvas11writePixelsEsssst+0x1a8>
    3457:	4a 8d 04 1a          	lea    (%rdx,%r11,1),%rax
    345b:	4c 8d 04 18          	lea    (%rax,%rbx,1),%r8
    345f:	90                   	nop
                pixBuffer[nx] = c;
    3460:	0f 11 00             	movups %xmm0,(%rax)
    3463:	48 83 c0 10          	add    $0x10,%rax
    3467:	4c 39 c0             	cmp    %r8,%rax
    346a:	75 f4                	jne    3460 <_ZN14BaseTileCanvas11writePixelsEsssst+0x190>
    346c:	44 8b 44 24 c8       	mov    -0x38(%rsp),%r8d
    3471:	44 39 44 24 c4       	cmp    %r8d,-0x3c(%rsp)
    3476:	74 51                	je     34c9 <_ZN14BaseTileCanvas11writePixelsEsssst+0x1f9>
    3478:	66 44 89 0c 2a       	mov    %r9w,(%rdx,%rbp,1)
            for(int nx = minx; nx < maxx; ++nx)
    347d:	3b 4c 24 cc          	cmp    -0x34(%rsp),%ecx
    3481:	7e 46                	jle    34c9 <_ZN14BaseTileCanvas11writePixelsEsssst+0x1f9>
                pixBuffer[nx] = c;
    3483:	66 46 89 0c 22       	mov    %r9w,(%rdx,%r12,1)
            for(int nx = minx; nx < maxx; ++nx)
    3488:	3b 4c 24 d0          	cmp    -0x30(%rsp),%ecx
    348c:	7e 3b                	jle    34c9 <_ZN14BaseTileCanvas11writePixelsEsssst+0x1f9>
                pixBuffer[nx] = c;
    348e:	66 46 89 0c 2a       	mov    %r9w,(%rdx,%r13,1)
            for(int nx = minx; nx < maxx; ++nx)
    3493:	3b 4c 24 d4          	cmp    -0x2c(%rsp),%ecx
    3497:	7e 30                	jle    34c9 <_ZN14BaseTileCanvas11writePixelsEsssst+0x1f9>
                pixBuffer[nx] = c;
    3499:	66 46 89 0c 32       	mov    %r9w,(%rdx,%r14,1)
            for(int nx = minx; nx < maxx; ++nx)
    349e:	3b 4c 24 d8          	cmp    -0x28(%rsp),%ecx
    34a2:	7e 25                	jle    34c9 <_ZN14BaseTileCanvas11writePixelsEsssst+0x1f9>
                pixBuffer[nx] = c;
    34a4:	66 46 89 0c 3a       	mov    %r9w,(%rdx,%r15,1)
            for(int nx = minx; nx < maxx; ++nx)
    34a9:	3b 4c 24 dc          	cmp    -0x24(%rsp),%ecx
    34ad:	7e 1a                	jle    34c9 <_ZN14BaseTileCanvas11writePixelsEsssst+0x1f9>
                pixBuffer[nx] = c;
    34af:	48 8b 44 24 e0       	mov    -0x20(%rsp),%rax
    34b4:	66 44 89 0c 02       	mov    %r9w,(%rdx,%rax,1)
            for(int nx = minx; nx < maxx; ++nx)
    34b9:	3b 4c 24 f0          	cmp    -0x10(%rsp),%ecx
    34bd:	7e 0a                	jle    34c9 <_ZN14BaseTileCanvas11writePixelsEsssst+0x1f9>
                pixBuffer[nx] = c;
    34bf:	48 8b 44 24 e8       	mov    -0x18(%rsp),%rax
    34c4:	66 44 89 0c 02       	mov    %r9w,(%rdx,%rax,1)
            pixBuffer += tileW_;
    34c9:	48 0f bf 87 b0 00 00 	movswq 0xb0(%rdi),%rax
    34d0:	00 
        for(int ny = miny; ny < maxy; ++ny)
    34d1:	83 c6 01             	add    $0x1,%esi
            pixBuffer += tileW_;
    34d4:	48 01 c0             	add    %rax,%rax
    34d7:	48 01 c2             	add    %rax,%rdx
        for(int ny = miny; ny < maxy; ++ny)
    34da:	41 39 f2             	cmp    %esi,%r10d
    34dd:	0f 85 6d ff ff ff    	jne    3450 <_ZN14BaseTileCanvas11writePixelsEsssst+0x180>
}
    34e3:	5b                   	pop    %rbx
    34e4:	5d                   	pop    %rbp
    34e5:	41 5c                	pop    %r12
    34e7:	41 5d                	pop    %r13
    34e9:	41 5e                	pop    %r14
    34eb:	41 5f                	pop    %r15
    34ed:	c3                   	retq   

00000000000034ee <_ZN14BaseTileCanvasC1EssssPtP4Tile>:
BaseTileCanvas::BaseTileCanvas(int16_t tileW, int16_t tileH, int16_t tilesX, int16_t tilesY, uint16_t* pixBuffer, Tile* tileBuffer)
    34ee:	41 57                	push   %r15
    34f0:	89 f0                	mov    %esi,%eax
    , currTile_(nullptr)
    34f2:	45 0f bf f8          	movswl %r8w,%r15d
BaseTileCanvas::BaseTileCanvas(int16_t tileW, int16_t tileH, int16_t tilesX, int16_t tilesY, uint16_t* pixBuffer, Tile* tileBuffer)
    34f6:	41 56                	push   %r14
    34f8:	41 89 d6             	mov    %edx,%r14d
    , currTile_(nullptr)
    34fb:	0f bf d2             	movswl %dx,%edx
BaseTileCanvas::BaseTileCanvas(int16_t tileW, int16_t tileH, int16_t tilesX, int16_t tilesY, uint16_t* pixBuffer, Tile* tileBuffer)
    34fe:	41 55                	push   %r13
    , currTile_(nullptr)
    3500:	41 0f af d7          	imul   %r15d,%edx
BaseTileCanvas::BaseTileCanvas(int16_t tileW, int16_t tileH, int16_t tilesX, int16_t tilesY, uint16_t* pixBuffer, Tile* tileBuffer)
    3504:	41 54                	push   %r12
    , currTile_(nullptr)
    3506:	44 0f bf e1          	movswl %cx,%r12d
BaseTileCanvas::BaseTileCanvas(int16_t tileW, int16_t tileH, int16_t tilesX, int16_t tilesY, uint16_t* pixBuffer, Tile* tileBuffer)
    350a:	55                   	push   %rbp
    350b:	48 89 fd             	mov    %rdi,%rbp
    350e:	53                   	push   %rbx
    350f:	89 cb                	mov    %ecx,%ebx
    3511:	48 83 ec 28          	sub    $0x28,%rsp
    3515:	66 89 74 24 0e       	mov    %si,0xe(%rsp)
    , currTile_(nullptr)
    351a:	0f bf f6             	movswl %si,%esi
BaseTileCanvas::BaseTileCanvas(int16_t tileW, int16_t tileH, int16_t tilesX, int16_t tilesY, uint16_t* pixBuffer, Tile* tileBuffer)
    351d:	4c 8b 6c 24 60       	mov    0x60(%rsp),%r13
    , currTile_(nullptr)
    3522:	41 0f af f4          	imul   %r12d,%esi
BaseTileCanvas::BaseTileCanvas(int16_t tileW, int16_t tileH, int16_t tilesX, int16_t tilesY, uint16_t* pixBuffer, Tile* tileBuffer)
    3526:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
    , currTile_(nullptr)
    352b:	44 89 44 24 14       	mov    %r8d,0x14(%rsp)
    3530:	89 44 24 10          	mov    %eax,0x10(%rsp)
    3534:	e8 a9 03 00 00       	callq  38e2 <_ZN6CanvasC1Eii>
    3539:	48 8d 05 e8 37 00 00 	lea    0x37e8(%rip),%rax        # 6d28 <_ZTV14BaseTileCanvas+0x10>
    3540:	66 85 db             	test   %bx,%bx
    3543:	b9 00 00 00 00       	mov    $0x0,%ecx
    3548:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
    354d:	44 8b 44 24 14       	mov    0x14(%rsp),%r8d
    3552:	48 89 45 00          	mov    %rax,0x0(%rbp)
    3556:	8b 44 24 10          	mov    0x10(%rsp),%eax
    355a:	66 89 9d b4 00 00 00 	mov    %bx,0xb4(%rbp)
    3561:	0f 48 d9             	cmovs  %ecx,%ebx
    3564:	31 d2                	xor    %edx,%edx
    3566:	4c 89 8d a0 00 00 00 	mov    %r9,0xa0(%rbp)
    for(int y = 0; y < tilesY_; ++y)
    356d:	31 c9                	xor    %ecx,%ecx
    , currTile_(nullptr)
    356f:	4c 89 ad a8 00 00 00 	mov    %r13,0xa8(%rbp)
    3576:	48 0f bf db          	movswq %bx,%rbx
    357a:	66 89 85 b0 00 00 00 	mov    %ax,0xb0(%rbp)
    3581:	48 c1 e3 03          	shl    $0x3,%rbx
    3585:	66 44 89 b5 b2 00 00 	mov    %r14w,0xb2(%rbp)
    358c:	00 
    358d:	66 44 89 85 b6 00 00 	mov    %r8w,0xb6(%rbp)
    3594:	00 
    3595:	48 c7 85 b8 00 00 00 	movq   $0x0,0xb8(%rbp)
    359c:	00 00 00 00 
    for(int y = 0; y < tilesY_; ++y)
    35a0:	41 39 cf             	cmp    %ecx,%r15d
    35a3:	7e 32                	jle    35d7 <_ZN14BaseTileCanvasC1EssssPtP4Tile+0xe9>
            tile->y_ = y * tileH_;
    35a5:	31 f6                	xor    %esi,%esi
    35a7:	31 c0                	xor    %eax,%eax
        for(int x = 0; x < tilesX_; ++x)
    35a9:	41 39 c4             	cmp    %eax,%r12d
    35ac:	7e 1f                	jle    35cd <_ZN14BaseTileCanvasC1EssssPtP4Tile+0xdf>
            tile->x_ = x * tileW_;
    35ae:	66 41 89 74 c5 00    	mov    %si,0x0(%r13,%rax,8)
            tile->y_ = y * tileH_;
    35b4:	66 03 74 24 0e       	add    0xe(%rsp),%si
    35b9:	66 41 89 54 c5 02    	mov    %dx,0x2(%r13,%rax,8)
            tile->hash_ = 0;
    35bf:	41 c7 44 c5 04 00 00 	movl   $0x0,0x4(%r13,%rax,8)
    35c6:	00 00 
            ++tile;
    35c8:	48 ff c0             	inc    %rax
        for(int x = 0; x < tilesX_; ++x)
    35cb:	eb dc                	jmp    35a9 <_ZN14BaseTileCanvasC1EssssPtP4Tile+0xbb>
    35cd:	49 01 dd             	add    %rbx,%r13
    for(int y = 0; y < tilesY_; ++y)
    35d0:	ff c1                	inc    %ecx
    35d2:	44 01 f2             	add    %r14d,%edx
    35d5:	eb c9                	jmp    35a0 <_ZN14BaseTileCanvasC1EssssPtP4Tile+0xb2>
}
    35d7:	48 83 c4 28          	add    $0x28,%rsp
    35db:	5b                   	pop    %rbx
    35dc:	5d                   	pop    %rbp
    35dd:	41 5c                	pop    %r12
    35df:	41 5d                	pop    %r13
    35e1:	41 5e                	pop    %r14
    35e3:	41 5f                	pop    %r15
    35e5:	c3                   	retq   

00000000000035e6 <_ZN14BaseTileCanvasD1Ev>:
}
    35e6:	c3                   	retq   
    35e7:	90                   	nop
    35e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    35ef:	00 

00000000000035f0 <_ZN14BaseTileCanvas4initEv>:
}
    35f0:	c3                   	retq   
    35f1:	90                   	nop
    35f2:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
    35f9:	00 00 00 00 
    35fd:	0f 1f 00             	nopl   (%rax)

0000000000003600 <_ZN14BaseTileCanvas5flushEv>:
    if(hashTiles_)
    3600:	80 bf c8 00 00 00 00 	cmpb   $0x0,0xc8(%rdi)
    3607:	4c 8b 8f a0 00 00 00 	mov    0xa0(%rdi),%r9
    360e:	44 0f bf 87 b2 00 00 	movswl 0xb2(%rdi),%r8d
    3615:	00 
    3616:	0f bf 8f b0 00 00 00 	movswl 0xb0(%rdi),%ecx
    361d:	48 8b b7 b8 00 00 00 	mov    0xb8(%rdi),%rsi
    3624:	75 1a                	jne    3640 <_ZN14BaseTileCanvas5flushEv+0x40>
        canvas_->writePixels(currTile_->x_, currTile_->y_, tileW_, tileH_, pixBuffer_);
    3626:	48 8b bf c0 00 00 00 	mov    0xc0(%rdi),%rdi
    362d:	0f bf 56 02          	movswl 0x2(%rsi),%edx
    3631:	0f bf 36             	movswl (%rsi),%esi
    3634:	48 8b 07             	mov    (%rdi),%rax
    3637:	ff 60 08             	jmpq   *0x8(%rax)
    363a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
{
    3640:	55                   	push   %rbp

#if defined(PLATFORM_PC)
inline void ProfilingTimestamp(const char* name, int8_t id = 0)
{
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    timestamp.name = name;
    3641:	4c 8d 15 78 59 00 00 	lea    0x5978(%rip),%r10        # 8fc0 <ProfilingTimestamps>
    3648:	48 8d 15 01 16 00 00 	lea    0x1601(%rip),%rdx        # 4c50 <_ZL10icons_data+0x210>
    364f:	53                   	push   %rbx
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    3650:	0f b6 1d 69 5d 00 00 	movzbl 0x5d69(%rip),%ebx        # 93c0 <ProfilingTimestampCount>
    timestamp.name = name;
    3657:	48 89 d8             	mov    %rbx,%rax
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    365a:	44 8d 5b 01          	lea    0x1(%rbx),%r11d
    timestamp.name = name;
    365e:	83 e0 3f             	and    $0x3f,%eax
    3661:	48 c1 e0 04          	shl    $0x4,%rax
    3665:	4c 01 d0             	add    %r10,%rax
    3668:	48 89 10             	mov    %rdx,(%rax)
    timestamp.id = id;
    366b:	c6 40 08 00          	movb   $0x0,0x8(%rax)
    timestamp.time = 0;
    366f:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%rax)
        uint32_t hash = calcHash(0, pixBuffer_, tileW_ * tileH_ * 2);
    3676:	44 89 c0             	mov    %r8d,%eax
    3679:	0f af c1             	imul   %ecx,%eax
    367c:	01 c0                	add    %eax,%eax
    367e:	48 98                	cltq   
    uint32_t hash = HAL_CRC_Calculate(&hcrc_, (uint32_t*)inData, size >> 2);
#else
    const uint32_t* data = reinterpret_cast<const uint32_t*>(inData);
    uint32_t hash = input;
    size >>= 2;
    while(size--)
    3680:	48 c1 e8 02          	shr    $0x2,%rax
    3684:	74 72                	je     36f8 <_ZN14BaseTileCanvas5flushEv+0xf8>
    3686:	49 8d 2c 81          	lea    (%r9,%rax,4),%rbp
    const uint32_t* data = reinterpret_cast<const uint32_t*>(inData);
    368a:	4c 89 ca             	mov    %r9,%rdx
    uint32_t hash = input;
    368d:	31 c0                	xor    %eax,%eax
    368f:	90                   	nop
        hash = *data++ + (hash << 6) + (hash << 16) - hash;
    3690:	48 83 c2 04          	add    $0x4,%rdx
    3694:	69 c0 3f 00 01 00    	imul   $0x1003f,%eax,%eax
    369a:	03 42 fc             	add    -0x4(%rdx),%eax
    while(size--)
    369d:	48 39 ea             	cmp    %rbp,%rdx
    36a0:	75 ee                	jne    3690 <_ZN14BaseTileCanvas5flushEv+0x90>
    timestamp.name = name;
    36a2:	41 83 e3 3f          	and    $0x3f,%r11d
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    36a6:	83 c3 02             	add    $0x2,%ebx
    timestamp.name = name;
    36a9:	49 c1 e3 04          	shl    $0x4,%r11
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    36ad:	88 1d 0d 5d 00 00    	mov    %bl,0x5d0d(%rip)        # 93c0 <ProfilingTimestampCount>
    timestamp.name = name;
    36b3:	48 8d 1d b6 15 00 00 	lea    0x15b6(%rip),%rbx        # 4c70 <_ZL10icons_data+0x230>
    36ba:	4d 01 da             	add    %r11,%r10
    36bd:	49 89 1a             	mov    %rbx,(%r10)
    timestamp.id = id;
    36c0:	41 c6 42 08 00       	movb   $0x0,0x8(%r10)
    timestamp.time = 0;
    36c5:	41 c7 42 0c 00 00 00 	movl   $0x0,0xc(%r10)
    36cc:	00 
        if(hash != currTile_->hash_)
    36cd:	39 46 04             	cmp    %eax,0x4(%rsi)
    36d0:	74 1e                	je     36f0 <_ZN14BaseTileCanvas5flushEv+0xf0>
            canvas_->writePixels(currTile_->x_, currTile_->y_, tileW_, tileH_, pixBuffer_);
    36d2:	48 8b bf c0 00 00 00 	mov    0xc0(%rdi),%rdi
    36d9:	0f bf 56 02          	movswl 0x2(%rsi),%edx
            currTile_->hash_ = hash;
    36dd:	89 46 04             	mov    %eax,0x4(%rsi)
            canvas_->writePixels(currTile_->x_, currTile_->y_, tileW_, tileH_, pixBuffer_);
    36e0:	0f bf 36             	movswl (%rsi),%esi
}
    36e3:	5b                   	pop    %rbx
            canvas_->writePixels(currTile_->x_, currTile_->y_, tileW_, tileH_, pixBuffer_);
    36e4:	48 8b 07             	mov    (%rdi),%rax
}
    36e7:	5d                   	pop    %rbp
            canvas_->writePixels(currTile_->x_, currTile_->y_, tileW_, tileH_, pixBuffer_);
    36e8:	48 8b 40 08          	mov    0x8(%rax),%rax
    36ec:	ff e0                	jmpq   *%rax
    36ee:	66 90                	xchg   %ax,%ax
}
    36f0:	5b                   	pop    %rbx
    36f1:	5d                   	pop    %rbp
    36f2:	c3                   	retq   
    36f3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    uint32_t hash = input;
    36f8:	31 c0                	xor    %eax,%eax
    36fa:	eb a6                	jmp    36a2 <_ZN14BaseTileCanvas5flushEv+0xa2>
    36fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000003700 <_ZN14BaseTileCanvas8calcHashEjPKvm>:
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    3700:	44 0f b6 0d b8 5c 00 	movzbl 0x5cb8(%rip),%r9d        # 93c0 <ProfilingTimestampCount>
    3707:	00 
    timestamp.name = name;
    3708:	48 8d 3d b1 58 00 00 	lea    0x58b1(%rip),%rdi        # 8fc0 <ProfilingTimestamps>
    370f:	4c 8d 15 3a 15 00 00 	lea    0x153a(%rip),%r10        # 4c50 <_ZL10icons_data+0x210>
    3716:	4c 89 c8             	mov    %r9,%rax
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    3719:	45 8d 41 01          	lea    0x1(%r9),%r8d
    timestamp.name = name;
    371d:	83 e0 3f             	and    $0x3f,%eax
    3720:	48 c1 e0 04          	shl    $0x4,%rax
    3724:	48 01 f8             	add    %rdi,%rax
    while(size--)
    3727:	48 c1 e9 02          	shr    $0x2,%rcx
    372b:	4c 89 10             	mov    %r10,(%rax)
    timestamp.id = id;
    372e:	c6 40 08 00          	movb   $0x0,0x8(%rax)
    timestamp.time = 0;
    3732:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%rax)
    3739:	74 55                	je     3790 <_ZN14BaseTileCanvas8calcHashEjPKvm+0x90>
    373b:	48 8d 0c 8a          	lea    (%rdx,%rcx,4),%rcx
    uint32_t hash = input;
    373f:	89 f0                	mov    %esi,%eax
    3741:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
        hash = *data++ + (hash << 6) + (hash << 16) - hash;
    3748:	48 83 c2 04          	add    $0x4,%rdx
    374c:	69 c0 3f 00 01 00    	imul   $0x1003f,%eax,%eax
    3752:	03 42 fc             	add    -0x4(%rdx),%eax
    while(size--)
    3755:	48 39 ca             	cmp    %rcx,%rdx
    3758:	75 ee                	jne    3748 <_ZN14BaseTileCanvas8calcHashEjPKvm+0x48>
    timestamp.name = name;
    375a:	41 83 e0 3f          	and    $0x3f,%r8d
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    375e:	41 83 c1 02          	add    $0x2,%r9d
    timestamp.name = name;
    3762:	48 8d 35 07 15 00 00 	lea    0x1507(%rip),%rsi        # 4c70 <_ZL10icons_data+0x230>
    3769:	49 c1 e0 04          	shl    $0x4,%r8
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    376d:	44 88 0d 4c 5c 00 00 	mov    %r9b,0x5c4c(%rip)        # 93c0 <ProfilingTimestampCount>
    timestamp.name = name;
    3774:	4a 8d 14 07          	lea    (%rdi,%r8,1),%rdx
    3778:	48 89 32             	mov    %rsi,(%rdx)
    timestamp.id = id;
    377b:	c6 42 08 00          	movb   $0x0,0x8(%rdx)
    timestamp.time = 0;
    377f:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%rdx)
#endif

    ProfilingTimestamp("BaseTileCanvas::calcHash END");
    return hash;
}
    3786:	c3                   	retq   
    3787:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    378e:	00 00 
    uint32_t hash = input;
    3790:	89 f0                	mov    %esi,%eax
    3792:	eb c6                	jmp    375a <_ZN14BaseTileCanvas8calcHashEjPKvm+0x5a>

0000000000003794 <_ZZN6Canvas8drawLineEssssENKUlssssE_clEssss>:
    writePixels(x, y, 1, h, fg_);
}

void Canvas::drawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1)
{
    auto drawLineX = [this](int16_t x0, int16_t x1, int16_t y0, int16_t y1)
    3794:	41 57                	push   %r15
    3796:	49 89 fa             	mov    %rdi,%r10
    {
        int16_t dx = x1 - x0;
    3799:	89 d7                	mov    %edx,%edi
    auto drawLineX = [this](int16_t x0, int16_t x1, int16_t y0, int16_t y1)
    379b:	41 56                	push   %r14
        int16_t dx = x1 - x0;
    379d:	29 f7                	sub    %esi,%edi
    auto drawLineX = [this](int16_t x0, int16_t x1, int16_t y0, int16_t y1)
    379f:	41 89 ce             	mov    %ecx,%r14d
    37a2:	41 55                	push   %r13
    37a4:	41 89 f5             	mov    %esi,%r13d
    37a7:	41 54                	push   %r12
        int16_t dy = y1 - y0;
        int16_t yi = dy < 0 ? -1 : 1;
    37a9:	45 89 c4             	mov    %r8d,%r12d
    auto drawLineX = [this](int16_t x0, int16_t x1, int16_t y0, int16_t y1)
    37ac:	55                   	push   %rbp
    37ad:	53                   	push   %rbx
    37ae:	48 83 ec 18          	sub    $0x18,%rsp
    37b2:	66 89 54 24 06       	mov    %dx,0x6(%rsp)
        int16_t yi = dy < 0 ? -1 : 1;
    37b7:	66 41 29 cc          	sub    %cx,%r12w
    37bb:	78 62                	js     381f <_ZZN6Canvas8drawLineEssssENKUlssssE_clEssss+0x8b>
    37bd:	41 bf 01 00 00 00    	mov    $0x1,%r15d
        {
            writePixels(x, y, 1, 1, fg_);
            if(d > 0)
            {
                y += yi;
                d -= 2 * dx;
    37c3:	8d 04 3f             	lea    (%rdi,%rdi,1),%eax
        int16_t d = 2 * dy - dx;
    37c6:	89 f5                	mov    %esi,%ebp
    37c8:	45 01 e4             	add    %r12d,%r12d
    37cb:	0f bf de             	movswl %si,%ebx
                d -= 2 * dx;
    37ce:	66 89 44 24 04       	mov    %ax,0x4(%rsp)
        int16_t d = 2 * dy - dx;
    37d3:	29 d5                	sub    %edx,%ebp
    37d5:	44 01 e5             	add    %r12d,%ebp
        for(int16_t x = x0; x < x1; ++x)
    37d8:	66 44 3b 6c 24 06    	cmp    0x6(%rsp),%r13w
    37de:	7d 4b                	jge    382b <_ZZN6Canvas8drawLineEssssENKUlssssE_clEssss+0x97>
    auto drawLineX = [this](int16_t x0, int16_t x1, int16_t y0, int16_t y1)
    37e0:	49 8b 3a             	mov    (%r10),%rdi
    37e3:	4c 89 54 24 08       	mov    %r10,0x8(%rsp)
            writePixels(x, y, 1, 1, fg_);
    37e8:	41 0f bf d6          	movswl %r14w,%edx
    37ec:	89 de                	mov    %ebx,%esi
    37ee:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    37f4:	b9 01 00 00 00       	mov    $0x1,%ecx
    37f9:	4c 8b 1f             	mov    (%rdi),%r11
    37fc:	44 0f b7 4f 10       	movzwl 0x10(%rdi),%r9d
    3801:	41 ff 13             	callq  *(%r11)
            if(d > 0)
    3804:	66 85 ed             	test   %bp,%bp
    3807:	4c 8b 54 24 08       	mov    0x8(%rsp),%r10
    380c:	7e 07                	jle    3815 <_ZZN6Canvas8drawLineEssssENKUlssssE_clEssss+0x81>
                y += yi;
    380e:	45 01 fe             	add    %r15d,%r14d
                d -= 2 * dx;
    3811:	2b 6c 24 04          	sub    0x4(%rsp),%ebp
            }
            d += 2 * dy;
    3815:	44 01 e5             	add    %r12d,%ebp
    3818:	41 ff c5             	inc    %r13d
    381b:	ff c3                	inc    %ebx
        for(int16_t x = x0; x < x1; ++x)
    381d:	eb b9                	jmp    37d8 <_ZZN6Canvas8drawLineEssssENKUlssssE_clEssss+0x44>
            dy = -dy;
    381f:	41 89 cc             	mov    %ecx,%r12d
            yi = -1;
    3822:	41 83 cf ff          	or     $0xffffffff,%r15d
            dy = -dy;
    3826:	45 29 c4             	sub    %r8d,%r12d
    3829:	eb 98                	jmp    37c3 <_ZZN6Canvas8drawLineEssssENKUlssssE_clEssss+0x2f>
        }
    };
    382b:	48 83 c4 18          	add    $0x18,%rsp
    382f:	5b                   	pop    %rbx
    3830:	5d                   	pop    %rbp
    3831:	41 5c                	pop    %r12
    3833:	41 5d                	pop    %r13
    3835:	41 5e                	pop    %r14
    3837:	41 5f                	pop    %r15
    3839:	c3                   	retq   

000000000000383a <_ZZN6Canvas8drawLineEssssENKUlssssE0_clEssss>:

    auto drawLineY = [this](int16_t x0, int16_t x1, int16_t y0, int16_t y1)
    383a:	41 57                	push   %r15
    383c:	49 89 fa             	mov    %rdi,%r10
    {
        int16_t dx = x1 - x0;
        int16_t dy = y1 - y0;
    383f:	44 89 c7             	mov    %r8d,%edi
    3842:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    auto drawLineY = [this](int16_t x0, int16_t x1, int16_t y0, int16_t y1)
    3848:	41 56                	push   %r14
        int16_t dy = y1 - y0;
    384a:	29 cf                	sub    %ecx,%edi
    auto drawLineY = [this](int16_t x0, int16_t x1, int16_t y0, int16_t y1)
    384c:	41 89 f6             	mov    %esi,%r14d
    384f:	41 55                	push   %r13
    3851:	41 89 cd             	mov    %ecx,%r13d
    3854:	41 54                	push   %r12
        int16_t xi = 1;
        if(dx < 0)
    3856:	41 89 d4             	mov    %edx,%r12d
    auto drawLineY = [this](int16_t x0, int16_t x1, int16_t y0, int16_t y1)
    3859:	55                   	push   %rbp
    385a:	53                   	push   %rbx
    385b:	48 83 ec 18          	sub    $0x18,%rsp
        if(dx < 0)
    385f:	66 41 29 f4          	sub    %si,%r12w
    auto drawLineY = [this](int16_t x0, int16_t x1, int16_t y0, int16_t y1)
    3863:	66 44 89 44 24 06    	mov    %r8w,0x6(%rsp)
        if(dx < 0)
    3869:	79 0a                	jns    3875 <_ZZN6Canvas8drawLineEssssENKUlssssE0_clEssss+0x3b>
        {
            xi = -1;
            dx = -dx;
    386b:	41 89 f4             	mov    %esi,%r12d
            xi = -1;
    386e:	41 83 cf ff          	or     $0xffffffff,%r15d
            dx = -dx;
    3872:	41 29 d4             	sub    %edx,%r12d
        {
            writePixels(x, y, 1, 1, fg_);
            if(d > 0)
            {
                x += xi;
                d -= 2 * dy;
    3875:	8d 04 3f             	lea    (%rdi,%rdi,1),%eax
        int16_t d = 2 * dx - dy;
    3878:	89 cd                	mov    %ecx,%ebp
    387a:	45 01 e4             	add    %r12d,%r12d
    387d:	0f bf d9             	movswl %cx,%ebx
                d -= 2 * dy;
    3880:	66 89 44 24 04       	mov    %ax,0x4(%rsp)
        int16_t d = 2 * dx - dy;
    3885:	44 29 c5             	sub    %r8d,%ebp
    3888:	44 01 e5             	add    %r12d,%ebp
        for(int16_t y = y0; y < y1; ++y)
    388b:	66 44 3b 6c 24 06    	cmp    0x6(%rsp),%r13w
    3891:	7d 3f                	jge    38d2 <_ZZN6Canvas8drawLineEssssENKUlssssE0_clEssss+0x98>
    auto drawLineY = [this](int16_t x0, int16_t x1, int16_t y0, int16_t y1)
    3893:	49 8b 3a             	mov    (%r10),%rdi
    3896:	4c 89 54 24 08       	mov    %r10,0x8(%rsp)
            writePixels(x, y, 1, 1, fg_);
    389b:	41 0f bf f6          	movswl %r14w,%esi
    389f:	89 da                	mov    %ebx,%edx
    38a1:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    38a7:	b9 01 00 00 00       	mov    $0x1,%ecx
    38ac:	4c 8b 1f             	mov    (%rdi),%r11
    38af:	44 0f b7 4f 10       	movzwl 0x10(%rdi),%r9d
    38b4:	41 ff 13             	callq  *(%r11)
            if(d > 0)
    38b7:	66 85 ed             	test   %bp,%bp
    38ba:	4c 8b 54 24 08       	mov    0x8(%rsp),%r10
    38bf:	7e 07                	jle    38c8 <_ZZN6Canvas8drawLineEssssENKUlssssE0_clEssss+0x8e>
                x += xi;
    38c1:	45 01 fe             	add    %r15d,%r14d
                d -= 2 * dy;
    38c4:	2b 6c 24 04          	sub    0x4(%rsp),%ebp
            }
            d += 2 * dx;
    38c8:	44 01 e5             	add    %r12d,%ebp
    38cb:	41 ff c5             	inc    %r13d
    38ce:	ff c3                	inc    %ebx
        for(int16_t y = y0; y < y1; ++y)
    38d0:	eb b9                	jmp    388b <_ZZN6Canvas8drawLineEssssENKUlssssE0_clEssss+0x51>
        }
    };
    38d2:	48 83 c4 18          	add    $0x18,%rsp
    38d6:	5b                   	pop    %rbx
    38d7:	5d                   	pop    %rbp
    38d8:	41 5c                	pop    %r12
    38da:	41 5d                	pop    %r13
    38dc:	41 5e                	pop    %r14
    38de:	41 5f                	pop    %r15
    38e0:	c3                   	retq   
    38e1:	90                   	nop

00000000000038e2 <_ZN6CanvasC1Eii>:
    , h_(h)
    38e2:	48 8d 05 7f 34 00 00 	lea    0x347f(%rip),%rax        # 6d68 <__cxa_pure_virtual@CXXABI_1.3>
    38e9:	89 b7 94 00 00 00    	mov    %esi,0x94(%rdi)
    38ef:	48 89 07             	mov    %rax,(%rdi)
    38f2:	89 97 98 00 00 00    	mov    %edx,0x98(%rdi)
}
    38f8:	c3                   	retq   
    38f9:	90                   	nop

00000000000038fa <_ZN6Canvas9drawHLineEsss>:
    writePixels(x, y, w, 1, fg_);
    38fa:	48 8b 07             	mov    (%rdi),%rax
    38fd:	0f bf c9             	movswl %cx,%ecx
    3900:	0f bf d2             	movswl %dx,%edx
    3903:	0f bf f6             	movswl %si,%esi
    3906:	44 0f b7 4f 10       	movzwl 0x10(%rdi),%r9d
    390b:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    3911:	48 8b 00             	mov    (%rax),%rax
    3914:	ff e0                	jmpq   *%rax

0000000000003916 <_ZN6Canvas9drawVLineEsss>:
    writePixels(x, y, 1, h, fg_);
    3916:	48 8b 07             	mov    (%rdi),%rax
    3919:	44 0f bf c1          	movswl %cx,%r8d
    391d:	0f bf d2             	movswl %dx,%edx
    3920:	0f bf f6             	movswl %si,%esi
    3923:	44 0f b7 4f 10       	movzwl 0x10(%rdi),%r9d
    3928:	b9 01 00 00 00       	mov    $0x1,%ecx
    392d:	48 8b 00             	mov    (%rax),%rax
    3930:	ff e0                	jmpq   *%rax

0000000000003932 <_ZN6Canvas8drawLineEssss>:
{
    3932:	55                   	push   %rbp
    3933:	41 89 f3             	mov    %esi,%r11d
    3936:	44 0f bf d2          	movswl %dx,%r10d
    393a:	53                   	push   %rbx
    393b:	89 cb                	mov    %ecx,%ebx
    393d:	45 0f bf cb          	movswl %r11w,%r9d
    3941:	41 0f bf c8          	movswl %r8w,%ecx
    3945:	0f bf f3             	movswl %bx,%esi
    3948:	48 83 ec 28          	sub    $0x28,%rsp
    394c:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
    3953:	00 00 
    3955:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    395a:	31 c0                	xor    %eax,%eax

    const int16_t dx = x1 - x0;
    395c:	89 d8                	mov    %ebx,%eax
    };
    395e:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    const int16_t dx = x1 - x0;
    3963:	44 29 d8             	sub    %r11d,%eax
    };
    3966:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    const int16_t dy = y1 - y0;

    if(inline_abs(dy) < inline_abs(dx))
    396b:	98                   	cwtl   
#include "cmsis_gcc.h"
#endif

inline int16_t inline_abs(int16_t a)
{
    return a < 0 ? -a : a;
    396c:	89 c7                	mov    %eax,%edi
    396e:	c1 ff 1f             	sar    $0x1f,%edi
    3971:	31 f8                	xor    %edi,%eax
    3973:	29 f8                	sub    %edi,%eax
    3975:	89 c7                	mov    %eax,%edi
    const int16_t dy = y1 - y0;
    3977:	44 89 c0             	mov    %r8d,%eax
    397a:	29 d0                	sub    %edx,%eax
    if(inline_abs(dy) < inline_abs(dx))
    397c:	98                   	cwtl   
    397d:	89 c5                	mov    %eax,%ebp
    397f:	c1 fd 1f             	sar    $0x1f,%ebp
    3982:	31 e8                	xor    %ebp,%eax
    3984:	29 e8                	sub    %ebp,%eax
    3986:	66 39 c7             	cmp    %ax,%di
    3989:	7e 25                	jle    39b0 <_ZN6Canvas8drawLineEssss+0x7e>
    {
        if(x0 > x1)
    398b:	66 44 39 db          	cmp    %r11w,%bx
    398f:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    3994:	7d 08                	jge    399e <_ZN6Canvas8drawLineEssss+0x6c>
            drawLineX(x1, x0, y1, y0);
    3996:	45 89 d0             	mov    %r10d,%r8d
    3999:	44 89 ca             	mov    %r9d,%edx
    399c:	eb 0b                	jmp    39a9 <_ZN6Canvas8drawLineEssss+0x77>
        else
            drawLineX(x0, x1, y0, y1);
    399e:	41 89 c8             	mov    %ecx,%r8d
    39a1:	89 f2                	mov    %esi,%edx
    39a3:	44 89 d1             	mov    %r10d,%ecx
    39a6:	44 89 ce             	mov    %r9d,%esi
    39a9:	e8 e6 fd ff ff       	callq  3794 <_ZZN6Canvas8drawLineEssssENKUlssssE_clEssss>
    39ae:	eb 23                	jmp    39d3 <_ZN6Canvas8drawLineEssss+0xa1>
        
    }
    else
    {
        if(y0 > y1)
    39b0:	66 41 39 d0          	cmp    %dx,%r8w
    39b4:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    39b9:	7d 08                	jge    39c3 <_ZN6Canvas8drawLineEssss+0x91>
            drawLineY(x1, x0, y1, y0);
    39bb:	45 89 d0             	mov    %r10d,%r8d
    39be:	44 89 ca             	mov    %r9d,%edx
    39c1:	eb 0b                	jmp    39ce <_ZN6Canvas8drawLineEssss+0x9c>
        else
            drawLineY(x0, x1, y0, y1);
    39c3:	41 89 c8             	mov    %ecx,%r8d
    39c6:	89 f2                	mov    %esi,%edx
    39c8:	44 89 d1             	mov    %r10d,%ecx
    39cb:	44 89 ce             	mov    %r9d,%esi
    39ce:	e8 67 fe ff ff       	callq  383a <_ZZN6Canvas8drawLineEssssENKUlssssE0_clEssss>
    }
}
    39d3:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    39d8:	64 48 33 04 25 28 00 	xor    %fs:0x28,%rax
    39df:	00 00 
    39e1:	74 05                	je     39e8 <_ZN6Canvas8drawLineEssss+0xb6>
    39e3:	e8 88 d6 ff ff       	callq  1070 <__stack_chk_fail@plt>
    39e8:	48 83 c4 28          	add    $0x28,%rsp
    39ec:	5b                   	pop    %rbx
    39ed:	5d                   	pop    %rbp
    39ee:	c3                   	retq   
    39ef:	90                   	nop

00000000000039f0 <_ZN6Canvas7drawBoxEssss>:

void Canvas::drawBox(int16_t x, int16_t y, int16_t w, int16_t h)
{
    39f0:	41 57                	push   %r15
    39f2:	45 89 c7             	mov    %r8d,%r15d
    drawHLine(x, y, w);
    39f5:	44 0f bf c1          	movswl %cx,%r8d
{
    39f9:	41 56                	push   %r14
    drawHLine(x, y, w);
    39fb:	44 0f bf f6          	movswl %si,%r14d
{
    39ff:	41 55                	push   %r13
    drawHLine(x, y, w);
    3a01:	44 0f bf ea          	movswl %dx,%r13d
{
    3a05:	41 54                	push   %r12
    3a07:	49 89 fc             	mov    %rdi,%r12
    3a0a:	55                   	push   %rbp
    3a0b:	89 d5                	mov    %edx,%ebp
    drawHLine(x, y, w);
    3a0d:	44 89 ea             	mov    %r13d,%edx
{
    3a10:	53                   	push   %rbx
    3a11:	89 f3                	mov    %esi,%ebx
    drawHLine(x, y, w);
    3a13:	44 89 f6             	mov    %r14d,%esi
{
    3a16:	48 83 ec 18          	sub    $0x18,%rsp
    drawHLine(x, y, w);
    3a1a:	89 4c 24 0c          	mov    %ecx,0xc(%rsp)
    3a1e:	44 89 c1             	mov    %r8d,%ecx
    3a21:	44 89 44 24 08       	mov    %r8d,0x8(%rsp)
    3a26:	e8 cf fe ff ff       	callq  38fa <_ZN6Canvas9drawHLineEsss>
    drawHLine(x, y + h - 1, w);
    3a2b:	44 8b 44 24 08       	mov    0x8(%rsp),%r8d
    3a30:	44 89 f6             	mov    %r14d,%esi
    3a33:	4c 89 e7             	mov    %r12,%rdi
    3a36:	41 8d 54 2f ff       	lea    -0x1(%r15,%rbp,1),%edx
    drawVLine(x, y, h);
    3a3b:	45 0f bf ff          	movswl %r15w,%r15d
    drawHLine(x, y + h - 1, w);
    3a3f:	44 89 c1             	mov    %r8d,%ecx
    3a42:	0f bf d2             	movswl %dx,%edx
    3a45:	e8 b0 fe ff ff       	callq  38fa <_ZN6Canvas9drawHLineEsss>
    drawVLine(x, y, h);
    3a4a:	44 89 f9             	mov    %r15d,%ecx
    3a4d:	44 89 ea             	mov    %r13d,%edx
    3a50:	44 89 f6             	mov    %r14d,%esi
    3a53:	4c 89 e7             	mov    %r12,%rdi
    3a56:	e8 bb fe ff ff       	callq  3916 <_ZN6Canvas9drawVLineEsss>
    drawVLine(x + w - 1, y, h);
    3a5b:	8b 44 24 0c          	mov    0xc(%rsp),%eax
}
    3a5f:	48 83 c4 18          	add    $0x18,%rsp
    drawVLine(x + w - 1, y, h);
    3a63:	44 89 f9             	mov    %r15d,%ecx
    3a66:	44 89 ea             	mov    %r13d,%edx
    3a69:	4c 89 e7             	mov    %r12,%rdi
    3a6c:	8d 74 03 ff          	lea    -0x1(%rbx,%rax,1),%esi
}
    3a70:	5b                   	pop    %rbx
    3a71:	5d                   	pop    %rbp
    drawVLine(x + w - 1, y, h);
    3a72:	0f bf f6             	movswl %si,%esi
}
    3a75:	41 5c                	pop    %r12
    3a77:	41 5d                	pop    %r13
    3a79:	41 5e                	pop    %r14
    3a7b:	41 5f                	pop    %r15
    drawVLine(x + w - 1, y, h);
    3a7d:	e9 94 fe ff ff       	jmpq   3916 <_ZN6Canvas9drawVLineEsss>

0000000000003a82 <_ZN6Canvas13drawFilledBoxEssss>:

void Canvas::drawFilledBox(int16_t x, int16_t y, int16_t w, int16_t h)
{
    writePixels(x, y, w, h, fg_);
    3a82:	48 8b 07             	mov    (%rdi),%rax
    3a85:	0f bf c9             	movswl %cx,%ecx
    3a88:	0f bf d2             	movswl %dx,%edx
    3a8b:	0f bf f6             	movswl %si,%esi
    3a8e:	44 0f b7 4f 10       	movzwl 0x10(%rdi),%r9d
    3a93:	45 0f bf c0          	movswl %r8w,%r8d
    3a97:	48 8b 00             	mov    (%rax),%rax
    3a9a:	ff e0                	jmpq   *%rax

0000000000003a9c <_ZN6Canvas10drawPixelsEssssPKt>:
    }
}

void Canvas::drawPixels(int16_t x, int16_t y, int16_t w, int16_t h, const uint16_t* pixelData)
{
    writePixels(x, y, w, h, pixelData);
    3a9c:	48 8b 07             	mov    (%rdi),%rax
    3a9f:	0f bf c9             	movswl %cx,%ecx
    3aa2:	0f bf d2             	movswl %dx,%edx
    3aa5:	0f bf f6             	movswl %si,%esi
    3aa8:	45 0f bf c0          	movswl %r8w,%r8d
    3aac:	48 8b 40 08          	mov    0x8(%rax),%rax
    3ab0:	ff e0                	jmpq   *%rax

0000000000003ab2 <_ZN6Canvas10drawBitmapEssssPKh>:
}

void Canvas::drawBitmap(int16_t x, int16_t y, int16_t w, int16_t h, const uint8_t* bitmapData)
{
    3ab2:	41 57                	push   %r15
    const uint16_t numPixels = w * h;
    const int16_t maxx = x + w;
    3ab4:	8d 04 31             	lea    (%rcx,%rsi,1),%eax
{
    3ab7:	4d 89 cf             	mov    %r9,%r15
    3aba:	41 56                	push   %r14
    3abc:	41 55                	push   %r13
    3abe:	41 54                	push   %r12
    3ac0:	55                   	push   %rbp
    3ac1:	53                   	push   %rbx
    3ac2:	48 89 fb             	mov    %rdi,%rbx
    3ac5:	48 83 ec 18          	sub    $0x18,%rsp

    uint8_t mask = 0;
    uint8_t byte = 0;

    // Can we use the fast path? 
    if(fg_ != bg_ && numPixels <= PIXEL_BATCH_SIZE)
    3ac9:	66 44 8b 5f 12       	mov    0x12(%rdi),%r11w
    const int16_t maxx = x + w;
    3ace:	66 89 44 24 08       	mov    %ax,0x8(%rsp)
    const int16_t maxy = y + h;
    3ad3:	41 8d 04 10          	lea    (%r8,%rdx,1),%eax
    3ad7:	66 89 44 24 0a       	mov    %ax,0xa(%rsp)
    if(fg_ != bg_ && numPixels <= PIXEL_BATCH_SIZE)
    3adc:	8b 47 10             	mov    0x10(%rdi),%eax
    const uint16_t numPixels = w * h;
    3adf:	44 89 c7             	mov    %r8d,%edi
    3ae2:	0f af f9             	imul   %ecx,%edi
{
    3ae5:	66 89 74 24 0c       	mov    %si,0xc(%rsp)
    3aea:	66 89 54 24 0e       	mov    %dx,0xe(%rsp)
    const int16_t maxx = x + w;
    3aef:	66 89 74 24 06       	mov    %si,0x6(%rsp)
    if(fg_ != bg_ && numPixels <= PIXEL_BATCH_SIZE)
    3af4:	66 83 ff 40          	cmp    $0x40,%di
    3af8:	77 06                	ja     3b00 <_ZN6Canvas10drawBitmapEssssPKh+0x4e>
    3afa:	66 44 39 d8          	cmp    %r11w,%ax
    3afe:	75 0e                	jne    3b0e <_ZN6Canvas10drawBitmapEssssPKh+0x5c>
    3b00:	0f bf ea             	movswl %dx,%ebp
    3b03:	45 31 f6             	xor    %r14d,%r14d
    3b06:	45 31 e4             	xor    %r12d,%r12d
    3b09:	e9 e3 00 00 00       	jmpq   3bf1 <_ZN6Canvas10drawBitmapEssssPKh+0x13f>
    {
        uint16_t pixelIndex = 0;
        for(int16_t j = y; j < maxy; j++)
    3b0e:	41 89 d2             	mov    %edx,%r10d
        uint16_t pixelIndex = 0;
    3b11:	31 ff                	xor    %edi,%edi
    uint8_t byte = 0;
    3b13:	31 ed                	xor    %ebp,%ebp
    uint8_t mask = 0;
    3b15:	45 31 c9             	xor    %r9d,%r9d
        {
            for(int16_t i = x; i < maxx; i++)
            {
                if((mask>>=1) == 0x0)
                {
                    mask = 0b10000000;
    3b18:	41 b4 80             	mov    $0x80,%r12b
        for(int16_t j = y; j < maxy; j++)
    3b1b:	66 44 3b 54 24 0a    	cmp    0xa(%rsp),%r10w
    3b21:	7d 4f                	jge    3b72 <_ZN6Canvas10drawBitmapEssssPKh+0xc0>
            for(int16_t i = x; i < maxx; i++)
    3b23:	66 44 8b 74 24 06    	mov    0x6(%rsp),%r14w
    3b29:	41 29 fe             	sub    %edi,%r14d
    3b2c:	66 44 89 74 24 0c    	mov    %r14w,0xc(%rsp)
    3b32:	44 8b 74 24 0c       	mov    0xc(%rsp),%r14d
    3b37:	45 8d 2c 3e          	lea    (%r14,%rdi,1),%r13d
    3b3b:	66 44 39 6c 24 08    	cmp    %r13w,0x8(%rsp)
    3b41:	7e 2a                	jle    3b6d <_ZN6Canvas10drawBitmapEssssPKh+0xbb>
                if((mask>>=1) == 0x0)
    3b43:	45 0f b6 c9          	movzbl %r9b,%r9d
    3b47:	41 d1 f9             	sar    %r9d
    3b4a:	75 09                	jne    3b55 <_ZN6Canvas10drawBitmapEssssPKh+0xa3>
                    byte = *bitmapData++;
    3b4c:	41 8a 2f             	mov    (%r15),%bpl
                    mask = 0b10000000;
    3b4f:	45 89 e1             	mov    %r12d,%r9d
                    byte = *bitmapData++;
    3b52:	49 ff c7             	inc    %r15
                }

                pixelBatch_[pixelIndex++] = ((byte & mask) != 0) ? fg_ : bg_;
    3b55:	41 84 e9             	test   %bpl,%r9b
    3b58:	45 89 de             	mov    %r11d,%r14d
    3b5b:	44 0f b7 ef          	movzwl %di,%r13d
    3b5f:	44 0f 45 f0          	cmovne %eax,%r14d
    3b63:	ff c7                	inc    %edi
    3b65:	66 46 89 74 6b 14    	mov    %r14w,0x14(%rbx,%r13,2)
            for(int16_t i = x; i < maxx; i++)
    3b6b:	eb c5                	jmp    3b32 <_ZN6Canvas10drawBitmapEssssPKh+0x80>
    3b6d:	41 ff c2             	inc    %r10d
        for(int16_t j = y; j < maxy; j++)
    3b70:	eb a9                	jmp    3b1b <_ZN6Canvas10drawBitmapEssssPKh+0x69>
            }
        }

        writePixels(x, y, w, h, pixelBatch_);
    3b72:	48 8b 03             	mov    (%rbx),%rax
    3b75:	4c 8d 4b 14          	lea    0x14(%rbx),%r9
    3b79:	48 89 df             	mov    %rbx,%rdi
    3b7c:	0f bf c9             	movswl %cx,%ecx
    3b7f:	0f bf d2             	movswl %dx,%edx
    3b82:	0f bf f6             	movswl %si,%esi
    3b85:	45 0f bf c0          	movswl %r8w,%r8d
    3b89:	48 8b 40 08          	mov    0x8(%rax),%rax
                    writePixels(i, j, 1, 1, &bg_);
                }                
            }
        }
    }
}
    3b8d:	48 83 c4 18          	add    $0x18,%rsp
    3b91:	5b                   	pop    %rbx
    3b92:	5d                   	pop    %rbp
    3b93:	41 5c                	pop    %r12
    3b95:	41 5d                	pop    %r13
    3b97:	41 5e                	pop    %r14
    3b99:	41 5f                	pop    %r15
        writePixels(x, y, w, h, pixelBatch_);
    3b9b:	ff e0                	jmpq   *%rax
                if((mask>>=1) == 0x0)
    3b9d:	45 0f b6 e4          	movzbl %r12b,%r12d
    3ba1:	41 d1 fc             	sar    %r12d
    3ba4:	75 09                	jne    3baf <_ZN6Canvas10drawBitmapEssssPKh+0xfd>
                    byte = *bitmapData++;
    3ba6:	45 8a 37             	mov    (%r15),%r14b
                    mask = 0b10000000;
    3ba9:	41 b4 80             	mov    $0x80,%r12b
                    byte = *bitmapData++;
    3bac:	49 ff c7             	inc    %r15
                if((byte & mask) != 0)
    3baf:	45 84 f4             	test   %r14b,%r12b
    3bb2:	74 4e                	je     3c02 <_ZN6Canvas10drawBitmapEssssPKh+0x150>
                    writePixels(i, j, 1, 1, &fg_);
    3bb4:	0f bf 74 24 0c       	movswl 0xc(%rsp),%esi
    3bb9:	4c 8b 1b             	mov    (%rbx),%r11
    3bbc:	4c 8d 4b 10          	lea    0x10(%rbx),%r9
    3bc0:	44 01 ee             	add    %r13d,%esi
                    writePixels(i, j, 1, 1, &bg_);
    3bc3:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    3bc9:	b9 01 00 00 00       	mov    $0x1,%ecx
    3bce:	89 ea                	mov    %ebp,%edx
    3bd0:	48 89 df             	mov    %rbx,%rdi
    3bd3:	41 ff 53 08          	callq  *0x8(%r11)
    3bd7:	41 ff c5             	inc    %r13d
            for(int16_t i = x; i < maxx; i++)
    3bda:	66 8b 44 24 06       	mov    0x6(%rsp),%ax
    3bdf:	42 8d 14 28          	lea    (%rax,%r13,1),%edx
    3be3:	66 39 54 24 08       	cmp    %dx,0x8(%rsp)
    3be8:	7f b3                	jg     3b9d <_ZN6Canvas10drawBitmapEssssPKh+0xeb>
    3bea:	66 ff 44 24 0e       	incw   0xe(%rsp)
    3bef:	ff c5                	inc    %ebp
        for(int16_t j = y; j < maxy; j++)
    3bf1:	66 8b 4c 24 0a       	mov    0xa(%rsp),%cx
    3bf6:	66 39 4c 24 0e       	cmp    %cx,0xe(%rsp)
    3bfb:	7d 20                	jge    3c1d <_ZN6Canvas10drawBitmapEssssPKh+0x16b>
    3bfd:	45 31 ed             	xor    %r13d,%r13d
    3c00:	eb d8                	jmp    3bda <_ZN6Canvas10drawBitmapEssssPKh+0x128>
                else if(fg_ != bg_)
    3c02:	66 8b 43 12          	mov    0x12(%rbx),%ax
    3c06:	66 39 43 10          	cmp    %ax,0x10(%rbx)
    3c0a:	74 cb                	je     3bd7 <_ZN6Canvas10drawBitmapEssssPKh+0x125>
                    writePixels(i, j, 1, 1, &bg_);
    3c0c:	0f bf 74 24 0c       	movswl 0xc(%rsp),%esi
    3c11:	4c 8b 1b             	mov    (%rbx),%r11
    3c14:	4c 8d 4b 12          	lea    0x12(%rbx),%r9
    3c18:	44 01 ee             	add    %r13d,%esi
    3c1b:	eb a6                	jmp    3bc3 <_ZN6Canvas10drawBitmapEssssPKh+0x111>
}
    3c1d:	48 83 c4 18          	add    $0x18,%rsp
    3c21:	5b                   	pop    %rbx
    3c22:	5d                   	pop    %rbp
    3c23:	41 5c                	pop    %r12
    3c25:	41 5d                	pop    %r13
    3c27:	41 5e                	pop    %r14
    3c29:	41 5f                	pop    %r15
    3c2b:	c3                   	retq   

0000000000003c2c <_ZN6Canvas8drawTextEssPKc>:
{
    3c2c:	41 57                	push   %r15
    3c2e:	41 56                	push   %r14
    3c30:	49 89 fe             	mov    %rdi,%r14
    3c33:	41 55                	push   %r13
    3c35:	49 89 cd             	mov    %rcx,%r13
    3c38:	41 54                	push   %r12
    3c3a:	41 89 d4             	mov    %edx,%r12d
    3c3d:	55                   	push   %rbp
    3c3e:	89 f5                	mov    %esi,%ebp
    3c40:	53                   	push   %rbx
            x = ox;
    3c41:	89 f3                	mov    %esi,%ebx
{
    3c43:	41 50                	push   %r8
    while((c = *text++))
    3c45:	49 ff c5             	inc    %r13
    3c48:	41 0f b6 45 ff       	movzbl -0x1(%r13),%eax
    3c4d:	84 c0                	test   %al,%al
    3c4f:	74 6b                	je     3cbc <_ZN6Canvas8drawTextEssPKc+0x90>
        if(c == '\n')
    3c51:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    3c55:	3c 0a                	cmp    $0xa,%al
    3c57:	75 0b                	jne    3c64 <_ZN6Canvas8drawTextEssPKc+0x38>
            y += font_->yAdvance;
    3c59:	0f b6 47 12          	movzbl 0x12(%rdi),%eax
            x = ox;
    3c5d:	89 eb                	mov    %ebp,%ebx
            y += font_->yAdvance;
    3c5f:	41 01 c4             	add    %eax,%r12d
    3c62:	eb e1                	jmp    3c45 <_ZN6Canvas8drawTextEssPKc+0x19>
        else if(c >= font_->first && c <= font_->last)
    3c64:	0f b6 57 10          	movzbl 0x10(%rdi),%edx
    3c68:	38 c2                	cmp    %al,%dl
    3c6a:	77 d9                	ja     3c45 <_ZN6Canvas8drawTextEssPKc+0x19>
    3c6c:	38 47 11             	cmp    %al,0x11(%rdi)
    3c6f:	72 d4                	jb     3c45 <_ZN6Canvas8drawTextEssPKc+0x19>
            const GFXglyph* glyph = &font_->glyph[c - font_->first];
    3c71:	29 d0                	sub    %edx,%eax
    3c73:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    3c77:	48 98                	cltq   
    3c79:	4c 8d 3c c2          	lea    (%rdx,%rax,8),%r15
                y + glyph->yOffset + font_->yAdvance, 
    3c7d:	0f b6 47 12          	movzbl 0x12(%rdi),%eax
    3c81:	66 41 0f be 57 06    	movsbw 0x6(%r15),%dx
            drawBitmap(x + glyph->xOffset, 
    3c87:	66 41 0f be 77 05    	movsbw 0x5(%r15),%si
    3c8d:	41 0f b6 4f 02       	movzbl 0x2(%r15),%ecx
    3c92:	45 0f b6 47 03       	movzbl 0x3(%r15),%r8d
                y + glyph->yOffset + font_->yAdvance, 
    3c97:	01 c2                	add    %eax,%edx
            drawBitmap(x + glyph->xOffset, 
    3c99:	01 de                	add    %ebx,%esi
                &font_->bitmap[glyph->bitmapOffset]);
    3c9b:	45 0f b7 0f          	movzwl (%r15),%r9d
            drawBitmap(x + glyph->xOffset, 
    3c9f:	4c 03 0f             	add    (%rdi),%r9
                y + glyph->yOffset + font_->yAdvance, 
    3ca2:	44 01 e2             	add    %r12d,%edx
            drawBitmap(x + glyph->xOffset, 
    3ca5:	0f bf f6             	movswl %si,%esi
    3ca8:	4c 89 f7             	mov    %r14,%rdi
    3cab:	0f bf d2             	movswl %dx,%edx
    3cae:	e8 ff fd ff ff       	callq  3ab2 <_ZN6Canvas10drawBitmapEssssPKh>
            x += glyph->xAdvance;
    3cb3:	41 0f b6 47 04       	movzbl 0x4(%r15),%eax
    3cb8:	01 c3                	add    %eax,%ebx
    3cba:	eb 89                	jmp    3c45 <_ZN6Canvas8drawTextEssPKc+0x19>
}
    3cbc:	58                   	pop    %rax
    3cbd:	5b                   	pop    %rbx
    3cbe:	5d                   	pop    %rbp
    3cbf:	41 5c                	pop    %r12
    3cc1:	41 5d                	pop    %r13
    3cc3:	41 5e                	pop    %r14
    3cc5:	41 5f                	pop    %r15
    3cc7:	c3                   	retq   

0000000000003cc8 <_ZN6Canvas18executeCommandListERK11CommandList>:
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    3cc8:	8a 05 f2 56 00 00    	mov    0x56f2(%rip),%al        # 93c0 <ProfilingTimestampCount>
{
    3cce:	41 56                	push   %r14
    3cd0:	41 55                	push   %r13
        switch(it->type)
    3cd2:	4c 8d 2d e7 0f 00 00 	lea    0xfe7(%rip),%r13        # 4cc0 <_ZL10icons_data+0x280>
    3cd9:	8d 50 01             	lea    0x1(%rax),%edx
    timestamp.name = name;
    3cdc:	83 e0 3f             	and    $0x3f,%eax
{
    3cdf:	41 54                	push   %r12
    3ce1:	4c 8d 25 d8 52 00 00 	lea    0x52d8(%rip),%r12        # 8fc0 <ProfilingTimestamps>
    3ce8:	48 c1 e0 04          	shl    $0x4,%rax
    3cec:	55                   	push   %rbp
    3ced:	48 89 fd             	mov    %rdi,%rbp
    3cf0:	48 8d 3d 96 0f 00 00 	lea    0xf96(%rip),%rdi        # 4c8d <_ZL10icons_data+0x24d>
    3cf7:	4c 01 e0             	add    %r12,%rax
    3cfa:	53                   	push   %rbx
    const BaseCommand* end = cmdList.end();
    3cfb:	4c 8b 76 10          	mov    0x10(%rsi),%r14
    3cff:	48 89 38             	mov    %rdi,(%rax)
    timestamp.id = id;
    3d02:	c6 40 08 00          	movb   $0x0,0x8(%rax)
    timestamp.time = 0;
    3d06:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%rax)
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    3d0d:	88 15 ad 56 00 00    	mov    %dl,0x56ad(%rip)        # 93c0 <ProfilingTimestampCount>
    const BaseCommand* it = cmdList.begin();
    3d13:	48 8b 1e             	mov    (%rsi),%rbx
    while(it != end)
    3d16:	49 39 de             	cmp    %rbx,%r14
    3d19:	0f 84 21 02 00 00    	je     3f40 <_ZN6Canvas18executeCommandListERK11CommandList+0x278>
        switch(it->type)
    3d1f:	80 3b 0a             	cmpb   $0xa,(%rbx)
    3d22:	77 f2                	ja     3d16 <_ZN6Canvas18executeCommandListERK11CommandList+0x4e>
    3d24:	0f b6 03             	movzbl (%rbx),%eax
    3d27:	49 63 44 85 00       	movslq 0x0(%r13,%rax,4),%rax
    3d2c:	4c 01 e8             	add    %r13,%rax
    3d2f:	ff e0                	jmpq   *%rax
                it += sizeof(BaseCommand);                
    3d31:	48 ff c3             	inc    %rbx
            break;
    3d34:	eb e0                	jmp    3d16 <_ZN6Canvas18executeCommandListERK11CommandList+0x4e>
                drawHLine(cmd.x, cmd.y, cmd.w);
    3d36:	66 8b 53 04          	mov    0x4(%rbx),%dx
    3d3a:	66 8b 73 02          	mov    0x2(%rbx),%si
    3d3e:	48 89 ef             	mov    %rbp,%rdi
    3d41:	66 8b 4b 06          	mov    0x6(%rbx),%cx
    3d45:	c1 e2 05             	shl    $0x5,%edx
    3d48:	c1 e6 05             	shl    $0x5,%esi
    3d4b:	66 c1 fa 05          	sar    $0x5,%dx
    3d4f:	66 c1 fe 05          	sar    $0x5,%si
    3d53:	81 e1 ff 03 00 00    	and    $0x3ff,%ecx
    3d59:	0f bf d2             	movswl %dx,%edx
    3d5c:	0f bf f6             	movswl %si,%esi
    3d5f:	e8 96 fb ff ff       	callq  38fa <_ZN6Canvas9drawHLineEsss>
                it += cmd.size();
    3d64:	eb 2e                	jmp    3d94 <_ZN6Canvas18executeCommandListERK11CommandList+0xcc>
                drawVLine(cmd.x, cmd.y, cmd.h);
    3d66:	66 8b 53 04          	mov    0x4(%rbx),%dx
    3d6a:	66 8b 73 02          	mov    0x2(%rbx),%si
    3d6e:	48 89 ef             	mov    %rbp,%rdi
    3d71:	66 8b 4b 06          	mov    0x6(%rbx),%cx
    3d75:	c1 e2 05             	shl    $0x5,%edx
    3d78:	c1 e6 05             	shl    $0x5,%esi
    3d7b:	66 c1 fa 05          	sar    $0x5,%dx
    3d7f:	66 c1 fe 05          	sar    $0x5,%si
    3d83:	81 e1 ff 03 00 00    	and    $0x3ff,%ecx
    3d89:	0f bf d2             	movswl %dx,%edx
    3d8c:	0f bf f6             	movswl %si,%esi
    3d8f:	e8 82 fb ff ff       	callq  3916 <_ZN6Canvas9drawVLineEsss>
                it += cmd.size();
    3d94:	48 83 c3 08          	add    $0x8,%rbx
            break;
    3d98:	e9 79 ff ff ff       	jmpq   3d16 <_ZN6Canvas18executeCommandListERK11CommandList+0x4e>
                drawLine(cmd.x0, cmd.y0, cmd.x1, cmd.y1);
    3d9d:	66 44 8b 43 08       	mov    0x8(%rbx),%r8w
    3da2:	66 8b 4b 06          	mov    0x6(%rbx),%cx
    3da6:	48 89 ef             	mov    %rbp,%rdi
    3da9:	66 8b 53 04          	mov    0x4(%rbx),%dx
    3dad:	66 8b 73 02          	mov    0x2(%rbx),%si
    3db1:	41 c1 e0 05          	shl    $0x5,%r8d
    3db5:	c1 e1 05             	shl    $0x5,%ecx
    3db8:	c1 e2 05             	shl    $0x5,%edx
    3dbb:	c1 e6 05             	shl    $0x5,%esi
    3dbe:	66 41 c1 f8 05       	sar    $0x5,%r8w
    3dc3:	66 c1 f9 05          	sar    $0x5,%cx
    3dc7:	66 c1 fa 05          	sar    $0x5,%dx
    3dcb:	66 c1 fe 05          	sar    $0x5,%si
    3dcf:	0f bf c9             	movswl %cx,%ecx
    3dd2:	45 0f bf c0          	movswl %r8w,%r8d
    3dd6:	0f bf d2             	movswl %dx,%edx
    3dd9:	0f bf f6             	movswl %si,%esi
    3ddc:	e8 51 fb ff ff       	callq  3932 <_ZN6Canvas8drawLineEssss>
                it += cmd.size();
    3de1:	eb 3a                	jmp    3e1d <_ZN6Canvas18executeCommandListERK11CommandList+0x155>
                drawBox(cmd.x, cmd.y, cmd.w, cmd.h);
    3de3:	66 8b 53 04          	mov    0x4(%rbx),%dx
    3de7:	66 8b 73 02          	mov    0x2(%rbx),%si
    3deb:	48 89 ef             	mov    %rbp,%rdi
    3dee:	66 44 8b 43 08       	mov    0x8(%rbx),%r8w
    3df3:	66 8b 4b 06          	mov    0x6(%rbx),%cx
    3df7:	c1 e2 05             	shl    $0x5,%edx
    3dfa:	c1 e6 05             	shl    $0x5,%esi
    3dfd:	66 c1 fa 05          	sar    $0x5,%dx
    3e01:	66 c1 fe 05          	sar    $0x5,%si
    3e05:	81 e1 ff 03 00 00    	and    $0x3ff,%ecx
    3e0b:	41 81 e0 ff 03 00 00 	and    $0x3ff,%r8d
    3e12:	0f bf d2             	movswl %dx,%edx
    3e15:	0f bf f6             	movswl %si,%esi
    3e18:	e8 d3 fb ff ff       	callq  39f0 <_ZN6Canvas7drawBoxEssss>
                it += cmd.size();
    3e1d:	48 83 c3 0a          	add    $0xa,%rbx
            break;
    3e21:	e9 f0 fe ff ff       	jmpq   3d16 <_ZN6Canvas18executeCommandListERK11CommandList+0x4e>
                drawFilledBox(cmd.x, cmd.y, cmd.w, cmd.h);
    3e26:	66 8b 53 04          	mov    0x4(%rbx),%dx
    3e2a:	66 8b 73 02          	mov    0x2(%rbx),%si
    3e2e:	48 89 ef             	mov    %rbp,%rdi
    3e31:	66 44 8b 43 08       	mov    0x8(%rbx),%r8w
    3e36:	66 8b 4b 06          	mov    0x6(%rbx),%cx
    3e3a:	c1 e2 05             	shl    $0x5,%edx
    3e3d:	c1 e6 05             	shl    $0x5,%esi
    3e40:	66 c1 fa 05          	sar    $0x5,%dx
    3e44:	66 c1 fe 05          	sar    $0x5,%si
    3e48:	81 e1 ff 03 00 00    	and    $0x3ff,%ecx
    3e4e:	41 81 e0 ff 03 00 00 	and    $0x3ff,%r8d
    3e55:	0f bf d2             	movswl %dx,%edx
    3e58:	0f bf f6             	movswl %si,%esi
    3e5b:	e8 22 fc ff ff       	callq  3a82 <_ZN6Canvas13drawFilledBoxEssss>
                it += cmd.size();
    3e60:	eb bb                	jmp    3e1d <_ZN6Canvas18executeCommandListERK11CommandList+0x155>
                drawBitmap(cmd.x, cmd.y, cmd.w, cmd.h, cmd.data);
    3e62:	8b 53 04             	mov    0x4(%rbx),%edx
    3e65:	66 8b 73 02          	mov    0x2(%rbx),%si
    3e69:	48 89 ef             	mov    %rbp,%rdi
    3e6c:	44 8b 43 08          	mov    0x8(%rbx),%r8d
    3e70:	66 8b 4b 06          	mov    0x6(%rbx),%cx
    3e74:	c1 e2 05             	shl    $0x5,%edx
    3e77:	c1 e6 05             	shl    $0x5,%esi
    3e7a:	4c 8b 4b 10          	mov    0x10(%rbx),%r9
    3e7e:	66 c1 fa 05          	sar    $0x5,%dx
    3e82:	66 c1 fe 05          	sar    $0x5,%si
    3e86:	81 e1 ff 03 00 00    	and    $0x3ff,%ecx
    3e8c:	41 81 e0 ff 03 00 00 	and    $0x3ff,%r8d
    3e93:	0f bf d2             	movswl %dx,%edx
    3e96:	0f bf f6             	movswl %si,%esi
    3e99:	e8 14 fc ff ff       	callq  3ab2 <_ZN6Canvas10drawBitmapEssssPKh>
    uint16_t padding : 6;
    const uint8_t* data;

    int16_t size() const
    {
        return sizeof(CommandDrawBitmap);
    3e9e:	eb 3c                	jmp    3edc <_ZN6Canvas18executeCommandListERK11CommandList+0x214>
                drawPixels(cmd.x, cmd.y, cmd.w, cmd.h, cmd.data);
    3ea0:	8b 53 04             	mov    0x4(%rbx),%edx
    3ea3:	66 8b 73 02          	mov    0x2(%rbx),%si
    3ea7:	48 89 ef             	mov    %rbp,%rdi
    3eaa:	44 8b 43 08          	mov    0x8(%rbx),%r8d
    3eae:	66 8b 4b 06          	mov    0x6(%rbx),%cx
    3eb2:	c1 e2 05             	shl    $0x5,%edx
    3eb5:	c1 e6 05             	shl    $0x5,%esi
    3eb8:	4c 8b 4b 10          	mov    0x10(%rbx),%r9
    3ebc:	66 c1 fa 05          	sar    $0x5,%dx
    3ec0:	66 c1 fe 05          	sar    $0x5,%si
    3ec4:	81 e1 ff 03 00 00    	and    $0x3ff,%ecx
    3eca:	41 81 e0 ff 03 00 00 	and    $0x3ff,%r8d
    3ed1:	0f bf d2             	movswl %dx,%edx
    3ed4:	0f bf f6             	movswl %si,%esi
    3ed7:	e8 c0 fb ff ff       	callq  3a9c <_ZN6Canvas10drawPixelsEssssPKt>
                it += cmd.size();
    3edc:	48 83 c3 18          	add    $0x18,%rbx
            break;
    3ee0:	e9 31 fe ff ff       	jmpq   3d16 <_ZN6Canvas18executeCommandListERK11CommandList+0x4e>
                drawText(cmd.x, cmd.y, reinterpret_cast<const char*>((&cmd) + 1));
    3ee5:	66 8b 53 04          	mov    0x4(%rbx),%dx
    3ee9:	66 8b 73 02          	mov    0x2(%rbx),%si
    3eed:	48 8d 4b 08          	lea    0x8(%rbx),%rcx
    3ef1:	48 89 ef             	mov    %rbp,%rdi
    3ef4:	c1 e2 05             	shl    $0x5,%edx
    3ef7:	c1 e6 05             	shl    $0x5,%esi
    3efa:	66 c1 fa 05          	sar    $0x5,%dx
    3efe:	66 c1 fe 05          	sar    $0x5,%si
    3f02:	0f bf d2             	movswl %dx,%edx
    3f05:	0f bf f6             	movswl %si,%esi
    3f08:	e8 1f fd ff ff       	callq  3c2c <_ZN6Canvas8drawTextEssPKc>
    int16_t y : 11;
    uint16_t length : 10;

    int16_t size() const
    {
        return sizeof(CommandDrawText) + length;
    3f0d:	66 8b 43 06          	mov    0x6(%rbx),%ax
    3f11:	25 ff 03 00 00       	and    $0x3ff,%eax
                it += cmd.size();
    3f16:	48 8d 5c 03 08       	lea    0x8(%rbx,%rax,1),%rbx
            break;
    3f1b:	e9 f6 fd ff ff       	jmpq   3d16 <_ZN6Canvas18executeCommandListERK11CommandList+0x4e>
                setColors(cmd.fg, cmd.bg);
    3f20:	8b 43 02             	mov    0x2(%rbx),%eax
                it += cmd.size();
    3f23:	48 83 c3 06          	add    $0x6,%rbx
    void drawFilledBox(int16_t x, int16_t y, int16_t w, int16_t h);
    void drawBitmap(int16_t x, int16_t y, int16_t w, int16_t h, const uint8_t* bitmapData);
    void drawPixels(int16_t x, int16_t y, int16_t w, int16_t h, const uint16_t* pixelData);
    void drawText(int16_t x, int16_t y, const char* text);

    void setColors(uint16_t fg, uint16_t bg) { fg_ = fg; bg_ = bg; }
    3f27:	89 45 10             	mov    %eax,0x10(%rbp)
            break;
    3f2a:	e9 e7 fd ff ff       	jmpq   3d16 <_ZN6Canvas18executeCommandListERK11CommandList+0x4e>
                setFont(cmd.font);
    3f2f:	48 8b 43 08          	mov    0x8(%rbx),%rax
                it += cmd.size();
    3f33:	48 83 c3 10          	add    $0x10,%rbx
    void setFont(const GFXfont* font) { font_ = font; }
    3f37:	48 89 45 08          	mov    %rax,0x8(%rbp)
            break;
    3f3b:	e9 d6 fd ff ff       	jmpq   3d16 <_ZN6Canvas18executeCommandListERK11CommandList+0x4e>
    3f40:	8a 05 7a 54 00 00    	mov    0x547a(%rip),%al        # 93c0 <ProfilingTimestampCount>
    timestamp.name = name;
    3f46:	48 8d 3d 59 0d 00 00 	lea    0xd59(%rip),%rdi        # 4ca6 <_ZL10icons_data+0x266>
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    3f4d:	8d 50 01             	lea    0x1(%rax),%edx
    timestamp.name = name;
    3f50:	83 e0 3f             	and    $0x3f,%eax
    3f53:	48 c1 e0 04          	shl    $0x4,%rax
    ProfilingTimestampData& timestamp = ProfilingTimestamps[ProfilingTimestampCount++ & (MAX_TIMESTAMPS-1)];
    3f57:	88 15 63 54 00 00    	mov    %dl,0x5463(%rip)        # 93c0 <ProfilingTimestampCount>
    timestamp.name = name;
    3f5d:	4c 01 e0             	add    %r12,%rax
    3f60:	48 89 38             	mov    %rdi,(%rax)
    timestamp.id = id;
    3f63:	c6 40 08 00          	movb   $0x0,0x8(%rax)
    timestamp.time = 0;
    3f67:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%rax)
}
    3f6e:	5b                   	pop    %rbx
    3f6f:	5d                   	pop    %rbp
    3f70:	41 5c                	pop    %r12
    3f72:	41 5d                	pop    %r13
    3f74:	41 5e                	pop    %r14
    3f76:	c3                   	retq   
    3f77:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    3f7e:	00 00 

0000000000003f80 <__libc_csu_init>:
    3f80:	41 57                	push   %r15
    3f82:	49 89 d7             	mov    %rdx,%r15
    3f85:	41 56                	push   %r14
    3f87:	49 89 f6             	mov    %rsi,%r14
    3f8a:	41 55                	push   %r13
    3f8c:	41 89 fd             	mov    %edi,%r13d
    3f8f:	41 54                	push   %r12
    3f91:	4c 8d 25 10 2c 00 00 	lea    0x2c10(%rip),%r12        # 6ba8 <__frame_dummy_init_array_entry>
    3f98:	55                   	push   %rbp
    3f99:	48 8d 2d 18 2c 00 00 	lea    0x2c18(%rip),%rbp        # 6bb8 <__init_array_end>
    3fa0:	53                   	push   %rbx
    3fa1:	4c 29 e5             	sub    %r12,%rbp
    3fa4:	48 83 ec 08          	sub    $0x8,%rsp
    3fa8:	e8 53 d0 ff ff       	callq  1000 <_init>
    3fad:	48 c1 fd 03          	sar    $0x3,%rbp
    3fb1:	74 1b                	je     3fce <__libc_csu_init+0x4e>
    3fb3:	31 db                	xor    %ebx,%ebx
    3fb5:	0f 1f 00             	nopl   (%rax)
    3fb8:	4c 89 fa             	mov    %r15,%rdx
    3fbb:	4c 89 f6             	mov    %r14,%rsi
    3fbe:	44 89 ef             	mov    %r13d,%edi
    3fc1:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
    3fc5:	48 83 c3 01          	add    $0x1,%rbx
    3fc9:	48 39 dd             	cmp    %rbx,%rbp
    3fcc:	75 ea                	jne    3fb8 <__libc_csu_init+0x38>
    3fce:	48 83 c4 08          	add    $0x8,%rsp
    3fd2:	5b                   	pop    %rbx
    3fd3:	5d                   	pop    %rbp
    3fd4:	41 5c                	pop    %r12
    3fd6:	41 5d                	pop    %r13
    3fd8:	41 5e                	pop    %r14
    3fda:	41 5f                	pop    %r15
    3fdc:	c3                   	retq   
    3fdd:	0f 1f 00             	nopl   (%rax)

0000000000003fe0 <__libc_csu_fini>:
    3fe0:	c3                   	retq   

Disassembly of section .fini:

0000000000003fe4 <_fini>:
    3fe4:	48 83 ec 08          	sub    $0x8,%rsp
    3fe8:	48 83 c4 08          	add    $0x8,%rsp
    3fec:	c3                   	retq   
