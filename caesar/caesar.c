#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <math.h>
#include <stdlib.h>

//declares functions
bool only_digits(string inputKey);
int rotate(string inputTxt, int key);


int main(int argc, string argv[])
{

    //ensures that there is only one command line argument
    if (argc == 2)
    {
        //ensures the key is only comprised of digits
        if (only_digits(argv[1]))
        {
            int key = atoi(argv[1]);
            string inputTxt = get_string("plaintext: ");
            rotate(inputTxt, key);
        }
        else
        {
            //closes out and concludes the program and tells user the proper format for use given an improper CLA
            printf("Usage: ./caesar key\n");
            return 1;
        }

    }
    else
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }
}


bool only_digits(string inputKey)
{
    //iterates through every letter of the command line argument to ensure that there are no non-digits
    for (int i = 0; i < strlen(inputKey); i++)
    {
        if (isdigit(inputKey[i]) == 0)
        {
            return false;
        }
    }
    return true;
}


int rotate(string inputTxt, int key)
{
    char cipherLetter;

    printf("ciphertext: ");

    //iterates through the input plaintext
    for (int j = 0; j < strlen(inputTxt); j++)
    {
        if (isalpha(inputTxt[j]) != 0)
        {
            if (islower(inputTxt[j]))
            {
                //adds the key to the ascii values to shift the letters for lowercase letters
                cipherLetter = ((inputTxt[j] - 97 + key) % 26) + 97;
                printf("%c", cipherLetter);
            }
            if (isupper(inputTxt[j]))
            {
                //adds the key to the ascii values to shift the letters for uppercase letters
                cipherLetter = ((inputTxt[j] - 65 + key) % 26) + 65;
                printf("%c", cipherLetter);
            }
        }
        else
        {
            //prints non alphabet characters normally
            printf("%c", inputTxt[j]);
        }
    }
    printf("\n");
    return 1;
}