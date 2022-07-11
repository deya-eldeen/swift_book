
import Foundation

func _13_Methods() {
    
    // Methods are functions that are associated with a particular type. Classes, structures, and enumerations can all define instance methods,
    // which encapsulate specific tasks and functionality for working with an instance of a given type. Classes, structures,
    // and enumerations can also define type methods, which are associated with the type itself. Type methods are similar to class methods in Objective-C.
    
    // The fact that structures and enumerations can define methods in Swift is a major difference from C and Objective-C.
    // In Objective-C, classes are the only types that can define methods. In Swift, you can choose whether to define a class,
    // structure, or enumeration, and still have the flexibility to define methods on the type you create.

    // In practice, you don’t need to write self in your code very often. If you don’t explicitly write self,
    // Swift assumes that you are referring to a property or method of the current instance whenever you use a known property or method name within a method.
    // This assumption is demonstrated by the use of count (rather than self.count) inside the three instance methods for Counter.

    // The main exception to this rule occurs when a parameter name for an instance method has the same name as a property of that instance.
    // In this situation, the parameter name takes precedence, and it becomes necessary to refer to the property in a more qualified way.
    // You use the self property to distinguish between the parameter name and the property name.
                                                                                                                                                                                                                                                                                                                                                                                        
    // ------------
    // Modifying Value Types from Within Instance Methods
    // ------------
    
    // Structures and enumerations are value types. By default, the properties of a value type can’t be modified from within its instance methods.

    struct Point {
        var x = 0.0, y = 0.0
        mutating func moveBy(x deltaX: Double, y deltaY: Double) {
            x += deltaX
            y += deltaY
        }
    }
    
    var somePoint = Point(x: 1.0, y: 1.0)
    somePoint.moveBy(x: 2.0, y: 3.0)
    print("The point is now at (\(somePoint.x), \(somePoint.y))")
    
    // Note that you can’t call a mutating method on a constant of structure type, because its properties can’t be changed,
    // even if they’re variable properties, as described in Stored Properties of Constant Structure Instances:
    

    let fixedPoint = Point(x: 3.0, y: 3.0)
    //fixedPoint.moveBy(x: 2.0, y: 3.0)
    // this will report an error: Cannot use mutating member on immutable value: 'fixedPoint' is a 'let' constant
    
    
    
    // Mutating methods can assign an entirely new instance to the implicit self property.
    // The Point example shown above could have been written in the following way instead:
    
    struct Point2 {
        var x = 0.0, y = 0.0
        mutating func moveBy(x deltaX: Double, y deltaY: Double) {
            self = Point2(x: x + deltaX, y: y + deltaY)
        }
    }
    
    // Mutating methods for enumerations can set the implicit self parameter to be a different case from the same enumeration:

    enum TriStateSwitch {
        case off, low, high
        mutating func next() {
            switch self {
            case .off:
                self = .low
            case .low:
                self = .high
            case .high:
                self = .off
            }
        }
    }
    var ovenLight = TriStateSwitch.low
    ovenLight.next()
    // ovenLight is now equal to .high
    ovenLight.next()
    // ovenLight is now equal to .off
    
    // ------------
    // Type Methods
    // ------------
    
    // Instance methods, as described above, are methods that you call on an instance of a particular type.
    // You can also define methods that are called on the type itself. These kinds of methods are called type methods.
    // You indicate type methods by writing the static keyword before the method’s func keyword. Classes can use the class keyword instead,
    // to allow subclasses to override the superclass’s implementation of that method.

    // In Objective-C, you can define type-level methods only for Objective-C classes.
    // In Swift, you can define type-level methods for all classes, structures, and enumerations. Each type method is explicitly scoped to the type it supports.

    class SomeClass {
        class func someTypeMethod() {
            // type method implementation goes here
        }
    }
    SomeClass.someTypeMethod()

    //Within the body of a type method, the implicit self property refers to the type itself, rather than an instance of that type.
    // This means that you can use self to disambiguate between type properties and type method parameters, just as you do for instance properties and instance method parameters.
    

    
    // discardableResult
    // Apply this attribute to a function or method declaration to suppress the compiler warning when the function or method that returns a value is called without using its result.
    
    struct LevelTracker {
        static var highestUnlockedLevel = 1
        var currentLevel = 1

        static func unlock(_ level: Int) {
            if level > highestUnlockedLevel { highestUnlockedLevel = level }
        }

        static func isUnlocked(_ level: Int) -> Bool {
            return level <= highestUnlockedLevel
        }

        @discardableResult
        mutating func advance(to level: Int) -> Bool {
            if LevelTracker.isUnlocked(level) {
                currentLevel = level
                return true
            } else {
                return false
            }
        }
    }
    
    // (Note that these type methods can access the highestUnlockedLevel type property without your needing to write it as LevelTracker.highestUnlockedLevel.)
    
    class Player {
        var tracker = LevelTracker()
        let playerName: String
        func complete(level: Int) {
            LevelTracker.unlock(level + 1)
            tracker.advance(to: level + 1)
        }
        init(name: String) {
            playerName = name
        }
    }
    
    
    var player = Player(name: "Argyrios")
    player.complete(level: 1)
    print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
    // Prints "highest unlocked level is now 2"
    
    player = Player(name: "Beto")
    if player.tracker.advance(to: 6) {
        print("player is now on level 6")
    } else {
        print("level 6 hasn't yet been unlocked")
    }
    // Prints "level 6 hasn't yet been unlocked"
    
    
    
}
