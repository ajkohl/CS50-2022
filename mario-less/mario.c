#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int height;
    do
    {

        //Asks user to input height and assigns answer to variable "height"
        height = get_int("How tall do you want your pyramid? ");

    }
    while (height < 1 || height > 8);

    //iterates through each level of pyramid
    for (int i = 0; i < height; i++)
    {

        for (int d = height - 1; d > i; d--)
        {
            printf(" ");
        }

        for (int j = 0; j < i + 1; j++)
        {
            printf("#");
        }

        printf("\n");
    }
}