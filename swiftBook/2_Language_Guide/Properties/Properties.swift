import Foundation
import SwiftUI

func _12_Properties() {
    
    // Properties: Properties associate values with a particular class, structure, or enumeration.
    // Stored Properties: Stored properties store constant and variable values as part of an instance, stored properties are provided only by classes and structures.
    // Computed Properties: Calculate (rather than store) a value, and are provided by classes, structures, and enumerations.
    
    // Property Observers: you can define property observers to monitor changes in a property’s value, which you can respond to with custom actions.
    // Property observers can be added to stored properties you define yourself
    
    // You can also use a property wrapper to reuse code in the getter and setter of multiple properties.
    // Property Wrappers: A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property.
    // Global and Local Variables
    // Type Properties: properties can also be associated with the type itself. Such properties are known as type properties.

    // -----------------------
    // Stored Properties:
    // -----------------------

    //Instances of FixedLengthRange have a variable stored property called firstValue and a constant stored property called length.
    //In the example above, length is initialized when the new range is created and can’t be changed thereafter, because it’s a constant property.

    struct FixedLengthRange {
        var firstValue: Int
        let length: Int
    }
    
    let constantLength = FixedLengthRange(firstValue: 0, length: 3)
    //constantLength.firstValue = 6 //Cannot assign to property: 'constantLength' is a 'let' constant
    //constantLength.firstValue = 9 //Cannot assign to property: 'constantLength' is a 'let' constant
    //constantLength.length = 8 // Cannot assign to property: 'length' is a 'let' constant //Cannot assign to property: 'constantLength' is a 'let' constant
    
    // -----------------------
    // Stored Properties of Constant Structure Instances
    // -----------------------

    var variableLength = FixedLengthRange(firstValue: 0, length: 3)
    variableLength.firstValue = 13
    //variableLength.length = 8 // Cannot assign to property: 'length' is a 'let' constant
    
    
    //Because rangeOfFourItems is declared as a constant (with the let keyword), it isn’t possible to change its firstValue property, even though firstValue is a variable property.

    // This behavior is due to structures being value types.
    // When an instance of a value type is marked as a constant, so are all of its properties.
    
    // The same isn’t true for classes, which are reference types.
    // If you assign an instance of a reference type to a constant,
    // you can still change that instance’s variable properties.

    // -----------------------
    // Lazy Stored Properties
    // -----------------------
          
    // A lazy stored property is a property whose initial value isn’t calculated until the first time it’s used.
    // You indicate a lazy stored property by writing the lazy modifier before its declaration.

    // You must always declare a lazy property as a variable (with the var keyword), because its initial value might not be retrieved until after instance initialization completes.
    // Constant properties must always have a value before initialization completes, and therefore can’t be declared as lazy.
    
    // Lazy properties are useful when the initial value for a property is dependent on outside factors whose values aren’t known until after an instance’s initialization is complete.
    // Lazy properties are also useful when the initial value for a property requires complex or computationally expensive setup that shouldn’t be performed unless or until it’s needed.


    // The example below uses a lazy stored property to avoid unnecessary initialization of a complex class.
    // This example defines two classes called DataImporter and DataManager, neither of which is shown in full:
    
    class DataImporter {
        /*
        DataImporter is a class to import data from an external file.
        The class is assumed to take a nontrivial amount of time to initialize.
        */
        var filename = "data.txt"
        // the DataImporter class would provide data importing functionality here
    }

    class DataManager {
        lazy var importer = DataImporter()
        var data: [String] = []
        // the DataManager class would provide data management functionality here
    }

    let manager = DataManager()
    manager.data.append("Some data")
    manager.data.append("Some more data")
    // the DataImporter instance for the importer property hasn't yet been created
    
    // ⭐️: If a property marked with the lazy modifier is accessed by multiple threads simultaneously and the property hasn’t yet been initialized, there’s no guarantee that the property will be initialized only once.
    
    // -----------------------
    // Computed Properties
    // -----------------------
    
    // In addition to stored properties, classes, structures, and enumerations can define computed properties,
    // which don’t actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly.

    struct Point {
        var x = 0.0, y = 0.0
    }
    
    struct Size {
        var width = 0.0, height = 0.0
    }
    
    struct Rect {
        var origin = Point()
        var size = Size()
        var center: Point {
            get {
                let centerX = origin.x + (size.width / 2)
                let centerY = origin.y + (size.height / 2)
                return Point(x: centerX, y: centerY)
            }
            set(newCenter) {
                origin.x = newCenter.x - (size.width / 2)
                origin.y = newCenter.y - (size.height / 2)
            }
        }
    }
    
    var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
    let initialSquareCenter = square.center
    // initialSquareCenter is at (5.0, 5.0)
    square.center = Point(x: 15.0, y: 15.0)
    print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
    // Prints "square.origin is now at (10.0, 10.0)"
      
    struct EmYa3oob {
        
        var x = 0
        var y = 0
        var z = 0
        
        var g = 0
        
        var sum: Int {
            get {
                return (x+y+z)
            }
        }
        
        // [!] Variable with a setter must also have a getter
        var fullSum: Int {
            get {
                return (x+y+z)
            }
            set {
                self.x = 0
                self.y = 0
                self.z = 0
            }
        }
        
        var sumNew: Int {
            get {
                return (x+y+z)
            }
            set(newFlag) {
                self.x = (newFlag == -1) ? (-1*self.x) : (self.x)
            }
        }
        
        var sumNew2: Int {
            get {
                return (x+y+z)
            }
            set(newValue) {
                self.x = newValue - 1
            }
        }
        
    }
    
    var ey = EmYa3oob(x: 5, y: 5, z: 5)
    //ey.sum = 0 //Cannot assign to property: 'sum' is a get-only property
    print("ey.sum",ey.sum)
    print("ey.xyz",ey.x,ey.y,ey.z)
    ey.fullSum = 0
    print("ey.fullSum",ey.fullSum)
    print("ey.xyz",ey.x,ey.y,ey.z)
    print("ey.sum",ey.sum)
    print("ey.fullSum",ey.fullSum)

    var ey2 = EmYa3oob(x: 5, y: 5, z: 5)

    print("ey2.xyz",ey2.x,ey2.y,ey2.z)
    print("ey2.sumNew",ey2.sumNew)
    ey2.sumNew = -1
    print("ey2.sumNew",ey.sumNew)
    print("ey2.xyz",ey2.x,ey2.y,ey2.z)
    ey2.sumNew2 = -999
    print("ey2.sumNew2",ey2.sumNew2)
    print("ey2.x",ey2.x)
    
    // -----------------------
    // Shorthand Setter Declaration
    // -----------------------

    //    struct Rect {
    //        var origin = Point()
    //        var size = Size()
    //        var center: Point {
    //            get {
    //                let centerX = origin.x + (size.width / 2)
    //                let centerY = origin.y + (size.height / 2)
    //                return Point(x: centerX, y: centerY)
    //            }
    //            set(newCenter) {
    //                origin.x = newCenter.x - (size.width / 2)
    //                origin.y = newCenter.y - (size.height / 2)
    //            }
    //        }
    //    }
    
    struct AlternativeRect {
        var origin = Point()
        var size = Size()
        var center: Point {
            get {
                let centerX = origin.x + (size.width / 2)
                let centerY = origin.y + (size.height / 2)
                return Point(x: centerX, y: centerY)
            }
            set {
                origin.x = newValue.x - (size.width / 2)
                origin.y = newValue.y - (size.height / 2)
            }
        }
    }
    
    // -----------------------
    // Shorthand Getter Declaration
    // -----------------------
    
    // -----------------------
    // Read-Only Computed Properties
    // -----------------------
    
    // You must declare computed properties—including read-only computed properties—as variable properties with the var keyword,
    // because their value isn’t fixed. The let keyword is only used for constant properties, to indicate that their values can’t be changed once they’re set as part of instance initialization.
    
    //You can simplify the declaration of a read-only computed property by removing the get keyword and its braces:
    
    struct Cuboid {
        var width = 0.0, height = 0.0, depth = 0.0
        var volume: Double {
            return width * height * depth
        }
    }
    let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
    print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
    // Prints "the volume of fourByFiveByTwo is 40.0"
    
    // -----------------------
    // Shorthand Setter Declaration
    // -----------------------
    
    class StepCounter {
        var totalSteps: Int = 0 {
            willSet(newTotalSteps) {
                print("About to set totalSteps to \(newTotalSteps)")
            }
            didSet {
                if totalSteps > oldValue  {
                    print("Added \(totalSteps - oldValue) steps")
                }
            }
        }
    }
    
    let stepCounter = StepCounter()
    stepCounter.totalSteps = 200
    // About to set totalSteps to 200
    // Added 200 steps
    stepCounter.totalSteps = 360
    // About to set totalSteps to 360
    // Added 160 steps
    stepCounter.totalSteps = 896
    // About to set totalSteps to 896
    // Added 536 steps
    
    // If you pass a property that has observers to a function as an in-out parameter,
    // the willSet and didSet observers are always called. This is because of the copy-in copy-out memory model for in-out parameters: The value is always written back to the property at the end of the function.
    // For a detailed discussion of the behavior of in-out parameters, see In-Out Parameters.
    
    // -----------------------
    // Property Wrappers
    // -----------------------
    
    // A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property.
    // For example, if you have properties that provide thread-safety checks or store their underlying data in a database, you have to write that code on every property.
    // When you use a property wrapper, you write the management code once when you define the wrapper, and then reuse that management code by applying it to multiple properties.
                                                                                                                                                            
    // To define a property wrapper, you make a structure, enumeration, or class that defines a wrappedValue property.
    // In the code below, the TwelveOrLess structure ensures that the value it wraps always contains a number less than or equal to 12.
    // If you ask it to store a larger number, it stores 12 instead.
    
    @propertyWrapper
    struct TwelveOrLess {
        private var number = 0
        var wrappedValue: Int {
            get { return number }
            set { number = min(newValue, 12) }
        }
    }
    
    struct SmallRectangle {
        private var _height = TwelveOrLess()
        private var _width = TwelveOrLess()
        var height: Int {
            get { return _height.wrappedValue }
            set { _height.wrappedValue = newValue }
        }
        var width: Int {
            get { return _width.wrappedValue }
            set { _width.wrappedValue = newValue }
        }
    }
    
    @propertyWrapper
    struct Conditioned {
        
        private var number = 0.0
        
        let max = 1.0
        let min = 0.0
        
        var wrappedValue: Double {
            get {
                return number
            }
            set {
                number = (newValue > max) ? (max) : (newValue)
                number = (newValue < min) ? (min) : (number)
            }
        }
        
    }
    
    struct ACUnit {
        private var _temperature = Conditioned()
        
        var temperature: Double {
            get { return _temperature.wrappedValue }
            set { _temperature.wrappedValue = newValue}
        }
    }
    
    var ac = ACUnit()
    ac.temperature = 0.7
    ac.temperature = 1.1
    ac.temperature = 1.7
    ac.temperature = -2.1
    
    // -----------------------
    // Setting Initial Values for Wrapped Properties
    // -----------------------
    
    @propertyWrapper
    struct SmallNumber {
        private var maximum: Int
        private var number: Int

        var wrappedValue: Int {
            get { return number }
            set { number = min(newValue, maximum) }
        }

        init() {
            maximum = 12
            number = 0
        }
        init(wrappedValue: Int) {
            maximum = 12
            number = min(wrappedValue, maximum)
        }
        init(wrappedValue: Int, maximum: Int) {
            self.maximum = maximum
            number = min(wrappedValue, maximum)
        }
    }
    
    struct ZeroRectangle {
        @SmallNumber var height: Int
        @SmallNumber var width: Int
    }

    var zeroRectangle = ZeroRectangle()
    print(zeroRectangle.height, zeroRectangle.width)
    // Prints "0 0"
    
    
    // Unlike previous examples, SmallNumber also supports writing those initial values as part of declaring the property.
    
    struct UnitRectangle {
        @SmallNumber var height: Int = 1
        @SmallNumber var width: Int = 1
    }
    
    
    
    // When you write arguments in parentheses after the custom attribute,
    // Swift uses the initializer that accepts those arguments to set up the wrapper. For example,
    // if you provide an initial value and a maximum value, Swift uses the init(wrappedValue:maximum:) initializer:

    struct NarrowRectangle {
        @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
        @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
    }

    var narrowRectangle = NarrowRectangle()
    print(narrowRectangle.height, narrowRectangle.width)
    // Prints "2 3"

    narrowRectangle.height = 100
    narrowRectangle.width = 100
    print(narrowRectangle.height, narrowRectangle.width)
    // Prints "5 4"
    
    // -----------------------
    // Projecting a Value From a Property Wrapper
    // -----------------------
    // https://holyswift.app/projecting-a-value-from-a-property-wrapper
    
    // Today we will explore one great feature of property wrappers, the projected value.
    // It is very useful when you want to have a little more info about the wrapped value.
    // Ex: you have a property wrapper that set a max limit to the int,
    // you can project a boolean value that says if the property was set with more than the max value or less.
    
    // You need more information of wrapped values and don't want to the split the logic outside the property context.
    // Ex: You receive a text but the only important info is the first 3 characters and it must be uppercase to show to the user.
    // Also you want to know if it comes bigger than 3 characters from backend or not.
    

    @propertyWrapper
    struct UpperCaseMask {
        
        private var text: String  //1
        var projectedValue: Bool  //2
        
        init() {
            self.text = ""
            self.projectedValue = false
        }
        
        var wrappedValue: String {  //3
            get {return text}
            set {
                if newValue.count > 3 {
                    text = newValue.prefix(3).uppercased()
                    projectedValue = false
                } else {
                    text = newValue.uppercased()
                    projectedValue = true
                }
            }
        }
        
    }
    
    
    
    struct Home {
        @UpperCaseMask public var homeCode: String

        init(homeCode: String) {
            self.homeCode = homeCode
        }

        func getHomeCodeFullDescription() -> String {
            if $homeCode { // < - - - Here
                return "We just need to uppercase it"
            } else {
                return "We need to cut and uppercase it"
            }
        }
        
    }

    var home1 = Home(homeCode: "brln123123")
    print(home1.$homeCode, home1.homeCode, home1.getHomeCodeFullDescription())
    home1.homeCode = "can"
    print(home1.$homeCode, home1.homeCode, home1.getHomeCodeFullDescription())

    //
    //
    
    @propertyWrapper
    struct SmallNumber2 {
        
        private var number: Int
        private(set) var projectedValue: Bool

        var wrappedValue: Int {
            get { return number }
            set {
                if newValue > 12 {
                    number = 12
                    projectedValue = true
                } else {
                    number = newValue
                    projectedValue = false
                }
            }
        }

        init() {
            self.number = 0
            self.projectedValue = false
        }
        
    }
    
    struct SomeStructure {
        @SmallNumber2 var someNumber: Int
    }
    var someStructure = SomeStructure()

    someStructure.someNumber = 4
    print(someStructure.$someNumber)
    // Prints "false"

    someStructure.someNumber = 55
    print(someStructure.$someNumber)
    // Prints "true"
    
    
    // Local constants and variables are never computed lazily.
    // You can apply a property wrapper to a local stored variable, but not to a global variable or a computed variable.
    
    // -----------------------
    // Type Properties
    // -----------------------
    
    // Unlike stored instance properties, you must always give stored type properties a default value.
    // This is because the type itself doesn’t have an initializer that can assign a value to a stored type property at initialization time.
    
    // Stored type properties are lazily initialized on their first access.
    // They’re guaranteed to be initialized only once, even when accessed by multiple threads simultaneously,
    // and they don’t need to be marked with the lazy modifier.


    
    // Type Property Syntax
    
    struct SomeStructure3 {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 1
        }
    }
    enum SomeEnumeration {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 6
        }
    }
    class SomeClass {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 27
        }
        // ⚠️ IMPORTANT
        class var overrideableComputedTypeProperty: Int {
            return 107
        }
    }
    
    // The computed type property examples above are for read-only computed type properties,
    // but you can also define read-write computed type properties with the same syntax as for computed instance properties.
    

    
    
    // Querying and Setting Type Properties

    // Type properties are queried and set with dot syntax, just like instance properties. However,
    // type properties are queried and set on the type, not on an instance of that type. For example:

    print(SomeStructure3.storedTypeProperty)
    // Prints "Some value."
    SomeStructure3.storedTypeProperty = "Another value."
    print(SomeStructure3.storedTypeProperty)
    // Prints "Another value."
    print(SomeEnumeration.computedTypeProperty)
    // Prints "6"
    print(SomeClass.computedTypeProperty)
    // Prints "27"


    
}


