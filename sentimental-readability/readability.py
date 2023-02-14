# TODO
from cs50 import get_string

# gets user input
inputTxt = get_string("Text: ")


def count_letters(Text):
    letters = 0
    for i in range(len(Text)):
        if (Text[i].isalpha()):
            letters += 1
    return int(letters)


# counts the number of spaces by iterating through the text and counting spaces
def count_spaces(Text):
    spaces = 0
    for i in range(len(Text)):
        if (Text[i].isspace()):
            spaces += 1
    return int(spaces)


# counts amount of punctuation marks to determine sentence number
def count_punct(Text):
    punct = 0
    for i in range(len(Text)):
        if (Text[i] == "." or Text[i] == "!" or Text[i] == "?"):
            punct += 1
    return int(punct)


# calls all functions
letterCount = count_letters(inputTxt)
print(letterCount)
wordCount = count_spaces(inputTxt) + 1
print(wordCount)
sentCount = count_punct(inputTxt)
print(sentCount)

L = 100.0 * float(letterCount) / float(wordCount)
print(L)
S = 100.0 * float(sentCount) / float(wordCount)
print(S)
index = (0.0588 * float(L)) - (0.296 * float(S)) - 15.8

print(index)

# converts index to grade level
if (index < 0.5):
    print("Before Grade 1\n")

elif (index > 16.499):
    print("Grade 16+\n")

else:
    print("Grade " + str(round(index)))