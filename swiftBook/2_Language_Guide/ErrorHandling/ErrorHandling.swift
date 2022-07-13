
import Foundation

func _20_ErrorHandling()
{
    
    //In Swift, errors are represented by values of types that conform to the Error protocol.
    //This empty protocol indicates that a type can be used for error handling.

    //You use a throw statement to throw an error. For example, the following code throws an error to indicate that five additional coins are needed by the vending machine:

    enum VendingMachineError: Error {
        case invalidSelection
        case insufficientFunds(coinsNeeded: Int)
        case outOfStock
    }
    
    //throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

    // There are four ways to handle errors in Swift.
    // You can propagate the error from a function to the code that calls that function,
    // handle the error using a do-catch statement, handle the error as an optional value,
    // or assert that the error will not occur. Each approach is described in a section below.

    // Unlike exception handling in many languages—including Objective-C—error handling in Swift doesn’t involve "unwinding the call stack",
    // a process that can be computationally expensive. As such, the performance characteristics of a throw statement are comparable to those of a return statement.
    
    // [1- Propagating Errors Using Throwing Functions]
    
    //To indicate that a function, method, or initializer can throw an error, you write the throws keyword in the function’s declaration after its parameters.
    //A function marked with throws is called a throwing function. If the function specifies a return type, you write the throws keyword before the return arrow (->).

    // Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function.
    
    struct Item {
        var price: Int
        var count: Int
    }

    class VendingMachine {
        var inventory = [
            "Candy Bar": Item(price: 12, count: 7),
            "Chips": Item(price: 10, count: 4),
            "Pretzels": Item(price: 7, count: 11)
        ]
        var coinsDeposited = 0
        func vend(itemNamed name: String) throws {
            guard let item = inventory[name] else {
                throw VendingMachineError.invalidSelection
            }
            guard item.count > 0 else {
                throw VendingMachineError.outOfStock
            }
            guard item.price <= coinsDeposited else {
                throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
            }
            coinsDeposited -= item.price
            var newItem = item
            newItem.count -= 1
            inventory[name] = newItem
            print("Dispensing \(name)")
        }
    }
    
    let favoriteSnacks = [
        "Alice": "Chips",
        "Bob": "Licorice",
        "Eve": "Pretzels",
    ]
    func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try vendingMachine.vend(itemNamed: snackName)
    }
    
    // Throwing initializers can propagate errors in the same way as throwing functions.
    // For example, the initializer for the PurchasedSnack structure in the listing below calls a throwing function as part of the initialization process,
    // and it handles any errors that it encounters by propagating them to its caller.

    struct PurchasedSnack {
        let name: String
        init(name: String, vendingMachine: VendingMachine) throws {
            try vendingMachine.vend(itemNamed: name)
            self.name = name
        }
    }
    
    
    // [2- Handling Errors Using Do-Catch]
    
    // You use a do-catch statement to handle errors by running a block of code.

    var vendingMachine = VendingMachine()
    vendingMachine.coinsDeposited = 8
    do {
        try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
        print("Success! Yum.")
    } catch VendingMachineError.invalidSelection {
        print("Invalid Selection.")
    } catch VendingMachineError.outOfStock {
        print("Out of Stock.")
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    } catch {
        print("Unexpected error: \(error).")
    }
    // Prints "Insufficient funds. Please insert an additional 2 coins."
    
    //the propagated error must be handled by some surrounding scope. In a nonthrowing function, an enclosing do-catch statement must handle the error.
    //In a throwing function, either an enclosing do-catch statement or the caller must handle the error.
    //If the error propagates to the top-level scope without being handled, you’ll get a runtime error.
        
    
    //For example, the above example can be written so any error that isn’t a VendingMachineError is instead caught by the calling function:


    
    func nourish(with item: String) throws {
        do {
            try vendingMachine.vend(itemNamed: item)
        } catch is VendingMachineError {
            print("Couldn't buy that from the vending machine.")
        }
    }

    do {
        try nourish(with: "Beet-Flavored Chips")
    } catch {
        print("Unexpected non-vending-machine-related error: \(error)")
    }
    // Prints "Couldn't buy that from the vending machine."
    
    
    
    func eat(item: String) throws {
        do {
            try vendingMachine.vend(itemNamed: item)
        } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
            print("Invalid selection, out of stock, or not enough money.")
        }
    }
    
    
    
    
    // [3- Converting Errors to Optional Values]
    
//    func someThrowingFunction() throws -> Int {
//        // ...
//    }

//    let x = try? someThrowingFunction()
//
//    let y: Int?
//    do {
//        y = try someThrowingFunction()
//    } catch {
//        y = nil
//    }
//    
    
//    func fetchData() -> Data? {
//        if let data = try? fetchDataFromDisk() { return data }
//        if let data = try? fetchDataFromServer() { return data }
//        return nil
//    }
//
    


    
    // [4- Disabling Error Propagation]
    //     let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")

    // [Specifying Cleanup Actions]
    
    //A defer statement defers execution until the current scope is exited. This statement consists of the defer keyword and the statements to be executed later.
    //The deferred statements may not contain any code that would transfer control out of the statements, such as a break or a return statement, or by throwing an error.
    //Deferred actions are executed in the reverse of the order that they’re written in your source code.
    //That is, the code in the first defer statement executes last, the code in the second defer statement executes second to last, and so on. The last defer statement in source code order executes first.
    
//    func processFile(filename: String) throws {
//        if exists(filename) {
//            let file = open(filename)
//            defer {
//                close(file)
//            }
//            while let line = try file.readline() {
//                // Work with the file.
//            }
//            // close(file) is called here, at the end of the scope.
//        }
//    }
    
    // You can use a defer statement even when no error handling code is involved.
    

}




