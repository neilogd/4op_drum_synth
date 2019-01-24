#if 0
#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"

int main()
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

	printf( "Done!\n");
}
#endif
