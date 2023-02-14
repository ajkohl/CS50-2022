var dollarsowed = 0;
var changeowed = 0;
var coincount = 0;

const readlineSync = require('readline-sync');

while (true)
{
    dollarsowed = readlineSync.question("Change owed: ");
    if (dollarsowed > 0) {break;}
}

while (dollarsowed > 0.01) {
    if (dollarsowed >= 0.25){
        dollarsowed = (dollarsowed - 0.25);
        coincount += 1
    }
    else if (dollarsowed >= 0.10){
        dollarsowed = (dollarsowed - 0.10);
        coincount += 1
    }
    else if (dollarsowed >= 0.05){
        dollarsowed = (dollarsowed - 0.05);
        coincount += 1
    }
    else if (dollarsowed < 0.05){
        dollarsowed = (dollarsowed - 0.01);
        coincount += 1
    }
}

console.log(coincount);

// while (round(changeOwed, 2) >= 0.25) {
//   let changeOwed = changeOwed - 0.25;
//   coinCount += 1;
// }

// while (round(changeOwed, 2) >= 0.1) {
//   changeOwed = changeOwed - 0.1;
//   coinCount += 1;
// }

// while (round(changeOwed, 2) >= 0.05) {
//   changeOwed = changeOwed - 0.05;
//   coinCount += 1;
// }

// while (round(changeOwed, 2) > 0) {
//   changeOwed = changeOwed - 0.01;
//   coinCount += 1;
// }

// console.log(coinCount);

