
import Foundation

func _18_ARC()
{

    // -----------------------------------------------------------------------------
    // [🔷 Automatic Reference Counting]
    // -----------------------------------------------------------------------------

    /*
    Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage.
    In most cases, this means that memory management “just works” in Swift, and you don’t need to think about memory management yourself.
    
    ARC automatically frees up the memory used by class instances when those instances are no longer needed.
    
    External Note: Each copy of the struct has its own independent memory, and there is no need for reference counting to manage the memory.
    
    However, in a few cases ARC requires more information about the relationships between parts of your code in order to manage memory for you.
    This chapter describes those situations and shows how you enable ARC to manage all of your app’s memory.
     
    Using ARC in Swift is very similar to the approach described in Transitioning to ARC Release Notes [https://developer.apple.com/library/content/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html] for using ARC with Objective-C.
    Reference counting applies only to instances of classes. Structures and enumerations are value types, not reference types, and aren’t stored and passed by reference.
    */

    // -----------------------------------------------------------------------------
    // [🔷 How ARC Works]
    // -----------------------------------------------------------------------------

    /*

    Every time you create a new instance of a class, ARC allocates a chunk of memory to store information about that instance.
     
    This memory holds information about the type of the instance, together with the values of any stored properties associated with that instance.
     
    Additionally, when an instance is no longer needed, ARC frees up the memory used by that instance so that the memory can be used for other purposes instead.
     
    This ensures that class instances don’t take up space in memory when they’re no longer needed.
    However, if ARC were to deallocate an instance that was still in use, it would no longer be possible to access that instance’s properties, or call that instance’s methods.
     
    Indeed, if you tried to access the instance, your app would most likely crash.
    To make sure that instances don’t disappear while they’re still needed, ARC tracks how many properties, constants, and variables are currently referring to each class instance.
     
     
    ARC will not deallocate an instance as long as at least one active reference to that instance still exists.
    Side Note: here, reference means usage of that instance.
     
    To make this possible, whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes a strong reference to the instance.
    The reference is called a “strong” reference because it keeps a firm hold on that instance, and doesn’t allow it to be deallocated for as long as that strong reference remains.

    */

    // -----------------------------------------------------------------------------
    // [🔷 ARC in Action]
    // -----------------------------------------------------------------------------

    // Here’s an example of how Automatic Reference Counting works. This example starts with a simple class called Person, which defines a stored constant property called name:
    class Person9 {
        let name: String
        init(name: String) {
            self.name = name
            print("\(name) is being initialized")
        }
        deinit {
            print("\(name) is being deinitialized")
        }
    }

    //The Person class has an initializer that sets the instance’s name property and prints a message to indicate that initialization is underway.
    //The Person class also has a deinitializer that prints a message when an instance of the class is deallocated.

    //The next code snippet defines three variables of type Person?, which are used to set up multiple references to a new Person instance in subsequent code snippets.
    //Because these variables are of an optional type (Person?, not Person), they’re automatically initialized with a value of nil, and don’t currently reference a Person instance.
    var reference1: Person9?
    var reference2: Person9?
    var reference3: Person9?

    //You can now create a new Person9 instance and assign it to one of these three variables:
    reference1 = Person9(name: "John Appleseed")
    // Prints "John Appleseed is being initialized"
    //Note that the message "John Appleseed is being initialized" is printed at the point that you call the Person9 class’s initializer.
    //This confirms that initialization has taken place.
    
    //Because the new Person9 instance has been assigned to the reference1 variable, there’s now a strong reference from reference1 to the new Person9 instance.
    // Sidenote: all are strong by default

    //Because there’s at least one strong reference, ARC makes sure that this Person9 is kept in memory and isn’t deallocated.
    //If you assign the same Person9 instance to two more variables, two more strong references to that instance are established:
    reference2 = reference1
    reference3 = reference1

    //There are now three strong references to this single Person9 instance.
    //If you break two of these strong references (including the original reference) by assigning nil to two of the variables, a single strong reference remains, and the Person9 instance isn’t deallocated:
    reference1 = nil
    reference2 = nil

    //ARC doesn’t deallocate the Person9 instance until the third and final strong reference is broken, at which point it’s clear that you are no longer using the Person instance:
    reference3 = nil
    // Prints "John Appleseed is being deinitialized”


    // -----------------------------------------------------------------------------
    // [🔷 Strong Reference Cycles Between Class Instances]
    // -----------------------------------------------------------------------------
    
    /*
    In the examples above, ARC is able to track the number of references to the new Person instance you create and to deallocate that Person instance when it’s no longer needed.
    However, it’s possible to write code in which an instance of a class never gets to a point where it has zero strong references.
     
    This can happen if two class instances hold a strong reference to each other, such that each instance keeps the other alive. This is known as a strong reference cycle.
    
    You resolve strong reference cycles by defining some of the relationships between classes as weak or unowned references instead of as strong references.
    This process is described in Resolving Strong Reference Cycles Between Class Instances.
     
    However, before you learn how to resolve a strong reference cycle, it’s useful to understand how such a cycle is caused.
    Here’s an example of how a strong reference cycle can be created by accident.
    This example defines two classes called Person and Apartment, which model a block of apartments and its residents:
    */
    
    class Person12 {
        let name: String
        init(name: String) { self.name = name }
        var apartment: Apartment12?
        deinit { print("\(name) is being deinitialized") }
    }

    class Apartment12 {
        let unit: String
        init(unit: String) { self.unit = unit }
        var tenant: Person12?
        deinit { print("Apartment \(unit) is being deinitialized") }
    }

    /*
    Every Person instance has a name property of type String and an optional apartment property that’s initially nil.
    The apartment property is optional, because a person may not always have an apartment.
     
    Similarly, every Apartment instance has a unit property of type String and has an optional tenant property that’s initially nil.
    The tenant property is optional because an apartment may not always have a tenant.
     
    Both of these classes also define a deinitializer, which prints the fact that an instance of that class is being deinitialized.
    This enables you to see whether instances of Person and Apartment are being deallocated as expected.
    */
    
    //This next code snippet defines two variables of optional type called john and unit4A, which will be set to a specific Apartment and Person instance below.
    //Both of these variables have an initial value of nil, by virtue of being optional:”

    var john: Person12?
    var unit4A: Apartment12?

    john = Person12(name: "John Appleseed")
    unit4A = Apartment12(unit: "4A")

    //The john variable now has a strong reference to the new Person instance, and the unit4A variable has a strong reference to the new Apartment instance:”

//    Unfortunately, linking these two instances creates a strong reference cycle between them.
//    The Person instance now has a strong reference to the Apartment instance, and the Apartment instance has a strong reference to the Person instance.
//    Therefore, when you break the strong references held by the john and unit4A variables, the reference counts don’t drop to zero, and the instances aren’t deallocated by ARC:

    john = nil
    unit4A = nil

    //The strong references between the Person instance and the Apartment instance remain and can’t be broken.

    // -----------------------------------------------------------------------------
    // [🔷 Resolving Strong Reference Cycles Between Class Instances]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Weak References]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Unowned References and Implicitly Unwrapped Optional Properties]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Strong Reference Cycles For Closures]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Resolving Strong Reference Cycles For Closures]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Defining A Capture List]
    // -----------------------------------------------------------------------------

}


