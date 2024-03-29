import Foundation

func ASwiftTour() {
    /*
     “You don’t need to import a separate library for functionality like input/output
     or string handling. Code written at global scope is used as the entry point for the program,
     so you don’t need a main() function.”
     */
    
    // arrays and dicts
    
    var shoppingList = ["catfish", "water", "tulips", "blue paint"]
    shoppingList[1] = "bottle of water"
    
    var occupations = ["Malcolm": "Captain","Kaylee": "Mechanic",]
    occupations["Jayne"] = "Public Relations"
    
    // initialzing empty arrays and dicts
    let emptyArray = [String]()
    let emptyDictionary = [String: Float]()
    
    shoppingList = []
    occupations = [:]
    
    //
    
    let individualScores = [75, 43, 103, 87, 12]
    var teamScore = 0
    
    for score in individualScores{
        if score > 50 {
            teamScore += 3
        } else {
            teamScore += 1
        }
    }
    print(teamScore)
    
    //
    
    var optionalString: String? = "Hello"
    print(optionalString == nil) // prints "false"
    
    var optionalName: String? = nil
    var greeting = "Hello!"
    if let name = optionalName {
        greeting = "Hello, \(name)"
        print(greeting)
    }
    else
    {
        print("no name provided")
    }
    
    //
    
    var optionalName2: String! = "Deya"
    var greeting2 = "Hello!"
    if let name2 = optionalName2 {
        greeting2 = "Hello, \(name2)"
        print(greeting2)
    }
    else
    {
        print("no name provided 2")
    }
    
    // optionals with default values
    
    let nickName: String? = nil
    let fullName: String = "John Appleseed"
    let informalGreeting = "Hi \(nickName ?? fullName)"
    
    print(informalGreeting)
    
    //
    
    let vegetable = "red pepper"
    switch vegetable
    {
    case "celery":
        print("Add some raisins and make ants on a log.")
    case "cucumber", "watercress":
        print("That would make a good tea sandwich.")
    case let x where x.hasSuffix("pepper"):
        print("Is it a spicy \(x)?")
    default:
        print("Everything tastes good in soup.")
    }
    
    
    // for using dictionaries
    
    let interestingNumbers = [
        "Prime": [2, 3, 5, 7, 11, 13],
        "Fibonacci": [1, 1, 2, 3, 5, 8],
        "Square": [1, 4, 9, 16, 25],
        ]
    
    var largest = 0
    var largestKind = ""
    
    for (kind, numbers) in interestingNumbers
    {
        for number in numbers
        {
            if number > largest
            {
                largest = number
                largestKind = kind
            }
        }
    }
    
    print("largest is \(largest) and kind is \(largestKind)")
    
    //
    print("__whiles__")
    
    var n = 11
    while n <= 10
    {
        print("n \(n)")
        n = n + 3
    }
    
    
    var m = 11
    repeat
    {
        print("m \(m)")
        m = m + 3
    }
        while (m <= 10)
    
    
    
    
    var number = 123
    
    var binary = 0
    var digit  = 1
    
    
    while number > 0 {
        let reminder = number % 2
        
        // add the new digit to the number
        binary = digit * reminder + binary
        
        // move the digit to the left
        digit *= 10
        
        // remove the last binary digit
        number /= 2
    }
    
    //binary // 1111011
    
    
    
    //
    
    var total = 0
    for i in 0..<4
    {
        total += i
    }
    print(total)
    
    // functions
    
    // Write a custom argument label before the parameter name, or write _ to use no argument label.
    
    
    func greet1(person: String, day: String) -> String {
        return "Hello \(person), today is \(day)."
    }
    print(greet1(person: "Bob", day: "Tuesday"))
    
    
    func greet2(_ person: String, on day: String) -> String{
        return "Hello \(person), today is \(day)."
    }
    print(greet2("John", on: "Wednesday")) // notice how we didn't need to call person arg
    
    
    // tuples
    
    //Use a tuple to make a compound value
    
    
    // Functions are a first-class type. This means that a function can return another function as its value.
    

    
    // Functions are actually a special case of closures
    
    // Closures: blocks of code that can be called later
    
    // When a closure is the only argument to a function, you can omit the parentheses entirely.
    
    var origin = (x: 0, y: 0)
    
    var point = origin
    point.x = 3
    point.y = 5
    
    print(origin) // (0, 0)
    print(point) // (3, 5)
    
    // in out parameter
    
    func double(number: inout Int) {
        number = number * 2
    }
    
    var z = 10
    
    double(number: &z)
    
    print(z) // 20
    
    //
    
    
    
    func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int)
    {
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        
        for score in scores
        {
            if score > max
            {
                max = score
            }
            else if score < min
            {
                min = score
            }
            sum += score
        }
        
        return (min, max, sum)
    }
    let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
    print(statistics.sum)
    print(statistics.2)
    
    //
    print("__functionsWithVariableNumberOfArgs .. Variadic functions are functions that have a variable number of arguments")
    
    func sumOf(numbers: Int...) -> Int
    {
        var sum = 0
        for number in numbers
        {
            sum += number
        }
        return sum
    }
    print(sumOf())
    print(sumOf(numbers: 42, 597, 12))
    
    
    
    
    // from swift 3 book
    //Functions are a first-class type. This means that a function can return another function as its value.
    // I have a question, what is the point of this???
    
    func makeIncrementer() -> ((Int) -> Int)
    {
        func addOne(number: Int) -> Int
        {
            return 1 + number
        }
        return addOne
    }
    var increment = makeIncrementer()
    
    print(makeIncrementer()(10))
    increment(10)
    
    
    
    
    
    ////
    // a function can take another function as one of it's args
    
    func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool
    {
        for item in list
        {
            if condition(item)
            {
                return true
            }
        }
        return false
    }
    func lessThanTen(number: Int) -> Bool
    {
        return number < 10
    }
    var numbers = [20, 19, 7, 12]
    hasAnyMatches(list: numbers, condition: lessThanTen)
    
    
    
    ////
    ////
    
    /*
     Functions are a special kind of closures. There are three kinds of closures:
     
     global functions – they have a name and cannot capture any values
     nested functions – they have a name and can capture values from their enclosing functions
     closure expressions – they don’t have a name and can capture values from their context
     
     */
    
    // closures
    
    // objects and classes
    
    // setter & getter
    
//    Every property needs a value assigned—either in its declaration (as with numberOfSides) or in the initializer (as with name).


    //In addition to simple properties that are stored, properties can have a getter and a setter.


//    var perimeter: Double {
//        get {
//            return 3.0 * sideLength
//        }
//        set {
//            sideLength = newValue / 3.0
//        }
//    }
//
    
    
    class EquilateralTriangle {
        var sideLength: Double = 0.0

        var perimeter: Double {
            get {
                return 3.0 * sideLength
            }
            set (zazu) {
                sideLength = zazu / 3.0
            }
        }

    }

    var triangle = EquilateralTriangle()
    print(triangle.perimeter)
    // Prints "9.3"
    triangle.perimeter = 9.9
    print(triangle.sideLength)
    // Prints "3.3000000000000003"

    
    // enums and structres
    
    enum Rank: Int
    {
        case ace = 1
        case two, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king
        func simpleDescription() -> String
        {
            switch self
            {
            case .ace:
                return "ace"
            case .jack:
                return "jack"
            case .queen:
                return "queen"
            case .king:
                return "king"
            default:
                return String(self.rawValue)
            }
        }
    }
    let ace = Rank.ace
    let aceRawValue = ace.rawValue
    
    enum Suit {
        case spades, hearts, diamonds, clubs
        func simpleDescription() -> String {
            switch self {
            case .spades:
                return "spades"
            case .hearts:
                return "hearts"
            case .diamonds:
                return "diamonds"
            case .clubs:
                return "clubs"
            }
        }
    }
    let hearts = Suit.hearts
    let heartsDescription = hearts.simpleDescription()
    
    
    
    //You can think of the associated values as behaving like stored properties of the enumeration case instance.
    
    enum ServerResponse {
        case result(String, String)
        case failure(String)
    }

    let success = ServerResponse.result("6:00 am", "8:09 pm")
    let failure = ServerResponse.failure("Out of cheese.")

    switch success {
    case let .result(sunrise, sunset):
        print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
    case let .failure(message):
        print("Failure...  \(message)")
    }
    // Prints "Sunrise is at 6:00 am and sunset is at 8:09 pm."
    
    
    
    // structs
    
    //Use struct to create a structure. Structures support many of the same behaviors as classes,
    //including methods and initializers. One of the most important differences between structures and classes is that
    //structures are always copied when they are passed around in your code, but classes are passed by reference.
    
    // EXAMPLE ->
    
    class SomeClass
    {
        var name: String
        init(name: String)
        {
            self.name = name
        }
    }
    
    var aClass = SomeClass(name: "Bob")
    var bClass = aClass // aClass and bClass now reference the same instance!
    bClass.name = "Sue"
    
    print(aClass.name) // "Sue"
    print(bClass.name) // "Sue"
    
    /// but in structs
    
    struct SomeStruct {
        var name: String
        init(name: String) {
            self.name = name
        }
    }
    
    var aStruct = SomeStruct(name: "Bob")
    var bStruct = aStruct // aStruct and bStruct are two structs with the same value!
    bStruct.name = "Sue"
    
    print(aStruct.name) // "Bob"
    print(bStruct.name) // "Sue"
    
    //// end of example
    
    struct Card
    {
        var rank: Rank
        var suit: Suit
        func simpleDescription() -> String
        {
            return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
        }
    }
    
    let threeOfSpades = Card(rank: .three, suit: .spades)
    let threeOfSpadesDescription = threeOfSpades.simpleDescription()
        
    // protocols and extensions
    
    
//    protocol ExampleProtocol {
//        var simpleDescription: String { get }
//        mutating func adjust()
//    }
//
    
// Classes, enumerations, and structs can all adopt protocols.


//    class SimpleClass: ExampleProtocol {
//        var simpleDescription: String = "A very simple class."
//        var anotherProperty: Int = 69105
//        func adjust() {
//            simpleDescription += "  Now 100% adjusted."
//        }
//    }
//    var a = SimpleClass()
//    a.adjust()
//    let aDescription = a.simpleDescription
//
//    struct SimpleStructure: ExampleProtocol {
//        var simpleDescription: String = "A simple structure"
//        mutating func adjust() {
//            simpleDescription += " (adjusted)"
//        }
//    }
//    var b = SimpleStructure()
//    b.adjust()
//    let bDescription = b.simpleDescription

//    protocol ExampleProtocol {
//        var simpleDescription: String { get }
//        mutating func adjust()
//    }
//
//    enum ExampleEnum : ExampleProtocol {
//        case Base, Adjusted
//
//        var simpleDescription: String {
//            return self.getDescription()
//        }
//
//        func getDescription() -> String {
//            switch self {
//            case .Base:
//                return "A simple description of enum"
//            case .Adjusted:
//                return "Adjusted description of enum"
//            }
//        }
//
//        mutating func adjust() {
//            self = ExampleEnum.Adjusted
//        }
//    }
//
//    var c = ExampleEnum.Base
//    c.adjust()
//    let cDescription = c.simpleDescription
    
    
    // error handling
    
    enum PrinterError: Error {
        case outOfPaper
        case noToner
        case onFire
    }
    
    func send(job: Int, toPrinter printerName: String) throws -> String {
        if printerName == "Never Has Toner" {
            throw PrinterError.noToner
        }
        return "Job sent"
    }
    
    do {
        let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
        print(printerResponse)
    } catch {
        print(error)
    }
    // Prints "Job sent"
    
    // Another way to handle errors is to use try? to convert the result to an optional. If the function throws an error, the specific error is discarded and the result is nil. Otherwise, the result is an optional containing the value that the function returned.

    let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")

    // Use defer to write a block of code that’s executed after all other code in the function, just before the function returns. The code is executed regardless of whether the function throws an error. You can use defer to write setup and cleanup code next to each other, even though they need to be executed at different times.
    
    
    var fridgeIsOpen = false
    let fridgeContent = ["milk", "eggs", "leftovers"]

    func fridgeContains(_ food: String) -> Bool {
        fridgeIsOpen = true
        defer {
            fridgeIsOpen = false
        }

        let result = fridgeContent.contains(food)
        return result
    }
    fridgeContains("banana")
    print(fridgeIsOpen)
    // Prints "false"
    
    
    // Generics
    
    // Write a name inside angle brackets to make a generic function or type.
    

    
    enum OptionalValue<Wrapped> {
        case none
        case some(Wrapped)
    }
    
    var possibleInteger: OptionalValue<Int> = .none
    possibleInteger = .some(100)
    
    
    //

    // Use "where" right before the body to specify a list of requirements—for example, to require the type to implement a protocol, to require two types to be the same, or to require a class to have a particular superclass.


    
    func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool where T.Element: Equatable, T.Element == U.Element {
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    return true
                }
            }
        }
        return false
    }
    anyCommonElements([1, 2, 3], [3.9])

    
    
    
    // Writing <T: Equatable> is the same as writing <T> ... where T: Equatable.
    

    
    
}
