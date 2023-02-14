#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef uint8_t BYTE;
BYTE buffer[512];

//open memory card
// repeat until end of card:
//    read 512 bytes into a buffer
//    if start of new jpeg
//       if first jpeg
//          create new jpeg file 000
//       else
//          if already found jpeg
//             keep writing to the open file

int main(int argc, char *argv[])
{
    //makes sure that there is only one command line argument
    if (argc != 2)
    {
        printf("usage: ./recover [file name]");
        return 1;
    }

    //declares files and establishes pointers
    FILE *inputfile = fopen(argv[1], "r");
    FILE *outputfile = NULL;

    //returns and prints that file is invalid if CLA is invalid
    if (inputfile == NULL)
    {
        printf("invalid");
        return 1;
    }

    //initializes variables
    int imageCount = 0;
    char fname[8];

    //loops until inputfile is read
    while (fread(buffer, 1, 512, inputfile) == 512)
    {
        //looks for jpeg signature
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0)
        {
            if (imageCount != 0)
            {
                //closes previous file when new jpeg is found
                fclose(outputfile);
            }

            //creates new name for new jpeg file
            sprintf(fname, "%03i.jpg", imageCount);

            imageCount++;

            outputfile = fopen(fname, "w");
        }

        //if no new jpeg signature found, continues to write to old file
        if (outputfile != NULL)
        {
            fwrite(buffer, 1, 512, outputfile);
        }
    }

    //closes and returns once everything is read
    fclose(outputfile);
    fclose(inputfile);
    return 0;
}