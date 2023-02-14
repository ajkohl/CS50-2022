const readlineSync = require('readline-sync');

var height = 0;

while (true) {
    height = readlineSync.question("How tall would you like your staircase to be? ");
    if (height >= 1 && height <= 8) {
    break;
  }
}

for (var h = 0; h < height; h += 1) {
        for (var t = height - h; t > 1; t -= 1) {
            process.stdout.write(" ");
        }

        for (var i = 0; i <= h; i += 1) {
            process.stdout.write("#");
        }

        process.stdout.write("  ");

        for (var j = 0; j <= h; j += 1) {
            process.stdout.write("#");
        }

        for (var t = height - h; t > 1; t -= 1) {
            process.stdout.write(" ");
        }

        process.stdout.write("\n");
    }