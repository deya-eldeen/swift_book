
import Foundation

// Structures and classes

// [Structures and Classes]
    //Structures and classes are general-purpose, flexible constructs that become the building blocks of your program’s code.
    //You define properties and methods to add functionality to your structures and classes using the same syntax you use to define constants, variables, and functions.
    //An instance of a class is traditionally known as an object. However, Swift structures and classes are much closer in functionality than in other languages,
    //and much of this chapter describes functionality that applies to instances of either a class or a structure type. Because of this, the more general term instance is used.

// [Comparing Structures and Classes]
    //Classes have additional capabilities that structures don’t have:
    //1- Inheritance enables one class to inherit the characteristics of another.
    //2- Type casting enables you to check and interpret the type of a class instance at runtime.
    //3- Deinitializers enable an instance of a class to free up any resources it has assigned.
    //4- Reference counting allows more than one reference to a class instance.
    
    // ** The additional capabilities that classes support come at the cost of increased complexity.
    // ** Classes and actors share many of the same characteristics and behaviors. For information about actors, see Concurrency.

// [Definition Syntax]
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

// [Structure and Class Instances]
    //The Resolution structure definition and the VideoMode class definition only describe what a Resolution or VideoMode will look like.
    //They themselves don’t describe a specific resolution or video mode. To do that, you need to create an instance of the structure or class.

    //The simplest form of initializer syntax uses the type name of the class or structure followed by empty parentheses,
    //such as Resolution() or VideoMode(). This creates a new instance of the class or structure,
    //with any properties initialized to their default values. Class and structure initialization is described in more detail in Initialization.

// [Accessing Properties]
    //You can drill down into subproperties, such as the width property in the resolution property of a VideoMode:

// [Memberwise Initializers for Structure Types]
    //let vga = Resolution(width: 640, height: 480)
    //Unlike structures, class instances don’t receive a default memberwise initializer.

// [Structures and Enumerations Are Value Types]
    //A value type is a type whose value is copied when it’s assigned to a variable or constant, or when it’s passed to a function.

    //You’ve actually been using value types extensively throughout the previous chapters.
    //In fact, all of the basic types in Swift—integers, floating-point numbers, Booleans, strings, arrays and dictionaries—are value types,
    //and are implemented as structures behind the scenes.

    let hd = Resolution(width: 1920, height: 1080)
    var cinema = hd

    //It then declares a variable called cinema and sets it to the current value of hd. Because Resolution is a structure,
    //a copy of the existing instance is made, and this new copy is assigned to cinema. Even though hd and cinema now have the same width and height,
    //they’re two completely different instances behind the scenes.

    enum CompassPoint {
        case north, south, east, west
        mutating func turnNorth() {
            self = .north
        }
    }
    var currentDirection = CompassPoint.west
    let rememberedDirection = currentDirection
    //currentDirection.turnNorth()

    //print("The current direction is \(currentDirection)")
    //print("The remembered direction is \(rememberedDirection)")
    // Prints "The current direction is north"
    // Prints "The remembered direction is west"

    //When rememberedDirection is assigned the value of currentDirection, it’s actually set to a copy of that value. Changing the value of currentDirection thereafter doesn’t affect the copy of the original value that was stored in rememberedDirection.



// [Classes Are Reference Types]
    //reference types are not copied when they’re assigned to a variable or constant,
    //    let tenEighty = VideoMode()
    //    tenEighty.resolution = hd
    //    tenEighty.interlaced = true
    //    tenEighty.name = "1080i"
    //    tenEighty.frameRate = 25.0

    //Note that tenEighty and alsoTenEighty are declared as constants, rather than variables.
    //However, you can still change tenEighty.frameRate and alsoTenEighty.frameRate because the values of the tenEighty and alsoTenEighty constants themselves don’t actually change.
    //tenEighty and alsoTenEighty themselves don’t “store” the VideoMode instance—instead, they both refer to a VideoMode instance behind the scenes.
    //It’s the frameRate property of the underlying VideoMode that’s changed, not the values of the constant references to that VideoMode.

// [Identity Operators]
    //Because classes are reference types, it’s possible for multiple constants and variables to refer to the same single instance of a class behind the scenes. (The same isn’t true for structures and enumerations, because they’re always copied when they’re assigned to a constant or variable, or passed to a function.)

    //Identical to (===)
    //Not identical to (!==)

// [Pointers]
    //If you have experience with C, C++, or Objective-C, you may know that these languages use pointers to refer to addresses in memory.
    //A Swift constant or variable that refers to an instance of some reference type is similar to a pointer in C, but isn’t a direct pointer to an address in memory,
    //and doesn’t require you to write an asterisk (*) to indicate that you are creating a reference.
    //Instead, these references are defined like any other constant or variable in Swift.
    //The standard library provides pointer and buffer types that you can use if you need to interact with pointers directly—see Manual Memory Management.
