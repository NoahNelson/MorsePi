import Glibc

let BUTTON: Int32 = 4
// Longest a press can be before it's definitely definitely a long press
let PRESSMAX = 40
// Longest a short press can be
let SHORTPRESS = 20
// The length of a pause in between words
let WORDPAUSE = 120
// The length of time the button can be unpressed before the program quits
let QUITPAUSE = 200

let morseTable = [".-": "a", "-...": "b", "-.-.": "c", "-..": "d", ".": "e",
                  "..-.": "f", "--.": "g", "....": "h", "..": "i", ".---": "j",
                  "-.-": "k", ".-..": "l", "--": "m", "-.": "n", "---": "o",
                  ".--.": "p", "--.-": "q", ".-.": "r", "...": "s", "-": "t",
                  "..-": "u", "...-": "v", ".--": "w",
                  "-..-": "x", "-.--": "y", "--..": "z"]

wiringPiSetup()

pinMode(BUTTON, INPUT)
pullUpDnControl(BUTTON, PUD_UP)

guard digitalRead(BUTTON) == HIGH else {
    print("Read failed!")
    exit(-1)
}

/**
 Waits for the button to be released, then returns the length it was pressed.

 Maxes out at PRESSMAX. It still WILL NOT RETURN until the button
 is released.
 */
func lengthOfPress() -> Int {
    var counter = 0
    while digitalRead(BUTTON) == LOW {
        if counter < PRESSMAX {
            counter += 1
        }
        delay(10)
    }
    return counter
}

/**
 Waits for the button to be pressed, then returns the length it was unpressed.

 At 20 000 000, this returns, because we're done reading input.
 */
func lengthOfUnpress() -> Int {
    var counter = 0
    while digitalRead(BUTTON) == HIGH {
        counter += 1
        if counter == QUITPAUSE {
            return QUITPAUSE
        }
        delay(10)
    }
    return counter
}


while digitalRead(BUTTON) == HIGH {
    // Wait for button press
}
// button pressed.

var unpress = 0

var words = [String]()
while true {
    // each run of this is a word
    var word = ""
    while true {
        // each run of this is a letter
        var morseLetter = ""
        while true {
            // each run of this is a dit or a dah
            var press = lengthOfPress()
            if press < SHORTPRESS {
                // short press
                morseLetter += "."
            } else {
                // long press
                morseLetter += "-"
            }
            unpress = lengthOfUnpress()
            if unpress < PRESSMAX {
                // same letter
            } else {
                // next letter, or we're done
                break
            }
        }
        // letter is done, add it to the word
        if let letter = morseTable[morseLetter] {
            word += letter
        } else {
            print("Unrecognized letter \(morseLetter)!")
        }
        if unpress >= WORDPAUSE {
            break
        }
    }
    words.append(word)
    if unpress >= QUITPAUSE {
        break
    }
}

for word in words {
    print(word)
}
