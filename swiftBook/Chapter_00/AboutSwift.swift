import Foundation

func AboutSwift() {

//    swift is a safe, fast, and interactive programming language that combines the best in modern language thinking
//    Swift is friendly to new programmers. It’s an industrial-quality programming language that’s as expressive and enjoyable as a scripting language.
//    Swift defines away large classes of common programming errors by adopting modern programming patterns:
//    Variables are always initialized before use.
//    Array indices are checked for out-of-bounds errors.
//    Integers are checked for overflow.
//    Optionals ensure that nil values are handled explicitly.
//    Memory is managed automatically.
//    Error handling allows controlled recovery from unexpected failures.

//    Its combination of safety and speed make Swift an excellent choice for everything from “Hello, world!” to an entire operating system.
//    Swift combines powerful type inference and pattern matching
//    Swift has been years in the making, and it continues to evolve with new features and capabilities.

//    Swift is a new programming language for iOS, macOS, watchOS, and tvOS apps that builds on the best of C and Objective-C,
//    without the constraints of C compatibility.
     
//     Swift adopts safe programming patterns and adds modern features to make programming easier, more flexible, and more fun.
//     Objective-C itself has evolved to support blocks, collection literals, and modules,

    //  Objective-C is verbose
    
    //Swift is a multi-paradigm language.
    
    //Speaking in terms of computer science, Swift is both a 🔵 (type-safe) and 🔵 (memory-safe) language.
    //By definition, type safety means that the programming language itself 🔵 discourages or 🔵 prevents type errors.
    //At the same time, type memory safety aims to avoid vulnerabilities dealing with
    //🔵 buffer overflows, 🔵 dangling pointers, 🔵 uninitialised pointers, and more.
    
//    Optional types
//    Definitive initialization
//    Arrays bounds checking
//    Arithmetic overflow checking
    
    //Swift has safe arithmetic operators (&+, &-, &*)
    //for such cases. These operators will silently discard all overflows,
    //which could be especially useful if you want to truncate bits that don’t fit the current type without throwing error.
    
    //The overflow addition operator (&+) discards any bits that overflow the fixed width of the integer type. In the following example, the sum of 100 and 121 is greater than the maximum representable Int8 value, so the result is the partial value after discarding the overflowing bits.
    //let x: Int8 = 10 &+ 21
    //// x == 31
    //let y: Int8 = 100 &+ 121
    // y == -35 (after overflow)

//
//     Swift feels familiar to Objective-C developers.
//     It adopts the readability of Objective-C’s named parameters and the power of Objective-C’s dynamic object model.
//     It provides seamless access to existing Cocoa frameworks and mix-and-match interoperability with Objective-C code.
//     Building from this common ground, Swift introduces many new features and unifies the procedural and object-oriented portions of the language.

    // keep in mind
    // A Swift class must be a descendant of an Objective-C class to be accessible and usable in Objective-C.
    // This is to say that classes with Swift-only features such as tuples, generics, etc. will not be compatible with Objective-C.

    
//     📘
//     Objective C dynamic type
//     A variable is dynamically typed when the type of the object it points to is not checked at compile time. Objective-C uses the id data type to represent a variable that is an object without specifying what sort of object it is. This is referred to as dynamic typing.
//
//
//     Swift is friendly to new programmers. It is the first industrial-quality systems programming language that is as expressive and enjoyable as a scripting language.
    
    //There are three kinds: ones compiled to native machine instructions, ones compiled to portable bytecode, and ones which are interpreted directly from the source code at run time.
    
   // ⁉️: why in swift book, they call it a scripting language ?
    
//     It supports playgrounds, an innovative feature that allows programmers to experiment with Swift code and see the results immediately,
//     without the overhead of building and running an app.

}




