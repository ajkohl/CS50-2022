#include <cs50.h>
#include <stdio.h>

bool pop(int *n)
{
    if (s.size != 0)
    {
        *n = s.numbers[s.size -1];
        s.numbers[s.size - 1] = 0;
        s.size --;
        return true;
    }
    else
    {
        return false;
    }
}
