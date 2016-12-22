// bmptoc.c
// Name: YEA WON YOON

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <ctype.h>

// This is the array into which you will load the raw data from the file
// You don't have to use this array if you don't want to, but you will be responsible
// for any errors caused by erroneously using the stack or malloc if you do it a
// different way, incorrectly!
char data_arr[0x36 + 240 * 160 * 4];

int main(int argc, char *argv[]) {

	// 1. Make sure the user passed in the correct number of arguments
	if(argc != 2){
		printf("Wrong number of argument.\n");
		return 0;
	}


	// 2. Open the file; if it doesn't exist, tell the user and then exit
	FILE *fp;
	fp = fopen(argv[1], "r");
	if(fp == NULL){
		printf("No file.\n");
		return 0;
	}
	

	// 3. Read the file into the buffer then close it when you are done
	fread(data_arr, 1, sizeof(data_arr), fp);
	fclose(fp);


	// 4. Get the width and height of the image
	unsigned int* widthHeight = (unsigned int*)(data_arr + 0x12);
	unsigned int width = widthHeight[0];
	unsigned int height = widthHeight[1];


	// 5. Create header file, and write header contents; close it
	FILE* headerF;
	char one[100];
	char two[100];
	char cap[100];
	strncpy(one, argv[1], strlen(argv[1]) - 4);
	one[strlen(argv[1]) - 4] = '\0';
	for(unsigned int i = 0; i < sizeof(one); i++) {
		cap[i] = toupper(one[i]);
	}
	strcpy(two, one);
	strcat(one, ".h");
	printf("%s\n", one);
	headerF = fopen(one, "w");
	fprintf(headerF, "#define %s_WIDTH %d\n", cap, width);
	fprintf(headerF, "#define %s_HEIGHT %d\n", cap, height);
	int mult = width * height;
	fprintf(headerF, "const unsigned short %s_data[%d];", two, mult);
	fclose(headerF);


	// 6. Create C file, and write pixel data; close it
	FILE* cF;
	char cOne[100];
	char cTwo[100];
	strncpy(cOne, argv[1], strlen(argv[1]) - 4);
	cOne[strlen(argv[1]) - 4] = '\0';
	strcpy(cTwo, cOne);
	strcat(cOne, ".c");
	printf("%s\n", cOne);
	cF = fopen(cOne, "w");
	fprintf(cF, "const unsigned short %s_data[%d] = { \n", cTwo, mult);
	unsigned int* colorArr = (unsigned int*) (data_arr + 0x36);
	for(int i = height - 1; i >= 0; i--) {
		for(unsigned int j = 0; j < width; j++) {
			unsigned int color = colorArr[i * width + j];
			unsigned char blue = color & 0xFF;
			unsigned char green = (color >> 8) & 0xFF;
			unsigned char red = (color >> 16) & 0xFF;
			blue = blue >> 3;
			green = green >> 3;
			red = red >> 3;
			unsigned short pixel = (red) | (green << 5) | (blue << 10);
			fprintf(cF, "0x%04X,\t", pixel);
		}
		fprintf(cF, "\n");
	}
	fprintf(cF, "};");
	fclose(cF);
	return 0;
}

