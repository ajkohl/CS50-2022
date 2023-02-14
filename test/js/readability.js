//gets user input
const readlineSync = require('readline-sync');
let inputTxt = readlineSync.question("Text: ");

function count_letters(Text) {
    letters = 0
    for (i = 0; i < Text.length; i += 1) {
        //https://bobbyhadz.com/blog/javascript-check-if-character-is-letter
        if (Text[i].toLowerCase() !== Text[i].toUpperCase()) {
            letters += 1
        }
    }
    return letters
}

//counts the number of spaces by iterating through the text and counting spaces
function count_spaces(Text) {
    spaces = 0
    for (i = 0; i < Text.length; i += 1) {
        if (Text[i] == " ") {
        spaces += 1
        }
    }
    return spaces
}

//counts amount of punctuation marks to determine sentence number
function count_punct(Text) {
    punct = 0
    for (i = 0; i < Text.length; i += 1) {
        if ((Text[i] == ".") || (Text[i] == "!") || (Text[i] == "?")) {
            punct += 1
        }
    }
    return punct
}

//calls all functions
var letterCount = count_letters(inputTxt)
var wordCount = count_spaces(inputTxt) + 1
var sentCount = count_punct(inputTxt)

var L = 100.0 * letterCount / wordCount
var S = 100.0 * sentCount / wordCount
var index = 0.0588 * L - 0.296 * S - 15.8

//converts index to grade level
if (index < 0.5) {
    console.log("Before Grade 1\n");
}
else if (index > 16.499){
    console.log("Grade 16+\n");
}
else {
    console.log("Grade " + Math.round(index));
}