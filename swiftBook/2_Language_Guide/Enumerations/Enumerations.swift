import Foundation

enum Compass1 {
    case north
    case south
    case west
    case east
}

enum Compass2 {
    case north
    case south
    case east
    case west
}

enum BusType {
    case jet
    case normal
}

enum BasicColors {
    case green
    case red
    case blue
}

enum Language {
    case arabic
    case english
    case french
}

enum Planets {
    case mercury, venus, earth, mars
}

enum MeasurementUnit: CaseIterable {
    case km
    case mile
}


enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

enum Graphics {
    case three_d(Double, Double, Double)
    case two_d(Double, Double)
}


//
var basicColors = BasicColors.blue
var langauge = Language.french
var mu = MeasurementUnit.km

var ambigousPoint = Graphics.three_d(1, 4.4, -7.0)



// Raw Values
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

enum LatinLetter: Character {
    case alpha = "⍺"
    case beta = "β"
}

// Implicitly Assigned Raw Values

enum Number : Int, CaseIterable {
    case one = -2, two, three, four, five
    
}

// Recursive Enumerations
// A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases.
                                                                                                                    
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

// Prints "18"


func _10_Enumerations() {
        
    switch langauge {
    case .arabic:
        print("Ar")
    case .english:
        print("En")
    case .french:
        print("Fr")
    }
    
    switch basicColors {
    case .blue:
        print("Blue")
    case .green, .red:
        print("Other")
    }
    
    // CaseIterable provides all cases.
    print("\(MeasurementUnit.allCases.count)")
    
    for mu in MeasurementUnit.allCases {
        print("mu",mu)
    }

    switch ambigousPoint {
    case .two_d(let x, let y):
        print("2D (",x,",",y,")")
    case .three_d(let x, let y, let z):
        print("3D (",x,",",y,",",z,")")

    }
    
    // for brevity, in case all are extracted as constants
    
    ambigousPoint = Graphics.two_d(2.2, 6.22)
    
    switch ambigousPoint {
    case let .two_d(x, y):
        print("2D (",x,",",y,")")
    case let .three_d(x, y, z):
        print("3D (",x,",",y,",",z,")")

    }
    
    for number in Number.allCases {
        print("NUM: \(number) \(number.rawValue)")
    }

    for number in Number.allCases {
        print("NUM: \(number) \(number.rawValue)")
    }
    
    print(evaluate(product))

    
}














enum HealthCondition {
    case ill
    case normal
    case ideal
}

// healthCase is not optional
class Enums1 {
    let healthCase: HealthCondition

    init() {
        self.healthCase = HealthCondition.normal
    }
    
    func printHealthCases2() {
        switch healthCase {
        case .ill:
            print("ill")
        case .normal:
            print("normal")
        case .ideal:
            print("ideal")
        }
    }
    
}

// healthCase is optional, so, we can use none or default
class Enums2 {
    let healthCase: HealthCondition?

    init() {
        self.healthCase = HealthCondition.normal
    }
    
    func printHealthCases() {
        switch healthCase {
        case .ill:
            print("ill")
        case .normal:
            print("normal")
        case .ideal:
            print("ideal")
        case .none:
            print("none")
        }
    }
    
    func printHealthCases2() {
        switch healthCase {
        case .ill:
            print("ill")
        case .normal:
            print("normal")
        case .ideal:
            print("ideal")
        default:
            print("default")
        }
    }
    
    // have a look at these 2 switches, the one with the @unknown default, will warn us about missing cases
    func printHealthCases3() {
        switch healthCase {
        case .ill:
            print("ill")
        default:
            print("default")
        }
    }
    
    func printHealthCases4() {
        switch healthCase {
        case .ill:
            print("ill")
        case .none:
            print("none")
        @unknown default:
            print("default")
        }
    }
    
}

class Enums3 {
    
    enum Rank: Int {
        case ace = 1
        case two, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king

        func simpleDescription() -> String {
            switch self {
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
    
    func p() {
        let ace = Rank.three
        let aceRawValue = ace.rawValue
        
        print("ace",ace)
        print("aceRawValue",aceRawValue)
    }
    
}
