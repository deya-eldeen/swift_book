
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

/*
 Swift provides two ways to resolve strong reference cycles when you work with properties of class type: weak references and unowned references.
 Weak and unowned references enable one instance in a reference cycle to refer to the other instance without keeping a strong hold on it.
 The instances can then refer to each other without creating a strong reference cycle.

 Use a weak reference when the other instance has a shorter lifetime—that is, when the other instance can be deallocated first.
 In the Apartment example above, it’s appropriate for an apartment to be able to have no tenant at some point in its lifetime, and so
 a weak reference is an appropriate way to break the reference cycle in this case.

 In contrast, use an unowned reference when the other instance has the same lifetime or a longer lifetime.

 */
    // -----------------------------------------------------------------------------
    // [🔷 Weak References]
    // -----------------------------------------------------------------------------

    /*
      A weak reference is a reference that doesn’t keep a strong hold on the instance it refers to, and so doesn’t stop ARC from disposing of the referenced instance.
     
      This behavior prevents the reference from becoming part of a strong reference cycle.
     
      You indicate a weak reference by placing the weak keyword before a property or variable declaration.
     
      Because a weak reference doesn’t keep a strong hold on the instance it refers to, it’s possible for that instance to be deallocated while the weak reference is still referring to it.
     
     
      Therefore, ARC automatically sets a weak reference to nil when the instance that it refers to is deallocated.
      // SideNote: By using weak references, you can break the strong reference cycle and allow the objects involved to be deallocated when they are no longer needed.
      
      Note: weak can only be used with var, not with let, this is why...

      And, because weak references need to allow their value to be changed to nil at runtime, they’re always declared as variables, rather than constants, of an optional type.
      You can check for the existence of a value in the weak reference, just like any other optional value, and you will never end up with a reference to an invalid instance that no longer exists.
    */
    
    // NOTE: Property observers (didset, willset,...) aren’t called when ARC sets a weak reference to nil.

    // The example below is identical to the Person and Apartment example from above, with one important difference.
    // This time around, the Apartment type’s tenant property is declared as a weak reference:

    class Person13 {
        let name: String
        init(name: String) { self.name = name }
        var apartment: Apartment13?
        deinit { print("\(name) is being deinitialized") }
    }

    class Apartment13 {
        let unit: String
        init(unit: String) { self.unit = unit }
        weak var tenant: Person13?
        deinit { print("Apartment \(unit) is being deinitialized") }
    }

    var john13: Person13?
    var unit4AB: Apartment13?

    john13 = Person13(name: "John Appleseed")
    unit4AB = Apartment13(unit: "4A")

    john13!.apartment = unit4AB
    unit4AB!.tenant = john13

    john = nil
    // Prints "John Appleseed is being deinitialized”

    unit4A = nil
    // Prints "Apartment 4A is being deinitialized”

    // -----------------------------------------------------------------------------
    // [🔷 Unowned References]
    // -----------------------------------------------------------------------------
    // Like a weak reference, an unowned reference doesn’t keep a strong hold on the instance it refers to.
    // Unlike a weak reference, however, an unowned reference is used when the other instance has the same lifetime or a longer lifetime.
    // You indicate an unowned reference by placing the unowned keyword before a property or variable declaration.
    // Unlike a weak reference, an unowned reference is expected to always have a value.
    // As a result, marking a value as unowned doesn’t make it optional, and ARC never sets an unowned reference’s value to nil.

    // Question, any practical example where unowned can solve retain cycle, and weak cannot?
    
    //Caution: Use an unowned reference only when you are sure that the reference always refers to an instance that hasn’t been deallocated.
    //If you try to access the value of an unowned reference after that instance has been deallocated, you’ll get a runtime error.

    //The following example defines two classes, Customer and CreditCard, which model a bank customer and a possible credit card for that customer.
    //These two classes each store an instance of the other class as a property. This relationship has the potential to create a strong reference cycle.
    //The relationship between Customer and CreditCard is slightly different from the relationship between Apartment and Person seen in the weak reference example above.
    //In this data model, a customer may or may not have a credit card, but a credit card will always be associated with a customer.
    //A CreditCard instance never outlives the Customer that it refers to.
    
    //To represent this, the Customer class has an optional card property, but the CreditCard class has an unowned (and non-optional) customer property.
    //Furthermore, a new CreditCard instance can only be created by passing a number value and a customer instance to a custom CreditCard initializer.
    //This ensures that a CreditCard instance always has a customer instance associated with it when the CreditCard instance is created.”

    //Because a credit card will always have a customer, you define its customer property as an unowned reference, to avoid a strong reference cycle:

    class Customer {
        let name: String
        var card: CreditCard?
        init(name: String) {
            self.name = name
        }
        deinit { print("\(name) is being deinitialized") }
    }

    class CreditCard {
        let number: UInt64
        unowned let customer: Customer
        init(number: UInt64, customer: Customer) {
            self.number = number
            self.customer = customer
        }
        deinit { print("Card #\(number) is being deinitialized") }
    }

    // The number property of the CreditCard class is defined with a type of UInt64 rather than Int,
    // to ensure that the number property’s capacity is large enough to store a 16-digit card number on both 32-bit and 64-bit systems.

    //This next code snippet defines an optional Customer variable called johnny88, which will be used to store a reference to a specific customer.
    //This variable has an initial value of nil, by virtue of being optional:
    
    var johnny88: Customer?
    johnny88 = Customer(name: "John Appleseed")
    johnny88!.card = CreditCard(number: 1234_5678_9012_3456, customer: johnny88!)

    //You can now create a Customer instance, and use it to initialize and assign a new CreditCard instance as that customer’s card property:
    
    johnny88 = nil
    // Prints "John Appleseed is being deinitialized"
    // Prints "Card #1234567890123456 is being deinitialized”
    
    //The examples above show how to use safe unowned references.
    //Swift also provides unsafe unowned references for cases where you need to disable runtime safety checks—for example, for performance reasons.
    //As with all unsafe operations, you take on the responsibility for checking that code for safety.
    //You indicate an unsafe unowned reference by writing unowned(unsafe).
    //If you try to access an unsafe unowned reference after the instance that it refers to is deallocated, your program will try to access the memory location where the instance used to be, which is an unsafe operation.

    // RESEARCH, the difference between these
    class Senjab {
        unowned let customer: Customer? = nil
        unowned let customer2: Customer? = nil
        unowned(safe) let customer3: Customer? = nil
        unowned(unsafe) let customer4: Customer? = nil
    }

    // -----------------------------------------------------------------------------
    // [🔷 Unowned Optional References]
    // -----------------------------------------------------------------------------
    
    //You can mark an optional reference to a class as unowned. In terms of the ARC ownership model, an unowned optional reference and a weak reference can both be used in the same contexts.
    
    //The difference is that when you use an unowned optional reference, you’re responsible for making sure it always refers to a valid object or is set to nil.
    //Here’s an example that keeps track of the courses offered by a particular department at a school:

    class Department {
        var name: String
        var courses: [Course]
        init(name: String) {
            self.name = name
            self.courses = []
        }
    }

    class Course {
        var name: String
        unowned var department: Department
        unowned var nextCourse: Course?
        init(name: String, in department: Department) {
            self.name = name
            self.department = department
            self.nextCourse = nil
        }
    }

    // Department maintains a strong reference to each course that the department offers.
    // In the ARC ownership model, a department owns its courses.
    // Course has two unowned references, one to the department and one to the next course a student should take; a course doesn’t own either of these objects.
    
    // the above line explains why the reference type is called unowned !!!!!
    
    // Every course is part of some department so the department property isn’t an optional.
    // However, because some courses don’t have a recommended follow-on course, the nextCourse property is an optional.

    // Here is an example of using these classes
    let department = Department(name: "Horticulture")

    let intro = Course(name: "Survey of Plants", in: department)
    let intermediate = Course(name: "Growing Common Herbs", in: department)
    let advanced = Course(name: "Caring for Tropical Plants", in: department)

    intro.nextCourse = intermediate
    intermediate.nextCourse = advanced
    department.courses = [intro, intermediate, advanced]

    //The code above creates a department and its three courses.
    //The intro and intermediate courses both have a suggested next course stored in their nextCourse property,
    //which maintains an unowned optional reference to the course a student should take after completing this one.

    //An unowned optional reference doesn’t keep a strong hold on the instance of the class that it wraps, and so it doesn’t prevent ARC from deallocating the instance.
    //It behaves the same as an unowned reference does under ARC, except that an unowned optional reference can be nil.
    
    //Like non-optional unowned references, you’re responsible for ensuring that nextCourse always refers to a course that hasn’t been deallocated.
    //In this case, for example, when you delete a course from department.courses you also need to remove any references to it that other courses might have.

    //⚠️: The underlying type of an optional value is Optional, which is an enumeration in the Swift standard library.
    //⚠️: However, optionals are an exception to the rule that value types can’t be marked with unowned.
    
    //The optional that wraps the class doesn’t use reference counting, so you don’t need to maintain a strong reference to the optional.

    // -----------------------------------------------------------------------------
    // [🔷 Unowned References and Implicitly Unwrapped Optional Properties]
    // -----------------------------------------------------------------------------

    // The examples for weak and unowned references above cover two of the more common scenarios in which it’s necessary to break a strong reference cycle.
    // The Person and Apartment example shows a situation where two properties, both of which are allowed to be nil, have the potential to cause a strong reference cycle.
    // This scenario is best resolved with a weak reference.
    // The Customer and CreditCard example shows a situation where one property that’s allowed to be nil and another property that can’t be nil have the potential to cause a strong reference cycle.
    // This scenario is best resolved with an unowned reference.

    // However, there’s a third scenario, in which both properties should always have a value, and neither property should ever be nil once initialization is complete.
    // In this scenario, it’s useful to combine an unowned property on one class with an implicitly unwrapped optional property on the other class.
    // This enables both properties to be accessed directly (without optional unwrapping) once initialization is complete, while still avoiding a reference cycle.
    // This section shows you how to set up such a relationship.
    // The example below defines two classes, Country and City, each of which stores an instance of the other class as a property.
    // In this data model, every country must always have a capital city, and every city must always belong to a country.
    // To represent this, the Country class has a capitalCity property, and the City class has a country property:

    class Country {
        let name: String
        var capitalCity: City!
        init(name: String, capitalName: String) {
            self.name = name
            self.capitalCity = City(name: capitalName, country: self)
        }
    }

    class City {
        let name: String
        unowned let country: Country
        init(name: String, country: Country) {
            self.name = name
            self.country = country
        }
    }

    // To set up the interdependency between the two classes, the initializer for City takes a Country instance, and stores this instance in its country property.
    // The initializer for City is called from within the initializer for Country.
    // However, the initializer for Country can’t pass self to the City initializer until a new Country instance is fully initialized, as described in Two-Phase Initialization.
    // To cope with this requirement, you declare the capitalCity property of Country as an implicitly unwrapped optional property, indicated by the exclamation point at the end of its type annotation (City!).
    // This means that the capitalCity property has a default value of nil, like any other optional, but can be accessed without the need to unwrap its value as described in Implicitly Unwrapped Optionals.
    // Because capitalCity has a default nil value, a new Country instance is considered fully initialized as soon as the Country instance sets its name property within its initializer.
    // This means that the Country initializer can start to reference and pass around the implicit self property as soon as the name property is set.
    // The Country initializer can therefore pass self as one of the parameters for the City initializer when the Country[…]”

    var country = Country(name: "Canada", capitalName: "Ottawa")
    print("\(country.name)'s capital city is called \(country.capitalCity.name)")
    // Prints "Canada's capital city is called Ottawa”

    // In the example above, the use of an implicitly unwrapped optional means that all of the two-phase class initializer requirements are satisfied.
    // The capitalCity property can be used and accessed like a non-optional value once initialization is complete, while still avoiding a strong reference cycle.



    
    // -----------------------------------------------------------------------------
    // [🔷 Strong Reference Cycles For Closures]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Resolving Strong Reference Cycles For Closures]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Defining A Capture List]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Weak and unowned references]
    // -----------------------------------------------------------------------------

    
}


