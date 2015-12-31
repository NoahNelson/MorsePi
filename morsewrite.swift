let LED: Int32 = 0

let morseTable: [Character: String] = ["e": ".", "t": "-", "m": "--",
                  "n": "-.", "a": ".-",
                  "i": "..", "o": "---", "g": "--.", "k": "-.-", "d": "-..",
                  "w": ".--", "r": ".-.", "u": "..-", "s": "...",
                  "q": "--.-", "z": "--..", "y": "-.--", "c": "-.-.",
                  "x": "-..-", "b": "-...", "j": ".---", "p": ".--.",
                  "l": ".-..", "f": "..-.", "v": "...-", "h": "...."]

wiringPiSetup()

pinMode(LED, OUTPUT)

digitalWrite(LED, LOW)

let words = Process.arguments[1..<Process.arguments.count]
for word in words {
    for character in word.characters {
        if let morseChar = morseTable[character] {
            for symbol in morseChar.characters {
                digitalWrite(LED, HIGH)
                let ticks: UInt32 = (symbol == "." ? 100 : 300)
                delay(ticks)
                digitalWrite(LED, LOW)
                delay(100)
            }
        } else {
            print("Untranslatable character \(character)")
        }
        delay(300)
    }
    delay(700)
}
