
import Foundation

func _06_CollectionTypes()
{
    //Swift provides three primary collection types, known as arrays, sets, and dictionaries, for storing collections of values. Arrays are ordered collections of values. Sets are unordered collections of unique values. Dictionaries are unordered collections of key-value associations.
    
    // mutability is defined by let, var
    
    
    //
    //
    //Arrays : An array stores values of the same type in an ordered list. The same value can appear in an array multiple times at different positions.
    //
    //
    
    var someInts = [Int]()
    var ningo = Array<Int>() // << this is not usually prefered.
    
    print("someInts is of type [Int] with \(someInts.count) items.")
    
    //Swift’s Array type is bridged to Foundation’s NSArray class.

    someInts.append(3)
    // someInts now contains 1 value of type Int
    someInts = []
    // someInts is now an empty array, but is still of type [Int]”
    

    var threeDoubles = Array(repeating: 0.0, count: 3)
    // threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
    
    // arrays could be added by using "+"
    
    // thanks to type inference
    var shoppingList = ["Eggs", "Milk"]
    print(shoppingList.count)
    
    if shoppingList.isEmpty {
        print("The shopping list is empty.")
    } else {
        print("The shopping list is not empty.")
    }
    
    shoppingList.append("Flour")
    
    shoppingList += ["Baking Powder"]
    shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
    
    var firstItem = shoppingList[0]
    
    //The first item in the array has an index of 0, not 1. Arrays in Swift are always zero-indexed.
    
    shoppingList[0] = "Six eggs"
    
    //When you use subscript syntax, the index you specify needs to be valid. For example, writing shoppingList[shoppingList.count] = "Salt" to try to append an item to the end of the array results in a runtime error.
    
    shoppingList[4...6] = ["Bananas", "Apples"]
    
    shoppingList.insert("Maple Syrup", at: 0)
    
    
    let mapleSyrup = shoppingList.remove(at: 0)
    // the item that was at index 0 has just been removed
    // shoppingList now contains 6 items, and no Maple Syrup
    // the mapleSyrup constant is now equal to the removed "Maple Syrup" string
    
    let apples = shoppingList.removeLast()
    
    
    
    // iterating through the array using for loop
    for item in shoppingList {
        print(item)
    }
    
    
    //If you need the integer index of each item as well as its value, use the enumerated() method to iterate over the array instead. For each item in the array, the enumerated() method returns a tuple composed of an integer and the item. The integers start at zero and count up by one for each item; if you enumerate over a whole array, these integers match the items’ indices. You can decompose the tuple into temporary constants or variables as part of the iteration:
    
        
    for (index, value) in shoppingList.enumerated() {
        print("Item \(index + 1): \(value)")
    }
    
    
    
    //
    //
    //Sets : A set stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items is not important, or when you need to ensure that an item only appears once.
    //
    //
    
    
    /*
    You can use your own custom types as set value types or dictionary key types by making them conform to the Hashable protocol from Swift’s standard library. Types that conform to the Hashable protocol must provide a gettable Int property called hashValue. The value returned by a type’s hashValue property is not required to be the same across different executions of the same program, or in different programs.
    
    Because the Hashable protocol conforms to Equatable, conforming types must also provide an implementation of the equals operator (==). The Equatable protocol requires any conforming implementation of == to be an equivalence relation. That is, an implementation of == must satisfy the following three conditions, for all values a, b, and c:
    
    a == a (Reflexivity)
    
    a == b implies b == a (Symmetry)
    
    a == b && b == c implies a == c (Transitivity)”
    
    */
    
    /*
     The type of a Swift set is written as Set<Element>, where Element is the type that the set is allowed to store. Unlike arrays, sets do not have an equivalent shorthand form.
    */
    
    
    var letters = Set<Character>()
    print("letters is of type Set<Character> with \(letters.count) items.")
    // Prints "letters is of type Set<Character> with 0 items.
    
    letters.insert("a")
    // letters now contains 1 value of type Character
    letters = []
    // letters is now an empty set, but is still of type Set<Character>
    

    var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
    // favoriteGenres has been initialized with three initial items
    
    var favoriteGenres2: Set = ["Rock", "Classical", "Hip hop"]
    
    
    print("I have \(favoriteGenres.count) favorite music genres.")
    // Prints "I have 3 favorite music genres.
    
    if favoriteGenres.isEmpty{
        print("As far as music goes, I'm not picky.")
    }
    else{
        print("I have particular music preferences.")
    }
    // Prints "I have particular music preferences.
    
    favoriteGenres.insert("Jazz")
    // favoriteGenres now contains 4 items
    
    if let removedGenre = favoriteGenres.remove("Rock")
    {
        print("\(removedGenre)? I'm over it.")
    }
    else
    {
        print("I never much cared for that.")
    }
    
    // Prints "Rock? I'm over it."
    
    if favoriteGenres.contains("Funk") {
        print("I get up on the good foot.")
    } else {
        print("It's too funky in here.")
    }
    // Prints "It's too funky in here.
        

    for genre in favoriteGenres {
        print("\(genre)")
    }
    // Jazz
    // Hip hop
    // Classical
    
    
    // sets are not ordered, but has a sort function
    for genre in favoriteGenres.sorted() {
        print("\(genre)")
    }
    // Classical
    // Hip hop
    // Jazz
    
    // refer here for sort and sorted : https://thatthinginswift.com/sort-and-sorted/
    
    
    
    let oddDigits: Set = [1, 3, 5, 7, 9]
    let evenDigits: Set = [0, 2, 4, 6, 8]
    let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
    
    oddDigits.union(evenDigits).sorted()
    // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    oddDigits.intersection(evenDigits).sorted()
    // []
    oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
    // [1, 9]
    oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
    // [1, 2, 9]
    
    let houseAnimals: Set = ["🐶", "🐱"]
    let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
    let cityAnimals: Set = ["🐦", "🐭"]
    
    houseAnimals.isSubset(of: farmAnimals)
    // true
    farmAnimals.isSuperset(of: houseAnimals)
    // true
    farmAnimals.isDisjoint(with: cityAnimals)
    // true
    
    
    
    //
    //
    // Dictionaries
    //
    //
    
    var namesOfIntegers = Dictionary<Int, String>() //
    var namesOfIntegers2 = [Int: String]()

    
    namesOfIntegers[16] = "sixteen"
    // namesOfIntegers now contains 1 key-value pair
    namesOfIntegers = [:]
    // namesOfIntegers is once again an empty dictionary of type [Int: String]”
    
    var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
    
    var airports2 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
    
    
    
    print("The airports dictionary contains \(airports.count) items.")
    // Prints "The airports dictionary contains 2 items.
    
    
    if airports.isEmpty {
        print("The airports dictionary is empty.")
    } else {
        print("The airports dictionary is not empty.")
    }
    // Prints "The airports dictionary is not empty.”
    
    airports["LHR"] = "London"
    airports["LHR"] = "London Heathrow"
    
    
    //The updateValue(_:forKey:) method returns an optional value of the dictionary’s value type. For a dictionary that stores String values, for example, the method returns a value of type String?, or “optional String”. This optional value contains the old value for that key if one existed before the update, or nil if no value existed:
    
    if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB"){
        print("The old value for DUB was \(oldValue).")
    }
    // Prints "The old value for DUB was Dublin.”

    airports["APL"] = "Apple International"
    
    airports["APL"] = nil

    
    for (airportCode, airportName) in airports {
        print("\(airportCode): \(airportName)")
    }
    // YYZ: Toronto Pearson
    // LHR: London Heathrow”
    
    for airportCode in airports.keys {
        print("Airport code: \(airportCode)")
    }
    // Airport code: YYZ
    // Airport code: LHR
    
    for airportName in airports.values {
        print("Airport name: \(airportName)")
    }
    // Airport name: Toronto Pearson
    // Airport name: London Heathrow
    
    
    // I DON"T UNDERSTAND THIS VERY WELL !!
    //If you need to use a dictionary’s keys or values with an API that takes an Array instance, initialize a new array with the keys or values property:
    
    let airportCodes = [String](airports.keys)
    // airportCodes is ["YYZ", "LHR"]
    
    let airportNames = [String](airports.values)
    // airportNames is ["Toronto Pearson", "London Heathrow"]
    
    // you can use the sorted() method on its keys or values property.”
    
    
    
    
    
}
