
import Foundation

func _23_Extensions()
{
    
    // [Extensions]
    // Extensions in Swift can:
    // Add computed instance properties and computed type properties
    // Define instance methods and type methods
    // Provide new initializers
    // Define subscripts
    // Define and use new nested types
    // Make an existing type conform to a protocol
    // Extensions can add new functionality to a type, but they can’t override existing functionality.

    // [Extension Syntax]

//    extension SomeType: SomeProtocol, AnotherProtocol {
//        // implementation of protocol requirements goes here
//    }
    
    //If you define an extension to add new functionality to an existing type, the new functionality will be available on all existing instances of that type, even if they were created before the extension was defined.
    
    let oneInch = 25.4.mm
    print("One inch is \(oneInch) meters")
    // Prints "One inch is 0.0254 meters"
    let threeFeet = 3.ft
    print("Three feet is \(threeFeet) meters")
    // Prints "Three feet is 0.914399970739201 meters"

    
    // [Initializers]
    
    //Extensions can add new convenience initializers to a class, but they can’t add new designated initializers or deinitializers to a class.
    //Designated initializers and deinitializers must always be provided by the original class implementation.
    
    let defaultRect = Rect33()
    let memberwiseRect = Rect33(origin: Point(x: 2.0, y: 2.0),
       size: Size(width: 5.0, height: 5.0))
    
    let centerRect = Rect33(center: Point(x: 4.0, y: 4.0),
                          size: Size(width: 3.0, height: 3.0))
    // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
    
    // If you provide a new initializer with an extension, you are still responsible for making sure that each instance is fully initialized once the initializer completes.
    
    3.repetitions {
        print("Hello!")
    }
    // Hello!
    // Hello!
    // Hello!

    var someInt = 3
    someInt.square()
    // someInt is now 9
    
    746381295[0]
    // returns 5
    746381295[1]
    // returns 9
    746381295[2]
    // returns 2
    746381295[8]
    // returns 7

    //If the Int value doesn’t have enough digits for the requested index, the subscript implementation returns 0, as if the number had been padded with zeros to the left:

    746381295[9]
    // returns 0, as if you had requested:
    0746381295[9]

    func printIntegerKinds(_ numbers: [Int]) {
        for number in numbers {
            switch number.kind {
            case .negative:
                print("- ", terminator: "")
            case .zero:
                print("0 ", terminator: "")
            case .positive:
                print("+ ", terminator: "")
            }
        }
        print("")
    }
    printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
    // Prints "+ + - 0 - 0 + "

}

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect33 {
    var origin = Point()
    var size = Size()
}

extension Rect33 {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

// [Computed Properties]
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}


// [Methods]
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

extension Int {
    mutating func square() {
        self = self * self
    }
}

// [Subscripts]
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

// [Nested Types]
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}




