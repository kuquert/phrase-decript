import Foundation

protocol CustomDecodable {
    func decode(input: String) -> String
}

struct AsciiCode: CustomDecodable {
    func decode(input: String) -> String {
        let sanitizedInputArray = input
            .split(separator: "\n")
            .joined(separator: " ")
            .map { String($0) }
            .reduce("") { $0 + $1 }
            .split(separator: " ")
            .map { String($0) }
        
        let decodedCharacter = sanitizedInputArray
            .compactMap { Int($0, radix: 16) }
            .compactMap { UnicodeScalar($0) }
            .map { Character($0) }
        
        return decodedChars
            .map { String($0) }
            .reduce("") { $0 + $1 }
    }
}


struct MorseCode: CustomDecodable {
    private let morseKeyToCharValue = [ ".-" : "A", "-..." : "B", "-.-." : "C", "-.." : "D", "." : "E", "..-." : "F", "--." : "G", "...." : "H", ".." : "I", ".---" : "J", "-.-" : "K", ".-.." : "L", "--" : "M", "-." : "N", "---" : "O", ".--." : "P", "--.-" : "Q", ".-." : "R", "..." : "S", "-" : "T", "..-" : "U", "...-" : "V", ".--" : "W", "-..-" : "X", "-.--" : "Y", "--.." : "Z", ".----" : "1", "..---" : "2", "...--" : "3", "....-" : "4", "....." : "5", "-...." : "6", "--..." : "7", "---.." : "8", "----." : "9", "-----" : "0", "--..--" : "", ".-.-.-" : ".", "..--.." : "?", "-..-." : "/", "-....-" : "-", "-.--." : "(",
                                        "-.--.-" : ")"
    ]
    
    func decode(input: String) -> String {
        return input
            .split(separator: " ")
            .compactMap { morseKeyToCharValue[String($0)] }
            .reduce("") { $0 + $1 }
    }
}

let morseInput = "-.-. --- -.. .. --. --- -- --- .-. ... . . .... ..-. .- -.-. .. .-.. -.. . .-. . -.-. --- -. .... . -.-. . .-."

print(MorseCode().decode(input: morseInput))

let asciiInput = """
41 53 43 49 49 20 63 6f 64 65 20 69 73 20 6f 6c 64 2c 20 62
75 74 20 73 74 69 6c 6c 20 77 69 64 65 6c 79 20 75 73 65 64
2e 20 48 6f 77 65 76 65 72 2c 20 74 68 65 20 6e 65 78 74 20
74 77 6f 20 70 68 72 61 73 65 73 20 61 72 65 20 6f 6c 64 65
72 20 74 68 61 6e 20 41 53 43 49 49 21
"""

print(AsciiCode().decode(input: asciiInput))
