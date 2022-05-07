
import Foundation

func _08_Functions() {
    
    //Swift’s unified function syntax is flexible enough to express anything from a simple C-style function with no parameter names to a complex Objective-C-style method with names and argument labels for each parameter.
    //Parameters can provide default values to simplify function calls
    //and can be passed as in-out parameters, which modify a passed variable once the function has completed its execution.
    //Every function in Swift has a type, consisting of the function’s parameter types and return type. You can use this type like any other type in Swift, which makes it easy to pass functions as parameters to other functions, and to return functions from functions. Functions can also be written within other functions to encapsulate useful functionality within a nested function scope.
    
    //Defining and Calling Functions
    
        //A function’s arguments must always be provided in the same order as the function’s parameter list.
    
    //Function Parameters and Return Values

        //Strictly speaking, this version of the greet(person:) function does still return a value, even though no return value is defined. Functions without a defined return type return a special value of type Void. This is simply an empty tuple, which is written as ().
    
    //Functions with Multiple Return Values
    
        //You can use a tuple type as the return type for a function to return multiple values as part of one compound return value.

    func minMax(array: [Int]) -> (min: Int, max: Int) {
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
        //Note that the tuple’s members don’t need to be named at the point that the tuple is returned from the function, because their names are already specified as part of the function’s return type.
    
    //Functions With an Implicit Return
    
        //Any function that you write as just one return line can omit the return.

    //Function Argument Labels and Parameter Names
    
        //All parameters must have unique names. Although it’s possible for multiple parameters to have the same argument label, unique argument labels help make your code more readable.

        //The use of argument labels can allow a function to be called in an expressive, sentence-like manner, while still providing a function body that’s readable and clear in intent.

        //Parameters that don’t have default values are usually more important to the function’s meaning—writing them first makes it easier to recognize that the same function is being called
    
        //Variadic Functions
    
    func arithmeticMean(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    arithmeticMean(1, 2, 3, 4, 5)
    // returns 3.0, which is the arithmetic mean of these five numbers
    arithmeticMean(3, 8.25, 18.75)
    // returns 10.0, which is the arithmetic mean of these three numbers
    
    //⚠️ A function can have multiple variadic parameters. The first parameter that comes after a variadic parameter must have an argument label. The argument label makes it unambiguous which arguments are passed to the variadic parameter and which arguments are passed to the parameters that come after the variadic parameter.

    // In-out parameters can’t have default values
    // and variadic parameters can’t be marked as inout.
    
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    var someInt = 3
    var anotherInt = 107
    swapTwoInts(&someInt, &anotherInt)
    print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

    
    
    //Function Types
    
    func z(a: Int,b: Int) -> Int {
        a + b
    }
    
    func x(a: Int,b: Int) -> Int {
        a + b
    }
    
    var someFunction: (Int,Int) -> Int
    someFunction = z
    someFunction = x
    
    someFunction(1,2)
    
    // Function Types as Return Types

    
    func stepForward(_ input: Int) -> Int {
        return input + 1
    }
    func stepBackward(_ input: Int) -> Int {
        return input - 1
    }
    
    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
        return backward ? stepBackward : stepForward
    }
    
    var currentValue = 3
    let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
    // moveNearerToZero now refers to the stepBackward() function
    
    //Swift has first-class functions, which means that:
    //functions can be stored in constants and variables
    //functions can be passed as arguments to other functions
    //functions can be returned by other functions
    //Functions are first-class citizens in Swift, which opens up a lot of possibilities. Let me show you what that means.
    
    
    //Nested Functions
    
    
}
