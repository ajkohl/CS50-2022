const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

rl.question('What is your name ? ', function (name) {
    console.log(`hello, ${name}`);
    rl.close();
});

//https://nodejs.org/en/knowledge/command-line/how-to-prompt-for-command-line-input/