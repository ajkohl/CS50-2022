#include "helpers.h"
#include "math.h"
#include "cs50.h"
#include <stdio.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    //iterates through every pixel
    for (int h = 0; h < height; h++)
    {
        for (int w = 0; w < width; w++)
        {
            //finds the average of every intensity value
            float grayScaleIntensity = round((image[h][w].rgbtRed + image[h][w].rgbtGreen + image[h][w].rgbtBlue) / 3.0);

            //assigns the greyscale intensity to R G and B
            image[h][w].rgbtRed = grayScaleIntensity;
            image[h][w].rgbtGreen = grayScaleIntensity;
            image[h][w].rgbtBlue = grayScaleIntensity;
        }
    }
    return;
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    for (int h = 0; h < height; h++)
    {
        for (int w = 0; w < width; w++)
        {
            //sepia algorithm
            int sepiaRed = round(.393 * image[h][w].rgbtRed + .769 * image[h][w].rgbtGreen + .189 * image[h][w].rgbtBlue);
            int sepiaGreen = round(.349 * image[h][w].rgbtRed + .686 * image[h][w].rgbtGreen + .168 * image[h][w].rgbtBlue);
            int sepiaBlue = round(.272 * image[h][w].rgbtRed + .534 * image[h][w].rgbtGreen + .131 * image[h][w].rgbtBlue);

            //ensures that none of the values cause an overflow error and assigns sepia processed color values to the image's pixels
            if (sepiaRed <= 255)
            {
                image[h][w].rgbtRed = sepiaRed;
            }
            else
            {
                image[h][w].rgbtRed = 255;
            }

            if (sepiaGreen <= 255)
            {
                image[h][w].rgbtGreen = sepiaGreen;
            }
            else
            {
                image[h][w].rgbtGreen = 255;
            }

            if (sepiaBlue <= 255)
            {
                image[h][w].rgbtBlue = sepiaBlue;
            }
            else
            {
                image[h][w].rgbtBlue = 255;
            }
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (int h = 0; h < height; h++)
    {
        for (int w = 0; w < width / 2; w++)
        {
            //creates temporary variables to store pixel values for the reflection
            int tempRed = image[h][w].rgbtRed;
            int tempGreen = image[h][w].rgbtGreen;
            int tempBlue = image[h][w].rgbtBlue;

            //reflects
            image[h][w].rgbtRed = image[h][width - w - 1].rgbtRed;
            image[h][w].rgbtGreen = image[h][width - w - 1].rgbtGreen;
            image[h][w].rgbtBlue = image[h][width - w - 1].rgbtBlue;

            //reflects
            image[h][width - w - 1].rgbtRed = tempRed;
            image[h][width - w - 1].rgbtGreen = tempGreen;
            image[h][width - w - 1].rgbtBlue = tempBlue;
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    //creates a copy of the image
    RGBTRIPLE copy[height][width];

    for (int h = 0; h < height; h++)
    {
        for (int w = 0; w < width; w++)
        {
            copy[h][w] = image[h][w];
        }
    }

    for (int h = 0; h < height; h++)
    {
        for (int w = 0; w < width; w++)
        {
            float redSum = 0.0;
            float greenSum = 0.0;
            float blueSum = 0.0;
            int counter = 0;

            //iterates through the pixels surrounding target pixel
            for (int k = h - 1; k < h + 2; k++)
            {
                for (int l = w - 1; l < w + 2; l++)
                {
                    if ((k >= 0) && (k < height) && (l >= 0) && (l < width))
                    {
                        //calculates things needed to find local averages
                        counter++;
                        redSum += copy[k][l].rgbtRed;
                        greenSum += copy[k][l].rgbtGreen;
                        blueSum += copy[k][l].rgbtBlue;
                    }
                }

                if (counter != 0)
                {
                    //assigns the average color values from the surrounding pixels to the target pixel in the original image
                    image[h][w].rgbtRed = round(redSum / counter);
                    image[h][w].rgbtGreen = round(greenSum / counter);
                    image[h][w].rgbtBlue = round(blueSum / counter);
                }
            }
        }
    }
    return;

}
