
import Foundation

func _16_Initialization()
{
    //Initialization is the process of preparing an instance of a class, structure, or enumeration for use.
    //This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that’s required before the new instance is ready for use.
    
    //You implement this initialization process by defining initializers, which are like special methods that can be called to create a new instance of a particular type.
    //Unlike Objective-C initializers, Swift initializers don’t return a value. Their primary role is to ensure that new instances of a type are correctly initialized before they’re used for the first time.
    
    
    struct Fahrenheit {
        var temperature: Double
        init() {
            temperature = 32.0
        }
    }
    var f = Fahrenheit()
    print("The default temperature is \(f.temperature)° Fahrenheit")
    // Prints "The default temperature is 32.0° Fahrenheit"
    
    struct Fahrenheit2 {
        var temperature = 32.0
    }

    struct Celsius {
        var temperatureInCelsius: Double
        init(fromFahrenheit fahrenheit: Double) {
            temperatureInCelsius = (fahrenheit - 32.0) / 1.8
        }
        init(fromKelvin kelvin: Double) {
            temperatureInCelsius = kelvin - 273.15
        }
    }
    let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
    // boilingPointOfWater.temperatureInCelsius is 100.0
    let freezingPointOfWater = Celsius(fromKelvin: 273.15)
    // freezingPointOfWater.temperatureInCelsius is 0.0
    
    
    
    
    
    class SurveyQuestion {
        var text: String
        var response: String?
        init(text: String) {
            self.text = text
        }
        func ask() {
            print(text)
        }
    }
    let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
    cheeseQuestion.ask()
    // Prints "Do you like cheese?"
    cheeseQuestion.response = "Yes, I do like cheese."
    
    
    // For class instances, a constant property can be modified during initialization only by the class that introduces it. It can’t be modified by a subclass.
    
    // [Default Initializers]
    
    class ShoppingListItem {
        var name: String?
        var quantity = 1
        var purchased = false
    }
    var item = ShoppingListItem()
    
    //Because all properties of the ShoppingListItem class have default values, and because it’s a base class with no superclass
    
    
    // [Memberwise Initializers for Structure Types]
    
    //Structure types automatically receive a memberwise initializer if they don’t define any of their own custom initializers.
    //The memberwise initializer is a shorthand way to initialize the member properties of new structure instances. Initial values for the properties of the new instance can be passed to the memberwise initializer by name.

    struct Size {
        var width = 0.0, height = 0.0
    }
    let twoByTwo = Size(width: 2.0, height: 2.0)
    
    
    let zeroByTwo = Size(height: 2.0)
    print(zeroByTwo.width, zeroByTwo.height)
    // Prints "0.0 2.0"

    let zeroByZero = Size()
    print(zeroByZero.width, zeroByZero.height)
    // Prints "0.0 0.0"

    // [Initializer Delegation for Value Types]
    
    struct Point {
        var x = 0.0, y = 0.0
    }
    
    struct Rect {
        var origin = Point()
        var size = Size()
        init() {}
        init(origin: Point, size: Size) {
            self.origin = origin
            self.size = size
        }
        init(center: Point, size: Size) {
            let originX = center.x - (size.width / 2)
            let originY = center.y - (size.height / 2)
            self.init(origin: Point(x: originX, y: originY), size: size)
        }
    }

    //The init(center:size:) initializer could have assigned the new values of origin and size to the appropriate properties itself. However, it’s more convenient (and clearer in intent) for the init(center:size:) initializer to take advantage of an existing initializer that already provides exactly that functionality.
    
    // [Class Inheritance and Initialization]
    
    // All of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization.
    // Swift defines two kinds of initializers for class types to help ensure all stored properties receive an initial value.
    // These are known as
    // 1- designated initializers
    // 2- and convenience initializers.
    
    // [Designated Initializers and Convenience Initializers]
    
    //To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:
    //Rule 1: A designated initializer must call a designated initializer from its immediate superclass.
    //Rule 2: A convenience initializer must call another initializer from the same class.
    //Rule 3: A convenience initializer must ultimately call a designated initializer.
    
    //A simple way to remember this is:
    //Designated initializers must always delegate up.
    //Convenience initializers must always delegate across.

    
    // [Two-Phase Initialization]
    
    // Class initialization in Swift is a two-phase process. In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined, the second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.
    // The use of a two-phase initialization process makes initialization safe, while still giving complete flexibility to each class in a class hierarchy. Two-phase initialization prevents property values from being accessed before they’re initialized, and prevents property values from being set to a different value by another initializer unexpectedly.
    
    // Swift’s two-phase initialization process is similar to initialization in Objective-C.
    // The main difference is that during phase 1, Objective-C assigns zero or null values (such as 0 or nil) to every property.
    // Swift’s initialization flow is more flexible in that it lets you set custom initial values, and can cope with types for which 0 or nil isn’t a valid default value.

    // Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:
    // Safety check 1: A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
    // As mentioned above, the memory for an object is only considered fully initialized once the initial state of all of its stored properties is known. In order for this rule to be satisfied, a designated initializer must make sure that all of its own properties are initialized before it hands off up the chain.
    // Safety check 2: A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.
    // Safety check 3: A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.
    // Safety check 4: An initializer can’t call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.

    // Here’s how two-phase initialization plays out, based on the four safety checks above:
    // Phase 1: A designated or convenience initializer is called on a class.
    // Memory for a new instance of that class is allocated. The memory isn’t yet initialized.
    // A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
    // The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
    // This continues up the class inheritance chain until the top of the chain is reached.
    // Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
    // Phase 2
    // Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
    // Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.
    
    // [Initializer Inheritance and Overriding]
    // Unlike subclasses in Objective-C, Swift subclasses don’t inherit their superclass initializers by default. Swift’s approach prevents a situation in which a simple initializer from a superclass is inherited by a more specialized subclass and is used to create a new instance of the subclass that isn’t fully or correctly initialized.
    // If you want a custom subclass to present one or more of the same initializers as its superclass, you can provide a custom implementation of those initializers within the subclass.
    
    // You always write the override modifier when overriding a superclass designated initializer, even if your subclass’s implementation of the initializer is a convenience initializer.
    // Conversely, if you write a subclass initializer that matches a superclass convenience initializer, that superclass convenience initializer can never be called directly by your subclass, as per the rules described above

    // The default initializer (when available) is always a designated initializer for a class.
    class Vehicle {
        var numberOfWheels = 0
        var description: String {
            return "\(numberOfWheels) wheel(s)"
        }
    }

    class Bicycle: Vehicle {
        override init() {
            super.init()
            numberOfWheels = 2
        }
    }

    // If a subclass initializer performs no customization in phase 2 of the initialization process, and the superclass has a synchronous, zero-argument designated initializer, you can omit a call to super.init() after assigning values to all of the subclass’s stored properties.
    // If the superclass’s initializer is asynchronous, you need to write await super.init() explicitly.

    class Hoverboard: Vehicle {
        var color: String
        init(color: String) {
            self.color = color
            // super.init() implicitly called here
        }
        override var description: String {
            return "\(super.description) in a beautiful \(color)"
        }
    }
    
    let hb = Hoverboard(color: "Blue")
    print("HB",hb.description)
    
    // Subclasses can modify inherited variable properties during initialization, but can’t modify inherited constant properties.
    
    // [Automatic Initializer Inheritance]
    
    // As mentioned above, subclasses don’t inherit their superclass initializers by default. However, superclass initializers are automatically inherited if certain conditions are met.
    
    //Rule 1
    //If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
    
    //Rule 2
    //If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.
    
    // A subclass can implement a superclass designated initializer as a subclass convenience initializer as part of satisfying rule 2.
    
    // [Designated and Convenience Initializers in Action]
    
    // The following example shows designated initializers, convenience initializers, and automatic initializer inheritance in action.
    class Food {
        var name: String
        init(name: String) {
            self.name = name
        }
        convenience init() {
            self.init(name: "[Unnamed]")
        }
    }
    
    class RecipeIngredient: Food {
        var quantity: Int
        init(name: String, quantity: Int) {
            self.quantity = quantity
            super.init(name: name)
        }
        override convenience init(name: String) {
            self.init(name: name, quantity: 1)
        }
    }

    
    // Classes don’t have a default memberwise initializer, and so the Food class provides a designated initializer that takes a single argument called name.
    // The init(name: String) initializer from the Food class is provided as a designated initializer, because it ensures that all stored properties of a new Food instance are fully initialized.
    
    // All three of these initializers can be used to create new RecipeIngredient instances:
    let oneMysteryItem = RecipeIngredient()
    let oneBacon = RecipeIngredient(name: "Bacon")
    let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

    class ShoppingListItem2: RecipeIngredient {
        var purchased = false
        var description: String {
            var output = "\(quantity) x \(name)"
            output += purchased ? " ✔" : " ✘"
            return output
        }
    }
    
    // [Failable Initializers]
    // It’s sometimes useful to define a class, structure, or enumeration for which initialization can fail.
    // This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding.
    // You can’t define a failable and a nonfailable initializer with the same parameter types and names.
    
    // Strictly speaking, initializers don’t return a value. Rather, their role is to ensure that self is fully and correctly initialized by the time that initialization ends.
    // Although you write return nil to trigger an initialization failure, you don’t use the return keyword to indicate initialization success.
    

    //For instance, failable initializers are implemented for numeric type conversions. To ensure conversion between numeric types maintains the value exactly, use the init(exactly:) initializer. If the type conversion can’t maintain the value, the initializer fails.
    
    let wholeNumber: Double = 12345.0
    let pi = 3.14159

    if let valueMaintained = Int(exactly: wholeNumber) {
        print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
    }
    // Prints "12345.0 conversion to Int maintains value of 12345"

    let valueChanged = Int(exactly: pi)
    // valueChanged is of type Int?, not Int

    if valueChanged == nil {
        print("\(pi) conversion to Int doesn't maintain value")
    }
    // Prints "3.14159 conversion to Int doesn't maintain value"
    
    // The example below defines a structure called Animal, with a constant String property called species.
    // The Animal structure also defines a failable initializer with a single parameter called species.
    // This initializer checks if the species value passed to the initializer is an empty string.
    // If an empty string is found, an initialization failure is triggered. Otherwise, the species property’s value is set, and initialization succeeds:
    

    struct Animal {
        let species: String
        init?(species: String) {
            if species.isEmpty { return nil }
            self.species = species
        }
    }

    let animal = Animal(species: "")
    print("A",animal)
    
    let someCreature = Animal(species: "Giraffe")
    // someCreature is of type Animal?, not Animal

    if let giraffe = someCreature {
        print("An animal was initialized with a species of \(giraffe.species)")
    }
    // Prints "An animal was initialized with a species of Giraffe"
    
    
    
    let anonymousCreature = Animal(species: "")
    // anonymousCreature is of type Animal?, not Animal

    if anonymousCreature == nil {
        print("The anonymous creature couldn't be initialized")
    }
    // Prints "The anonymous creature couldn't be initialized"
    
    
    
    
    
    
    
    
    // [Failable Initializers for Enumerations]
    
    // You can use a failable initializer to select an appropriate enumeration case based on one or more parameters.
    // The initializer can then fail if the provided parameters don’t match an appropriate enumeration case.


    enum TemperatureUnit {
        case kelvin, celsius, fahrenheit
        init?(symbol: Character) {
            switch symbol {
            case "K":
                self = .kelvin
            case "C":
                self = .celsius
            case "F":
                self = .fahrenheit
            default:
                return nil
            }
        }
        // another init by me
        init?(code: Int) {
            switch code {
            case 101:
                self = .celsius
            default:
                return nil
            }
        }
    }
    
    let fahrenheitUnit = TemperatureUnit(symbol: "F")
    if fahrenheitUnit != nil {
        print("This is a defined temperature unit, so initialization succeeded.")
    }
    // Prints "This is a defined temperature unit, so initialization succeeded."

    let unknownUnit = TemperatureUnit(symbol: "X")
    if unknownUnit == nil {
        print("This isn't a defined temperature unit, so initialization failed.")
    }
    // Prints "This isn't a defined temperature unit, so initialization failed."

    
    
    // [Failable Initializers for Enumerations with Raw Values]
    
    
    
    enum TemperatureUnitWithRaw: Character {
        case kelvin = "K", celsius = "C", fahrenheit = "F"
    }

    let fahrenheitUnit2 = TemperatureUnitWithRaw(rawValue: "F")
    if fahrenheitUnit2 != nil {
        print("This is a defined temperature unit, so initialization succeeded.")
    }
    // Prints "This is a defined temperature unit, so initialization succeeded."

    let unknownUnit2 = TemperatureUnitWithRaw(rawValue: "X")
    if unknownUnit2 == nil {
        print("This isn't a defined temperature unit, so initialization failed.")
    }
    // Prints "This isn't a defined temperature unit, so initialization failed."
    
    
    
    
    
    // [Propagation of Initialization Failure]
    // A failable initializer can also delegate to a nonfailable initializer.
    // Use this approach if you need to add a potential failure state to an existing initialization process that doesn’t otherwise fail.
    
    class Product {
        let name: String
        init?(name: String) {
            if name.isEmpty { return nil }
            self.name = name
        }
    }

    class CartItem: Product {
        let quantity: Int
        init?(name: String, quantity: Int) {
            if quantity < 1 { return nil }
            self.quantity = quantity
            super.init(name: name)
        }
    }
    
    if let twoSocks = CartItem(name: "sock", quantity: 2) {
        print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
    }
    // Prints "Item: sock, quantity: 2"
    
    if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
        print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
    } else {
        print("Unable to initialize zero shirts")
    }
    // Prints "Unable to initialize zero shirts"
    
    if let oneUnnamed = CartItem(name: "", quantity: 1) {
        print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
    } else {
        print("Unable to initialize one unnamed product")
    }
    // Prints "Unable to initialize one unnamed product"
    
    
    // [Overriding a Failable Initializer]
    
    // You can override a superclass failable initializer in a subclass, just like any other initializer. Alternatively, you can override a superclass failable initializer with a subclass nonfailable initializer.
    // This enables you to define a subclass for which initialization can’t fail, even though initialization of the superclass is allowed to fail.

    // You can override a failable initializer with a nonfailable initializer but not the other way around.
    

    
    class Document {
        var name: String?
        // this initializer creates a document with a nil name value
        init() {}
        // this initializer creates a document with a nonempty name value
        init?(name: String) {
            if name.isEmpty { return nil }
            self.name = name
        }
    }
    
    class AutomaticallyNamedDocument: Document {
        override init() {
            super.init()
            self.name = "[Untitled]"
        }
        override init(name: String) {
            super.init()
            if name.isEmpty {
                self.name = "[Untitled]"
            } else {
                self.name = name
            }
        }
    }
    
    // [The init! Failable Initializer]
    // [Required Initializers]
    
    // Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:

    class SomeClass {
        required init() {
            // initializer implementation goes here
        }
    }
    
    // You must also write the required modifier before every subclass implementation of a required initializer,
    // to indicate that the initializer requirement applies to further subclasses in the chain.
    // You don’t write the override modifier when overriding a required designated initializer:
    
    class SomeSubclass: SomeClass {
        required init() {
            // subclass implementation of the required initializer goes here
        }
    }

    // You don’t have to provide an explicit implementation of a required initializer if you can satisfy the requirement with an inherited initializer.

    // [Setting a Default Property Value with a Closure or Function]
    

    
//    class SomeClass3 {
//        let someProperty: SomeType = {
//            // create a default value for someProperty inside this closure
//            // someValue must be of the same type as SomeType
//            return someValue
//        }()
//    }

    // If you use a closure to initialize a property, remember that the rest of the instance hasn’t yet been initialized at the point that the closure is executed.
    // This means that you can’t access any other property values from within your closure, even if those properties have default values.
    // You also can’t use the implicit self property, or call any of the instance’s methods.

    struct Chessboard {
        let boardColors: [Bool] = {
            var temporaryBoard: [Bool] = []
            var isBlack = false
            for i in 1...8 {
                for j in 1...8 {
                    temporaryBoard.append(isBlack)
                    isBlack = !isBlack
                }
                isBlack = !isBlack
            }
            return temporaryBoard
        }()
        func squareIsBlackAt(row: Int, column: Int) -> Bool {
            return boardColors[(row * 8) + column]
        }
    }


    let board = Chessboard()
    print(board.squareIsBlackAt(row: 0, column: 1))
    // Prints "true"
    print(board.squareIsBlackAt(row: 7, column: 7))
    // Prints "false"
    
    
    
}
