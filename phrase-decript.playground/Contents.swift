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
        
        let decodedCharacters = sanitizedInputArray
            .compactMap { Int($0, radix: 16) }
            .compactMap { UnicodeScalar($0) }
            .map { Character($0) }
        
        return decodedCharacters
            .map { String($0) }
            .reduce("") { $0 + $1 }
    }
}

struct EBCDICCode: CustomDecodable {
    let ebcdicKeysToAsciiValues = ["00":"00","01":"01","02":"02","03":"03","04":"1A","05":"09","06":"1A","07":"7F","08":"1A","09":"1A","0A":"1A","0B":"0B","0C":"0C","0D":"0D","0E":"0E","0F":"0F","10":"10","11":"11","12":"12","13":"13","14":"1A","15":"1A","16":"08","17":"1A","18":"18","19":"19","1A":"1A","1B":"1A","1C":"1C","1D":"1D","1E":"1E","1F":"1F","20":"1A","21":"1A","22":"1A","23":"1A","24":"1A","25":"0A","26":"17","27":"1B","28":"1A","29":"1A","2A":"1A","2B":"1A","2C":"1A","2D":"05","2E":"06","2F":"07","30":"1A","31":"1A","32":"16","33":"1A","34":"1A","35":"1A","36":"1A","37":"04","38":"1A","39":"1A","3A":"1A","3B":"1A","3C":"14","3D":"15","3E":"1A","3F":"1A","40":"20","41":"1A","42":"1A","43":"1A","44":"1A","45":"1A","46":"1A","47":"1A","48":"1A","49":"1A","4A":"5B","4B":"2E","4C":"3C","4D":"28","4E":"2B","4F":"21","50":"26","51":"1A","52":"1A","53":"1A","54":"1A","55":"1A","56":"1A","57":"1A","58":"1A","59":"1A","5A":"5D","5B":"24","5C":"2A","5D":"29","5E":"3B","5F":"5E","60":"2D","61":"1A","62":"1A","63":"1A","64":"1A","65":"1A","66":"1A","67":"1A","68":"1A","69":"1A","6A":"7C","6B":"2C","6C":"25","6D":"5F","6E":"3E","6F":"3F","70":"1A","71":"1A","72":"1A","73":"1A","74":"1A","75":"1A","76":"1A","77":"1A","78":"1A","79":"60","7A":"3A","7B":"23","7C":"40","7D":"27","7E":"3D","7F":"22","80":"1A","81":"61","82":"62","83":"63","84":"64","85":"65","86":"66","87":"67","88":"68","89":"69","8A":"1A","8B":"1A","8C":"1A","8D":"1A","8E":"1A","8F":"1A","90":"1A","91":"6A","92":"6B","93":"6C","94":"6D","95":"6E","96":"6F","97":"70","98":"71","99":"72","9A":"1A","9B":"1A","9C":"1A","9D":"1A","9E":"1A","9F":"1A","A0":"1A","A1":"7E","A2":"73","A3":"74","A4":"75","A5":"76","A6":"77","A7":"78","A8":"79","A9":"7A","AA":"1A","AB":"1A","AC":"1A","AD":"1A","AE":"1A","AF":"1A","B0":"1A","B1":"1A","B2":"1A","B3":"1A","B4":"1A","B5":"1A","B6":"1A","B7":"1A","B8":"1A","B9":"1A","BA":"1A","BB":"1A","BC":"1A","BD":"1A","BE":"1A","BF":"1A","C0":"7B","C1":"41","C2":"42","C3":"43","C4":"44","C5":"45","C6":"46","C7":"47","C8":"48","C9":"49","CA":"1A","CB":"1A","CC":"1A","CD":"1A","CE":"1A","CF":"1A","D0":"7D","D1":"4A","D2":"4B","D3":"4C","D4":"4D","D5":"4E","D6":"4F","D7":"50","D8":"51","D9":"52","DA":"1A","DB":"1A","DC":"1A","DD":"1A","DE":"1A","DF":"1A","E0":"5C","E1":"1A","E2":"53","E3":"54","E4":"55","E5":"56","E6":"57","E7":"58","E8":"59","E9":"5A","EA":"1A","EB":"1A","EC":"1A","ED":"1A","EE":"1A","EF":"1A","F0":"30","F1":"31","F2":"32","F3":"33","F4":"34","F5":"35","F6":"36","F7":"37","F8":"38","F9":"39","FA":"1A","FB":"1A","FC":"1A","FD":"1A","FE":"1A","FF":"1A"]
    
    func decode(input: String) -> String {
        let sanitizedInputArray = input
            .split(separator: "\n")
            .joined(separator: " ")
            .map { String($0) }
            .reduce("") { $0 + $1 }
            .split(separator: " ")
            .map { String($0) }
        
        let decodedCharacters = sanitizedInputArray
        .compactMap { ebcdicKeysToAsciiValues[String($0)] }
        .compactMap { Int($0, radix: 16) }
        .compactMap { UnicodeScalar($0) }
            .map { Character($0) }
        
        return decodedCharacters
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
print("Primeira frase:")
print(MorseCode().decode(input: morseInput))
print()

/**
 Segunda frase
 41 53 43 49 49 20 63 6f 64 65 20 69 73 20 6f 6c 64 2c 20 62
 75 74 20 73 74 69 6c 6c 20 77 69 64 65 6c 79 20 75 73 65 64
 2e 20 48 6f 77 65 76 65 72 2c 20 74 68 65 20 6e 65 78 74 20
 74 77 6f 20 70 68 72 61 73 65 73 20 61 72 65 20 6f 6c 64 65
 72 20 74 68 61 6e 20 41 53 43 49 49 21
 */

let asciiInput =  """
41 53 43 49 49 20 63 6f 64 65 20 69 73 20 6f 6c 64 2c 20 62
75 74 20 73 74 69 6c 6c 20 77 69 64 65 6c 79 20 75 73 65 64
2e 20 48 6f 77 65 76 65 72 2c 20 74 68 65 20 6e 65 78 74 20
74 77 6f 20 70 68 72 61 73 65 73 20 61 72 65 20 6f 6c 64 65
72 20 74 68 61 6e 20 41 53 43 49 49 21
"""
print("Segunda frase:")
print(AsciiCode().decode(input: asciiInput))
print()
/**
 Terceira frase
 C5 C2 C3 C4 C9 C3 40 89 A2 40 81 A2 40 96 93 84 40 81 A2 40
 C1 E2 C3 C9 C9 6B 40 82 A4 A3 40 89 A3 40 89 A2 40 81 93 94
 96 A2 A3 40 85 A7 A3 89 95 83 A3 4B
 */

let abcdicInput = """
C5 C2 C3 C4 C9 C3 40 89 A2 40 81 A2 40 96 93 84 40 81 A2 40
C1 E2 C3 C9 C9 6B 40 82 A4 A3 40 89 A3 40 89 A2 40 81 93 94
96 A2 A3 40 85 A7 A3 89 95 83 A3 4B
"""
print("Terceira frase:")
print(EBCDICCode().decode(input: abcdicInput))
print()
/**
 Decima frase (ok, imagem)
 QR Code
 content:
 Identify and read QR code is easy, but now you must decode this: 43 6f 64 65 73 20 77 69 74 68 6f 75 74 20 61 20 73 65 63 72 65 74 20 6b 65 79 20 63 61 6e 20 62 65 20 65 61 73 69 6c 79 20 64 65 63 6f 64 65 64 20 69 66 20 79 6f 75 20 6b 6e 6f 77 20 74 68 65 20 65 6e 63 6f 64 69 6e 67 20 70 72 6f 63 65 73 73 2e
 
 decoded:
 "Codes without a secret key can be easily decoded if you know the encoding process."
*/
let qrInput = """
43 6f 64 65 73 20 77 69 74 68 6f 75 74 20 61 20 73 65 63 72 65 74 20 6b 65 79 20 63 61 6e 20 62 65 20 65 61 73 69 6c 79 20 64 65 63 6f 64 65 64 20 69 66 20 79 6f 75 20 6b 6e 6f 77 20 74 68 65 20 65 6e 63 6f 64 69 6e 67 20 70 72 6f 63 65 73 73 2e
"""
print("Decima frase (ok, imagem):")
print(AsciiCode().decode(input: qrInput))
print()
