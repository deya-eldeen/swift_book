
import Foundation

func _09_Closures() {

}

// [Closures]
    //Closures are self-contained blocks of functionality that can be passed around and used in your code.
    //Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.
    //Closures can capture and store references to any constants and variables from the context in which they’re defined.
    //This is known as closing over those constants and variables. Swift handles all of the memory management of capturing for you.

    //Closures take one of three forms:
    // - Global functions are closures that have a name and don’t capture any values.
    // - Nested functions are closures that have a name and can capture values from their enclosing function.
    // - Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.

    //Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. These optimizations include:
    // - Inferring parameter and return value types from context
    // - Implicit returns from single-expression closures
    // - Shorthand argument names
    // - Trailing closure syntax

// [Closure Expressions]
// [The Sorted Method]
// [Closure Expression Syntax]
// [Inferring Type From Context]
// [Implicit Returns from Single-Expression Closures]
// [Shorthand Argument Names]
// [Operator Methods]
// [Trailing Closures]
// [Capturing Values]
// [Closures Are Reference Types]
// [Escaping Closures]
// [Autoclosures]






//
//
//
//
//
//
//
//// Closures are self-contained blocks of functionality that can be passed around and used in your code.
//// Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.
//
//
////        Closures take one of three forms:
////
////        Global functions are closures that have a name and don’t capture any values.
////        Nested functions are closures that have a name and can capture values from their enclosing function.
////        Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
//
////    Closures are made brief and clutter free using these optimizations
////
////    Inferring parameter and return value types from context
////    Implicit returns from single-expression closures
////    Shorthand argument names
////    Trailing closure syntax
//
//
//let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//
//func backward(_ s1: String, _ s2: String) -> Bool {
//    return s1 > s2
//}
//var reversedNames = names.sorted(by: backward)
//
//
////* The parameters in closure expression syntax can be in-out parameters, but they can’t have a default value.
////* Variadic parameters can be used if you name the variadic parameter.
////* Tuples can also be used as parameter types and return types.
//
////The start of the closure’s body is introduced by the in keyword.
////This keyword indicates that the definition of the closure’s parameters and return type has finished, and the body of the closure is about to begin.
//
//// 🟩 Closure Expressions
//
//reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
//    return s1 > s2
//})
//
//reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
//
//reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
//
////Implicit Returns from Single-Expression Closures
//
//reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
//
////Shorthand Argument Names
//
//reversedNames = names.sorted(by: { $0 > $1 } )
//
////Operator Methods
//reversedNames = names.sorted(by: >)
//
//// 🟩 Trailing Closures
//
//func someFunctionThatTakesAClosure(closure: () -> Void) {
//    // function body goes here
//}
//
//// Here's how you call this function without using a trailing closure:
//
//someFunctionThatTakesAClosure(closure: {
//    // closure's body goes here
//})
//
//// Here's how you call this function with a trailing closure instead:
//
//someFunctionThatTakesAClosure() {
//    // trailing closure's body goes here
//}
//
//func someFunctionThatTakesClosures(closure: () -> Void, a: Int, closure2: () -> Void) {
//    // function body goes here
//}
//
//
//someFunctionThatTakesClosures(closure: {}, a: 11) {
//
//}
//
//func someFunctionThatTakesClosures2(a: Int, closure: () -> Void, closure2: () -> Void) {
//    // function body goes here
//}
//
//someFunctionThatTakesClosures2(a: 33) {
//    print("1")
//} closure2: {
//    print("2")
//}
//
////if a closure expression is provided as the function’s or method’s only argument and you provide that expression as a trailing closure
//
//// even shorter version
//
//reversedNames = names.sorted { $0 > $1 }
//
//
//let digitNames = [
//    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
//    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
//]
//let numbers = [16, 58, 510]
//let strings = numbers.map { (number) -> String in
//    var number = number
//    var output = ""
//    repeat {
//        output = digitNames[number % 10]! + output
//        number /= 10
//    } while number > 0
//    return output
//}
//// strings is inferred to be of type [String]
//// its value is ["OneSix", "FiveEight", "FiveOneZero"]
//
//// 🟩 Capturing Values
//
//func makeIncrementer(forIncrement amount: Int) -> () -> Int {
//    var runningTotal = 0
//    func incrementer() -> Int {
//        runningTotal += amount
//        return runningTotal
//    }
//    return incrementer
//}
//
//let incrementByTen = makeIncrementer(forIncrement: 10)
//
//incrementByTen()
//// returns a value of 10
//incrementByTen()
//// returns a value of 20
//incrementByTen()
//// returns a value of 30
//
//
//let incrementBySeven = makeIncrementer(forIncrement: 7)
//incrementBySeven()
//// returns a value of 7
//
//incrementByTen()
//// returns a value of 40
//
//
//let alsoIncrementByTen = incrementByTen
//alsoIncrementByTen()
//// returns a value of 50
//
//incrementByTen()
//// returns a value of 60
//
////The example above shows that calling alsoIncrementByTen is the same as calling incrementByTen.
////Because both of them refer to the same closure, they both increment and return the same running total.
//
//
//
//
//
//// 🟩 Closures Are Reference Types
//
////In the example above, incrementBySeven and incrementByTen are constants,
////but the closures these constants refer to are still able to increment the runningTotal variables that they have captured.
////This is because functions and closures are reference types.
//
////This also means that if you assign a closure to two different constants or variables,
////both of those constants or variables refer to the same closure.
//

// 🟩 [Escaping Closures]
// A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. When you declare a function that takes a closure as one of its parameters, you can write @escaping before the parameter’s type to indicate that the closure is allowed to escape.

// An escaping closure that refers to self needs special consideration if self refers to an instance of a class. Capturing self in an escaping closure makes it easy to accidentally create a strong reference cycle.
                                                                        
class Closures1 {
    var completionHandlers: [() -> Void] = []

    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
    }
    
    func run1() {
        someFunctionWithEscapingClosure() {
            print("z")
        }
        completionHandlers.first?()
        completionHandlers.first?()
    }

    //
    
    func run2() {
        func howAreYou(_ responseHandler: @escaping (String) -> Void) {
            print("Hey, how are you?") // you ask how are you
          
            // Simulating how it takes 2 seconds for your friend to answer:
            // This way you tell the program that the responseHandler is an asynchronous closure and you want it to stay alive even after howAreYou call completes.
            DispatchQueue.main.asyncAfter(deadline: .now() + 8, execute: {
                responseHandler("Hi, I'm doing really good.")
            })
          
            print("Responding takes a while...")
        }
        howAreYou({ friendResponse in
            print(friendResponse) // print the response that arrives later
        })
    }
    
    
    //

}

//Escaping closures are useful whenever you want the closure to be able to outlive the function’s scope from where you are calling it.
//
//A great example is when dealing with network requests.




// 🟩 [Autoclosures]
