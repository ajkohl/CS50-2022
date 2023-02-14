# TODO
from cs50 import get_float

changeOwed = 0
coinCount = 0

# gets change owed amount
while (changeOwed < 0.01):
    changeOwed = get_float("Change owed: ")

# calculates amount of quarters
while (round(changeOwed, 2) >= 0.25):
    changeOwed = changeOwed - 0.25
    coinCount += 1

# calculates amount of dimes
while (round(changeOwed, 2) >= 0.10):
    changeOwed = changeOwed - 0.10
    coinCount += 1

# calculates amount of nickels
while (round(changeOwed, 2) >= 0.05):
    changeOwed = changeOwed - 0.05
    coinCount += 1

# calculates amount of pennies
while (round(changeOwed, 2) > 0):
    changeOwed = changeOwed - 0.01
    coinCount += 1

# prints number of coins
print(coinCount)