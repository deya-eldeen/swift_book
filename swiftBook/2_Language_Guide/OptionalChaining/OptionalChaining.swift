
import Foundation


class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Residence {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Person2 {
    var residence: Residence?
}

func _19_OptionalChaining()
{
    //Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil.
    //Optional chaining in Swift is similar to messaging nil in Objective-C, but in a way that works for any type, and that can be checked for success or failure.
    //Optional chaining fails gracefully when the optional is nil
    
    
    func createAddress() -> Address {
        print("Function was called.")

        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"

        return someAddress
    }
    let john = Person2()
    john.residence?.address = createAddress()
    
    // not how createAddress is not even executed !! :)
    
    // When you access a subscript on an optional value through optional chaining, you place the question mark before the subscript’s brackets, not after. The optional chaining question mark always follows immediately after the part of the expression that’s optional.
    
    // If a subscript returns a value of optional type—such as the key subscript of Swift’s Dictionary type—place a question mark after the subscript’s closing bracket to chain on its optional return value:

    var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
    testScores["Dave"]?[0] = 91
    testScores["Bev"]?[0] += 1
    testScores["Brian"]?[0] = 72
    // the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]
    
}



