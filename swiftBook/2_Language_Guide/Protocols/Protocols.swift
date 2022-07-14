
import Foundation

// [Protocols]

    //A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.

    //The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements.

    //If a class has a superclass, list the superclass name before any protocols it adopts, followed by a comma:

    //class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    //  // class definition goes here
    //}

// [Protocol Syntax]

    //The power of protocols is that they formalize the connection between different parts of your code, without providing implementations. This allows you to build rigid structures in your code, without tightly coupling your code’s components.

    // REMINDER: Instance properties are properties that belong to an instance of a particular type. Every time you create a new instance of that type, it has its own set of property values, separate from any other instance.
    // REMINDER: Type properties belong to the type itself, not to any one instance of that type.
    // REMINDER: You define type properties with the static keyword. For computed type properties for class types, you can use the class keyword instead to allow subclasses to override the superclass’s implementation.

    // If a protocol requires a property to be gettable and settable, that property requirement can’t be fulfilled by a constant stored property or a read-only computed property.
    // The protocol also specifies whether each property must be gettable or gettable and settable.
    // If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it’s valid for the property to be also settable if this is useful for your own code.
    
    // Property requirements are always declared as variable properties, prefixed with the var keyword. Gettable and settable properties are indicated by writing { get set } after their type declaration, and gettable properties are indicated by writing { get }.


// [Property Requirements]
    protocol SomeProtocol {
        var mustBeSettable: Int { get set }
        var doesNotNeedToBeSettable: Int { get }
    }

    protocol AnotherProtocol {
        static var someTypeProperty: Int { get set }
    }

    protocol FullyNamed {
        var fullName: String { get }
    }

    struct Person: FullyNamed {
        var fullName: String
    }
    let john = Person(fullName: "John Appleseed")
    // john.fullName is "John Appleseed"

    // Here’s a more complex class, which also adopts and conforms to the FullyNamed protocol:

    class Starship: FullyNamed {
        var prefix: String?
        var name: String
        init(name: String, prefix: String? = nil) {
            self.name = name
            self.prefix = prefix
        }
        var fullName: String {
            return (prefix != nil ? prefix! + " " : "") + name
        }
    }
    var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
    // ncc1701.fullName is "USS Enterprise"

// [Method Requirements]

    //Default values, however, can’t be specified for method parameters within a protocol’s definition.
    //As with type property requirements, you always prefix type method requirements with the static keyword when they’re defined in a protocol. This is true even though type method requirements are prefixed with the class or static keyword when implemented by a class:

    protocol SomeProtocol2 {
        static func someTypeMethod()
    }

    protocol RandomNumberGenerator {
        func random() -> Double
    }

    //Here’s an implementation of a class that adopts and conforms to the RandomNumberGenerator protocol. This class implements a pseudorandom number generator algorithm known as a linear congruential generator:

    class LinearCongruentialGenerator: RandomNumberGenerator {
        var lastRandom = 42.0
        let m = 139968.0
        let a = 3877.0
        let c = 29573.0
        func random() -> Double {
            lastRandom = ((lastRandom * a + c)
                .truncatingRemainder(dividingBy:m))
            return lastRandom / m
        }
    }
    let generator = LinearCongruentialGenerator()
    //print("Here's a random number: \(generator.random())")
    // Prints "Here's a random number: 0.3746499199817101"
    //print("And another one: \(generator.random())")
    // Prints "And another one: 0.729023776863283"


// [Mutating Method Requirements]
    //It’s sometimes necessary for a method to modify (or mutate) the instance it belongs to.
    protocol Togglable {
        mutating func toggle()
    }

    enum OnOffSwitch: Togglable {
        case off, on
        mutating func toggle() {
            switch self {
            case .off:
                self = .on
            case .on:
                self = .off
            }
        }
    }
    var lightSwitch = OnOffSwitch.off
    //lightSwitch.toggle()
    // lightSwitch is now equal to .on

// [Initializer Requirements]
    protocol SomeProtocol3 {
        init(someParameter: Int)
    }

// [Class Implementations of Protocol Initializer Requirements]
    //You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer. In both cases, you must mark the initializer implementation with the required modifier:

    class SomeClass33: SomeProtocol3 {
        required init(someParameter: Int) {
            // initializer implementation goes here
        }
    }

    //You don’t need to mark protocol initializer implementations with the required modifier on classes that are marked with the final modifier, because final classes can’t subclassed. For more about the final modifier, see Preventing Overrides.

    protocol SomeProtocol44 {
        init()
    }

    class SomeSuperClass44 {
        init() {
            // initializer implementation goes here
        }
    }

    class SomeSubClass: SomeSuperClass44, SomeProtocol44 {
        // "required" from SomeProtocol conformance; "override" from SomeSuperClass
        required override init() {
            // initializer implementation goes here
        }
    }

// [Failable Initializer Requirements]
    //A failable initializer requirement can be satisfied by a failable or nonfailable initializer on a conforming type. A nonfailable initializer requirement can be satisfied by a nonfailable initializer or an implicitly unwrapped failable initializer.

// [Protocols as Types]
    //you can use protocols as a fully fledged types in your code. Using a protocol as a type is sometimes called an existential type, which comes from the phrase “there exists a type T such that T conforms to the protocol”.

    //You can use a protocol in many places where other types are allowed, including:
    //As a parameter type or return type in a function, method, or initializer
    //As the type of a constant, variable, or property
    //As the type of items in an array, dictionary, or other container


    class Dice {
        let sides: Int
        let generator: RandomNumberGenerator
        init(sides: Int, generator: RandomNumberGenerator) {
            self.sides = sides
            self.generator = generator
        }
        func roll() -> Int {
            return Int(generator.random() * Double(sides)) + 1
        }
    }


    //you can downcast from a protocol type to an underlying type in the same way you can downcast from a superclass to a subclass, as discussed in Downcasting.

// [Delegation]

    //To prevent strong reference cycles, delegates are declared as weak references.

    protocol DiceGame {
        var dice: Dice { get }
        func play()
    }
    protocol DiceGameDelegate: AnyObject {
        func gameDidStart(_ game: DiceGame)
        func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
        func gameDidEnd(_ game: DiceGame)
    }

    // Marking the protocol as class-only lets the SnakesAndLadders class later in this chapter declare that its delegate must use a weak reference. A class-only protocol is marked by its inheritance from AnyObject
    class SnakesAndLadders: DiceGame {
        let finalSquare = 25
        let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
        var square = 0
        var board: [Int]
        init() {
            board = Array(repeating: 0, count: finalSquare + 1)
            board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
            board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        }
        weak var delegate: DiceGameDelegate?
        func play() {
            square = 0
            delegate?.gameDidStart(self)
            gameLoop: while square != finalSquare {
                let diceRoll = dice.roll()
                delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
                switch square + diceRoll {
                case finalSquare:
                    break gameLoop
                case let newSquare where newSquare > finalSquare:
                    continue gameLoop
                default:
                    square += diceRoll
                    square += board[square]
                }
            }
            delegate?.gameDidEnd(self)
        }
    }

    class DiceGameTracker: DiceGameDelegate {
        var numberOfTurns = 0
        func gameDidStart(_ game: DiceGame) {
            numberOfTurns = 0
            if game is SnakesAndLadders {
                print("Started a new game of Snakes and Ladders")
            }
            print("The game is using a \(game.dice.sides)-sided dice")
        }
        func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
            numberOfTurns += 1
            print("Rolled a \(diceRoll)")
        }
        func gameDidEnd(_ game: DiceGame) {
            print("The game lasted for \(numberOfTurns) turns")
        }
    }

// [Adding Protocol Conformance with an Extension]
    //You can extend an existing type to adopt and conform to a new protocol, even if you don’t have access to the source code for the existing type.

    protocol TextRepresentable {
        var textualDescription: String { get }
    }

    //This extension adopts the new protocol in exactly the same way as if Dice had provided it in its original implementation.
    extension Dice: TextRepresentable {
        var textualDescription: String {
            return "A \(sides)-sided dice"
        }
    }

    extension SnakesAndLadders: TextRepresentable {
        var textualDescription: String {
            return "A game of Snakes and Ladders with \(finalSquare) squares"
        }
    }

// [Conditionally Conforming to a Protocol]

    extension Array: TextRepresentable where Element: TextRepresentable {
        var textualDescription: String {
            let itemsAsText = self.map { $0.textualDescription }
            return "[" + itemsAsText.joined(separator: ", ") + "]"
        }
    }
    let d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
    let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())

    let myDice = [d6, d12]


// [Declaring Protocol Adoption with an Extension]

    //If a type already conforms to all of the requirements of a protocol, but hasn’t yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension:

    struct Hamster {
        var name: String
        var textualDescription: String {
            return "A hamster named \(name)"
        }
    }
    extension Hamster: TextRepresentable {}
    //Instances of Hamster can now be used wherever TextRepresentable is the required type:

    let simonTheHamster = Hamster(name: "Simon")
    let somethingTextRepresentable: TextRepresentable = simonTheHamster
    //print(somethingTextRepresentable.textualDescription)
    // Prints "A hamster named Simon"


// [Adopting a Protocol Using a Synthesized Implementation]

    //Swift provides a synthesized implementation of Equatable for the following kinds of custom types:

    //Structures that have only stored properties that conform to the Equatable protocol
    //Enumerations that have only associated types that conform to the Equatable protocol
    //Enumerations that have no associated types

    //Swift provides a synthesized implementation of Hashable for the following kinds of custom types:
                                                                        
    //Structures that have only stored properties that conform to the Hashable protocol
    //Enumerations that have only associated types that conform to the Hashable protocol
    //Enumerations that have no associated types

    //The example below defines a SkillLevel enumeration with cases for beginners, intermediates, and experts. Experts are additionally ranked by the number of stars they have.

    enum SkillLevel: Comparable {
        case beginner
        case intermediate
        case expert(stars: Int)
    }
    var levels = [SkillLevel.intermediate, SkillLevel.beginner,
                  SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
    //for level in levels.sorted() {
    //    print(level)
    //}

    // Prints "beginner"
    // Prints "intermediate"
    // Prints "expert(stars: 3)"
    // Prints "expert(stars: 5)"

// [Collections of Protocol Types]
    //let things: [TextRepresentable] = [game, d12, simonTheHamster]
    //
    //for thing in things {
    //    print(thing.textualDescription)
    //}
    // A game of Snakes and Ladders with 25 squares
    // A 12-sided dice
    // A hamster named Simon


// [Protocol Inheritance]
    protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
        // protocol definition goes here
    }

    protocol PrettyTextRepresentable: TextRepresentable {
        var prettyTextualDescription: String { get }
    }

// [Class-Only Protocols]

    //    protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
    //        // class-only protocol definition goes here
    //    }

// [Protocol Composition]

    protocol Named {
        var name: String { get }
    }
    protocol Aged {
        var age: Int { get }
    }
    struct Person33: Named, Aged {
        var name: String
        var age: Int
    }
    func wishHappyBirthday(to celebrator: Named & Aged) {
        print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
    }
    //let birthdayPerson = Person33(name: "Malcolm", age: 21)
    //wishHappyBirthday(to: birthdayPerson)
    // Prints "Happy birthday, Malcolm, you're 21!"

    //Protocol compositions have the form SomeProtocol & AnotherProtocol. You can list as many protocols as you need, separating them with ampersands (&). In addition to its list of protocols, a protocol composition can also contain one class type, which you can use to specify a required superclass.

// [Checking for Protocol Conformance]

    //The is operator returns true if an instance conforms to a protocol and returns false if it doesn’t.
    //The as? version of the downcast operator returns an optional value of the protocol’s type, and this value is nil if the instance doesn’t conform to that protocol.
    //The as! version of the downcast operator forces the downcast to the protocol type and triggers a runtime error if the downcast doesn’t succeed.

// [Optional Protocol Requirements]

    // You can define optional requirements for protocols.
    // These requirements don’t have to be implemented by types that conform to the protocol.
    // Optional requirements are prefixed by the optional modifier as part of the protocol’s definition.

// ⭐️ To Be Revised !

// [Protocol Extensions]


    extension RandomNumberGenerator {
        func randomBool() -> Bool {
            return random() > 0.5
        }
    }

    //let generator = LinearCongruentialGenerator()
    //print("Here's a random number: \(generator.random())")
    // Prints "Here's a random number: 0.3746499199817101"
    //print("And here's a random Boolean: \(generator.randomBool())")
    // Prints "And here's a random Boolean: true"

    //Protocol extensions can add implementations to conforming types but can’t make a protocol extend or inherit from another protocol. Protocol inheritance is always specified in the protocol declaration itself.





// [Providing Default Implementations]

    //Protocol requirements with default implementations provided by extensions are distinct from optional protocol requirements. Although conforming types don’t have to provide their own implementation of either, requirements with default implementations can be called without optional chaining.

    //For example, the PrettyTextRepresentable protocol, which inherits the TextRepresentable protocol can provide a default implementation of its required prettyTextualDescription property to simply return the result of accessing the textualDescription property:

    protocol PrettyTextRepresentable33: TextRepresentable {
        var prettyTextualDescription: String { get }
    }

    extension PrettyTextRepresentable33  {
        var prettyTextualDescription: String {
            return textualDescription
        }
    }

// [Adding Constraints to Protocol Extensions]

    //When you define a protocol extension, you can specify constraints that conforming types must satisfy before the methods and properties of the extension are available. You write these constraints after the name of the protocol you’re extending by writing a generic where clause. For more about generic where clauses, see Generic Where Clauses.

    extension Collection where Element: Equatable {
        func allEqual() -> Bool {
            for element in self {
                if element != self.first {
                    return false
                }
            }
            return true
        }
    }

    let equalNumbers = [100, 100, 100, 100, 100]
    let differentNumbers = [100, 100, 200, 100, 200]

    //Because arrays conform to Collection and integers conform to Equatable, equalNumbers and differentNumbers can use the allEqual() method:

    //print(equalNumbers.allEqual())
    // Prints "true"
    //print(differentNumbers.allEqual())
    // Prints "false"

    //If a conforming type satisfies the requirements for multiple constrained extensions that provide implementations for the same method or property, Swift uses the implementation corresponding to the most specialized constraints.



