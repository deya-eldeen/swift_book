
import Foundation

func _05_StringsAndCharacters()
{
    let emptyString = ""
    
    if emptyString.isEmpty{
        print("Nothing to see here")
    }
    
    for character in "Dog!🐶".characters{
        print(character)
    }
    // D
    // o
    // g
    // !
    // 🐶

    // The expressions you write inside parentheses within an interpolated string cannot contain an unescaped backslash (\), a carriage return, or a line feed. However, they can contain other string literals.
    
    /*
    A Unicode scalar is any Unicode code point in the range U+0000 to U+D7FF inclusive or U+E000 to U+10FFFF inclusive. Unicode scalars do not include the Unicode surrogate pair code points, which are the code points in the range U+D800 to U+DFFF inclusive.
    */
    
    
    
    let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
    // "Imagination is more important than knowledge" - Einstein
    let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
    let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
    let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496”
    
    let enclosedEAcute: Character = "\u{E9}\u{20DD}"
    // enclosedEAcute is é⃝
    
    //For example, if you initialize a new string with the four-character word cafe, and then append a COMBINING ACUTE ACCENT (U+0301) to the end of the string, the resulting string will still have a character count of 4, with a fourth character of é, not e:
    
    //The count of the characters returned by the characters property is not always the same as the length property of an NSString that contains the same characters. The length of an NSString is based on the number of 16-bit code units within the string’s UTF-16 representation and not the number of Unicode extended grapheme clusters within the string.”
    
    
    //Each String value has an associated index type, String.Index, which corresponds to the position of each Character in the string.
    
   // As mentioned above, different characters can require different amounts of memory to store, so in order to determine which Character is at a particular position, you must iterate over each Unicode scalar from the start or end of that String. For this reason, Swift strings cannot be indexed by integer values.”
    
    
    let greeting = "Guten Tag!"
    greeting[greeting.startIndex]
    // G
    greeting[greeting.index(before: greeting.endIndex)]
    // !
    greeting[greeting.index(after: greeting.startIndex)]
    // u
    let index = greeting.index(greeting.startIndex, offsetBy: 7)
    greeting[index]
    // a
    
    
    
    
    //Attempting to access an index outside of a string’s range or a Character at an index outside of a string’s range will trigger a runtime error.
    
    greeting[greeting.endIndex] // Error
    greeting.index(after: greeting.endIndex) // Error
    

    for index in greeting.characters.indices {
        print("\(greeting[index]) ", terminator: "")
    }
    // Prints "G u t e n   T a g !
    
    
    
    
    var welcome = "hello"

    welcome.remove(at: welcome.index(before: welcome.endIndex))
    // welcome now equals "hello there"
    
    let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
    welcome.removeSubrange(range)
    // welcome now equals "hello”
    
    
    //LATIN CAPITAL LETTER A (U+0041, or "A"), as used in English, is not equivalent to CYRILLIC CAPITAL LETTER A (U+0410, or "А"), as used in Russian. The characters are visually similar, but do not have the same linguistic meaning
    
    // .hasSuffix
    // .hasPrefix
    
    
    let dogString = "Dog‼🐶"

    for codeUnit in dogString.utf8 {
        print("\(codeUnit) ", terminator: "")
    }
    print("")
    // Prints "68 111 103 226 128 188 240 159 144 182 ”
    
    //In the example above, the first three decimal codeUnit values (68, 111, 103) represent the characters D, o, and g, whose UTF-8 representation is the same as their ASCII representation. The next three decimal codeUnit values (226, 128, 188) are a three-byte UTF-8 representation of the DOUBLE EXCLAMATION MARK character. The last four codeUnit values (240, 159, 144, 182) are a four-byte UTF-8 representation of the DOG FACE character.”
    

    
    
    for codeUnit in dogString.utf16 {
        print("\(codeUnit) ", terminator: "")
    }
    print("")
    // Prints "68 111 103 8252 55357 56374 ”
    
    
    
    
    
    for scalar in dogString.unicodeScalars {
        print("\(scalar.value) ", terminator: "")
    }
    print("")
    // Prints "68 111 103 8252 128054 ”
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
