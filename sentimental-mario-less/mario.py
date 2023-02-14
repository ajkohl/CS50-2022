# TODO
from cs50 import get_int

height = 10
while True:
    height = get_int("Height: ")
    if (height > 0 and height < 9):
        break

# iterates through every line
for i in range(0, height):
    # prints spaces accoding to approriate line
    for d in range(i+1, height):
        print(" ", end="")
    # prints hashes according to appropriate line
    for j in range(0, i + 1):
        print("#", end="")
    # line break
    print("")

