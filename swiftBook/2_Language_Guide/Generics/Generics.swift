
import Foundation

// [Generics]
    //Generic code enables you to write flexible, reusable functions and types that can work with any type,
    //You can write code that avoids duplication and expresses its intent in a clear, abstracted manner.
    //... and there are no limitations on what that type can be.
    
// [The Problem That Generics Solve]
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
// [Generic Functions]
    func swapTwoValues<Generic>(_ a: inout Generic, _ b: inout Generic) {
        let temporaryA = a
        a = b
        b = temporaryA
    }

    func swapTwoValues2<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }

// [Type Parameters]
    //In the swapTwoValues(_:_:) example above, the placeholder type T is an example of a type parameter. Type parameters specify and name a placeholder type, and are written immediately after the function’s name, between a pair of matching angle brackets (such as <T>).
    //Once you specify a type parameter,
    //you can use it to define the type of a function’s parameters (such as the a and b parameters of the swapTwoValues(_:_:) function),
    //or as the function’s return type, or as a type annotation within the body of the function.
    //You can provide more than one "type parameter" by writing multiple type parameter names within the angle brackets, separated by commas.

// [Naming Type Parameters]
    //In most cases, type parameters have descriptive names, such as Key and Value in Dictionary<Key, Value> and Element in Array<Element>,
    //which tells the reader about the relationship between the type parameter and the generic type or function it’s used in.
    //However, when there isn’t a meaningful relationship between them, it’s traditional to name them using single letters such as T, U, and V,
    //such as T in the swapTwoValues(_:_:) function above.
    
// [Generic Types]
    //In addition to generic functions, Swift enables you to define your own generic types. These are custom classes, structures, and enumerations that can work with any type, in a similar way to Array and Dictionary.
    //A stack is a useful collection model whenever you need a strict “last in, first out” approach to managing a collection.
    struct IntStack {
        var items: [Int] = []
        mutating func push(_ item: Int) {
            items.append(item)
        }
        mutating func pop() -> Int {
            return items.removeLast()
        }
    }
    struct Stack<Element> {
        var items: [Element] = []
        mutating func push(_ item: Element) {
            items.append(item)
        }
        mutating func pop() -> Element {
            return items.removeLast()
        }
    }

// [Extending a Generic Type]
    extension Stack {
        // topItem computed property
        var topItem: Element? {
            return items.isEmpty ? nil : items[items.count - 1]
        }
    }
    //Extensions of a generic type can also include requirements that instances of the extended type must satisfy in order to gain the new functionality, as discussed in Extensions with a Generic Where Clause below.

// [Type Constraints]
    //Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition.
    //the type of a dictionary’s keys must be hashable. That is, it must provide a way to make itself uniquely representable.
    //Dictionary needs its keys to be hashable so that it can check whether it already contains a value for a particular key.
    //Without this requirement, Dictionary couldn’t tell whether it should insert or replace a value for a particular key, nor would it be able to find a value for a given key that’s already in the dictionary.
    //You can define your own type constraints when creating custom generic types, and these constraints provide much of the power of generic programming.
    //Abstract concepts like Hashable characterize types in terms of their conceptual characteristics, rather than their concrete type.

// [Type Constraint Syntax]
    func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
        // function body goes here
    }

// [Type Constraints in Action]
    func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }

    // Not every type in Swift can be compared with the equal to operator (==).
    // If you create your own class or structure to represent a complex data model, for example, then the meaning of “equal to” for that class or structure isn’t something that Swift can guess for you
    // this func will not compile.. !
    // because of this line!
    // if value == valueToFind // Binary operator '==' cannot be applied to two 'T' operands

    //    func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
    //        for (index, value) in array.enumerated() {
    //            if value == valueToFind {
    //                return index
    //            }
    //        }
    //        return nil
    // }

    //you write a type constraint of Equatable as part of the type parameter’s definition when you define the function:
    func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    func someFunctionName() {
        let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
        if let foundIndex = findIndex(ofString: "llama", in: strings) {
            print("The index of llama is \(foundIndex)")
        }
        // Prints "The index of llama is 2"
    }


// [Associated Types]
    //When defining a protocol, it’s sometimes useful to declare one or more associated types as part of the protocol’s definition. An associated type gives a placeholder name to a type that’s used as part of the protocol.
    //An associated type gives a placeholder name to a type that’s used as part of the protocol.

// [Associated Types in Action]
    protocol Container {
        associatedtype Item
        mutating func append(_ item: Item)
        var count: Int { get }
        subscript(i: Int) -> Item { get }
    }
    //The Container protocol needs to specify that any value passed to the append(_:) method must have the same type as the container’s element type,
    //and that the value returned by the container’s subscript will be of the same type as the container’s element type.
    //the Container protocol declares an associated type called Item, to ensure that the expected behavior of any Container is enforced.
    struct StackContained<Element>: Container {
        // original Stack<Element> implementation
        var items: [Element] = []
        mutating func push(_ item: Element) {
            items.append(item)
        }
        mutating func pop() -> Element {
            return items.removeLast()
        }
        // conformance to the Container protocol
        mutating func append(_ item: Element) {
            self.push(item)
        }
        var count: Int {
            return items.count
        }
        subscript(i: Int) -> Element {
            return items[i]
        }
    }

// [Extending an Existing Type to Specify an Associated Type]
    extension Array: Container {}
    //After defining this extension, you can use any Array as a Container.
    //Swift’s Array type already provides an append(_:) method, a count property, and a subscript with an Int index to retrieve its elements. These three capabilities match the requirements of the Container protocol.
    //This means that you can extend Array to conform to the Container protocol simply by declaring that Array adopts the protocol.

// [Adding Constraints to an Associated Type]
    protocol Container2 {
        associatedtype Item: Equatable
        mutating func append(_ item: Item)
        var count: Int { get }
        subscript(i: Int) -> Item { get }
    }
    //To conform to this version of Container, the container’s Item type has to conform to the Equatable protocol.

// [Using a Protocol in Its Associated Type’s Constraints]
    //A protocol can appear as part of its own requirements. For example, here’s a protocol that refines the Container protocol,
    //adding the requirement of a suffix(_:) method. The suffix(_:) method returns a given number of elements from the end of the container,
    //storing them in an instance of the Suffix type.
    //⭐️ QUESTION: any real use of this???
    protocol SuffixableContainer: Container {
        associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
        func suffix(_ size: Int) -> Suffix
    }

    // ⭐️Need re-read...
    //    extension Stack: SuffixableContainer {
    //        func suffix(_ size: Int) -> Stack {
    //            var result = Stack()
    //            for index in (count-size)..<count {
    //                result.append(self[index])
    //            }
    //            return result
    //        }
    //        // Inferred that Suffix is Stack.
    //    }
    //
    //    var stackOfInts = Stack<Int>()
    //    stackOfInts.append(10)
    //    stackOfInts.append(20)
    //    stackOfInts.append(30)
    //    let suffix = stackOfInts.suffix(2)
    //    // suffix contains 20 and 30

// [Generic Where Clauses]
    // Type Constraints, not to be confused with "Generic Where Clauses" that constraint the associated types
    func allItemsMatch<C1: Container, C2: Container>
        (_ someContainer: C1, _ anotherContainer: C2) -> Bool
        where C1.Item == C2.Item, C1.Item: Equatable {

            // Check that both containers contain the same number of items.
            if someContainer.count != anotherContainer.count {
                return false
            }

            // Check each pair of items to see if they're equivalent.
            for i in 0..<someContainer.count {
                if someContainer[i] != anotherContainer[i] {
                    return false
                }
            }

            // All items match, so return true.
            return true
    }

// [Extensions with a Generic Where Clause]
    extension Stack where Element: Equatable {
        func isTop(_ item: Element) -> Bool {
            guard let topItem = items.last else {
                return false
            }
            return topItem == item
        }
    }

    extension Container where Item: Equatable {
        func startsWith(_ item: Item) -> Bool {
            return count >= 1 && self[0] == item
        }
    }

    func someFunctionName2() {
        if [9, 9, 9].startsWith(42) {
            print("Starts with 42.")
        } else {
            print("Starts with something else.")
        }
        // Prints "Starts with something else."
    }

    extension Container where Item == Double {
        func average() -> Double {
            var sum = 0.0
            for index in 0..<count {
                sum += self[index]
            }
            return sum / Double(count)
        }
    }
    //print([1260.0, 1200.0, 98.6, 37.0].average())
    // Prints "648.9"

    //You can include multiple requirements in a generic where clause that’s part of an extension, just like you can for a generic where clause that you write elsewhere. Separate each requirement in the list with a comma.

// [Contextual Where Clauses]
    // ⭐️ Difficult wordy stuff
    extension Container {
        func average() -> Double where Item == Int {
            var sum = 0.0
            for index in 0..<count {
                sum += Double(self[index])
            }
            return sum / Double(count)
        }
        func endsWith(_ item: Item) -> Bool where Item: Equatable {
            return count >= 1 && self[count-1] == item
        }
    }
    let numbers = [1260, 1200, 98, 37]
    //print(numbers.average())
    // Prints "648.75"
    //print(numbers.endsWith(37))
    // Prints "true"

    //If you want to write this code without using contextual where clauses, you write two extensions,
    //one for each generic where clause. The example above and the example below have the same behavior.
    extension Container2 where Item == Int {
        func average() -> Double {
            var sum = 0.0
            for index in 0..<count {
                sum += Double(self[index])
            }
            return sum / Double(count)
        }
    }
    extension Container2 where Item: Equatable {
        func endsWith(_ item: Item) -> Bool {
            return count >= 1 && self[count-1] == item
        }
    }
    
    //In the version of this example that uses contextual where clauses, the implementation of average() and endsWith(_:) are both in the same extension because each method’s generic where clause states the requirements that need to be satisfied to make that method available.
    //Moving those requirements to the extensions’ generic where clauses makes the methods available in the same situations, but requires one extension per requirement.

// [Associated Types with a Generic Where Clause]
    protocol Container33 {
        associatedtype Item
        mutating func append(_ item: Item)
        var count: Int { get }
        subscript(i: Int) -> Item { get }
        associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
        func makeIterator() -> Iterator
    }
    //The generic where clause on Iterator requires that the iterator must traverse over elements of the same item type as the container’s items, regardless of the iterator’s type. The makeIterator() function provides access to a container’s iterator.
    //For a protocol that inherits from another protocol, you add a constraint to an inherited associated type by including the generic where clause in the protocol declaration.
    //For example, the following code declares a ComparableContainer protocol that requires Item to conform to Comparable:
    protocol ComparableContainer: Container where Item: Comparable { }

// [Generic Subscripts]
    extension Container {
        subscript<Indices: Sequence>(indices: Indices) -> [Item]
            where Indices.Iterator.Element == Int {
                var result: [Item] = []
                for index in indices {
                    result.append(self[index])
                }
                return result
        }
    }
