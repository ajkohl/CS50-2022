#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <math.h>

//declares variables
int letterCount;
int wordCount;
int sentCount;
float index;
float L;
float S;

//declares functions
int count_letters(string text);
int count_spaces(string text);
int count_punct(string text);

int main(void)
{
    //gets text input
    string inputTxt = get_string("Text: ");

    //calls functions that calculate number of letters, words, and sentences
    letterCount = count_letters(inputTxt);
    wordCount = count_spaces(inputTxt) + 1;
    sentCount = count_punct(inputTxt);

    //performs reading index calculation
    L = 100.0 * letterCount / wordCount;
    S = 100.0 * sentCount / wordCount;
    index = 0.0588 * L - 0.296 * S - 15.8;

    //display appropriate text output
    if (index < 0.5)
    {
        printf("Before Grade 1\n");
    }
    else if (index > 16.499)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %i\n", (int)round(index));
    }
}

//functions
int count_letters(string text)
{
    int letterNum = 0;

    //iterates through the letters of the input string to count number of letters
    for (int i = 0; i < strlen(text); i++)
    {
        if (isalpha(text[i]))
        {
            letterNum += 1;
        }
    }
    return letterNum;
}

int count_spaces(string text)
{
    int spaceNum = 0;

    //iterates through the letters of the input string to count number of spaces
    for (int j = 0; j < strlen(text); j++)
    {
        if (isspace(text[j]))
        {
            spaceNum += 1;
        }
    }
    return spaceNum;
}

int count_punct(string text)
{
    int punctNum = 0;
    //iterates through the letters of the input string to count number of sentence ending punctuation symbols
    for (int k = 0; k < strlen(text); k++)
    {
        if ((text[k]) == '.' || (text[k]) == '?' || (text[k]) == '!')
        {
            punctNum += 1;
        }
    }
    return punctNum;
}