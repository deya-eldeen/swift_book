//
//  Closures2.swift
//  swiftBook
//
//  Created by Deya on 14/03/2022.
//  Copyright © 2022 DeyaEldeen. All rights reserved.
//

import Foundation

class SomeClass {
    var x = 10
    let c2 = Closures2()

    func doSomething() {
        c2.someFunctionWithEscapingClosure { self.x = 100 }
        c2.someFunctionWithNonescapingClosure { x = 200 }
    }
    
    // Here’s a version of doSomething() that captures self by including it in the closure’s capture list,
    // and then refers to self implicitly:

    func doSomething2() {
        c2.someFunctionWithEscapingClosure { [self] in x = 100 }
        c2.someFunctionWithNonescapingClosure { x = 200 }
    }
    
}

class Closures2 {
    
    // 🟩 Escaping Closures
    
    // A closure is said to escape a function when the closure is passed as an argument to the function,
    // but is called after the function returns. When you declare a function that takes a closure as one of its parameters,
    // you can write @escaping before the parameter’s type to indicate that the closure is allowed to escape.
    
    // One way that a closure can escape is by being stored in a variable that’s defined outside the function.
    
    // If you didn’t mark the parameter of this function with @escaping, you would get a compile-time error.
    var completionHandlers: [() -> Void] = []
    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
    }
    
    func someFunctionWithNonescapingClosure(closure: () -> Void) {
        print("X1")
        //completionHandlers.append(closure)
        // above gives
        // Converting non-escaping parameter 'closure' to generic parameter 'Element' may allow it to escape
        
        closure()
        print("X2")
    }
    
    func someFunctionWithEscapingClosure2(completionHandler: @escaping () -> Void) {
        print("T1")
        completionHandler()
        print("T2")
    }
    
    // An escaping closure that refers to self needs special consideration if self refers to an instance of a class.
    // Capturing self in an escaping closure makes it easy to accidentally create a strong reference cycle.
    
    
    func runExample() {
        let instance = SomeClass()
        instance.doSomething()
        print(instance.x)
        
        completionHandlers.first?()
        print(instance.x)
    }
    
    
    
    // If self is an instance of a structure or an enumeration, you can always refer to self implicitly.
    // However, an escaping closure can’t capture a mutable reference to self when self is an instance of a structure or an enumeration.
    // Structures and enumerations don’t allow shared mutability, as discussed in Structures and Enumerations Are Value Types.

//    struct SomeStruct {
//        var x = 10
//        mutating func doSomething() {
//            c2.someFunctionWithNonescapingClosure { x = 200 }  // Ok
//            c2.someFunctionWithEscapingClosure { x = 100 }     // Error
//        }
//    }
    

    // The call to the someFunctionWithEscapingClosure function in the example above is an error because it’s inside a mutating method,
    // so self is mutable. That violates the rule that escaping closures can’t capture a mutable reference to self for structures.
    
    // IMPORTANT REFERENCE: https://alisoftware.github.io/swift/closures/2016/07/25/closure-capture-1/


        
    
}

