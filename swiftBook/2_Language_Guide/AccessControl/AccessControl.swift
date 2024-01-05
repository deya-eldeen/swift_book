
import Foundation

private class Tool {
    let id: String
    init(id: String) {
        self.id = id
    }
}

class experiment {
    func log() {
        let screwDriver = Tool(id: "sd")
        print(screwDriver.id)
    }
}


func _26_AccessControl() {

    // Access control restricts access to parts of your code from code in other source files and modules.
    // This feature enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used.
    // You can assign specific access levels to individual types (classes, structures, and enumerations), as well as to properties,
    // methods, initializers, and subscripts belonging to those types.
    // Protocols can be restricted to a certain context, as can global constants, variables, and functions.
    // In addition to offering various levels of access control, Swift reduces the need to specify explicit access control levels by providing default access levels for typical scenarios.
    // Indeed, if you are writing a single-target app, you may not need to specify explicit access control levels at all.
    // The various aspects of your code that can have access control applied to them (properties, types, functions, and so on) are referred to as “entities” in the sections below, for brevity.

    // -----------------------------------------------------------------------------
    // [🔷 Modules and source files]
    // -----------------------------------------------------------------------------
    // Swift’s access control model is based on the concept of modules and source files.
    // A module is a single unit of code distribution—a framework or application that’s built and shipped as a single unit and that can be imported by another module with Swift’s import keyword.
    // Each build target (such as an app bundle or framework) in Xcode is treated as a separate module in Swift.
    // If you group together aspects of your app’s code as a stand-alone framework—perhaps to encapsulate and reuse that code across multiple
    // applications—then everything you define within that framework will be part of a separate module when it’s imported and used within an app, or when it’s used within another framework.
    // A source file is a single Swift source code file within a module (in effect, a single file within an app or framework).
    // Although it’s common to define individual types in separate source files,
    // a single source file can contain definitions for multiple types, functions, and so on.

    // -----------------------------------------------------------------------------
    // [🔷 Access Levels]
    // -----------------------------------------------------------------------------
    
    // Swift provides five different access levels for entities within your code.
    // These access levels are relative to the source file in which an entity is defined,
    // and also relative to the module that source file belongs to.

    // -- Open access and public access enable entities to be used within any source file from their defining module,
    // and also in a source file from another module that imports the defining module.
    // You typically use open or public access when specifying the public interface to a framework.
    // The difference between open and public access is described below.
    
    // -- Internal access enables entities to be used within any source file from their defining module,
    // but not in any source file outside of that module. You typically use internal access when defining an app’s or a framework’s internal structure.
    
    // -- File-private access restricts the use of an entity to its own defining source file.
    // Use file-private access to hide the implementation details of a specific piece of functionality when those details are used within an entire file.
    
    // -- Private access restricts the use of an entity to the enclosing declaration, and to extensions of that declaration that are in the same file.
    // Use private access to hide the implementation details of a specific piece of functionality when those details are used only within a single declaration.

    // Open access is the highest (least restrictive) access level and private access is the lowest (most restrictive) access level.
    // Open access applies only to classes and class members, and it differs from public access by allowing code outside the module to subclass and override,
    // as discussed below in Subclassing. Marking a class as open explicitly indicates that you’ve considered the impact of code from other modules using that class as a superclass,
    // and that you’ve designed your class’s code accordingly.”

    // Guiding Principle of Access Levels
    // Access levels in Swift follow an overall guiding principle: No entity can be defined in terms of another entity that has a lower (more restrictive) access level.
    // For example:

    // A public variable can’t be defined as having an internal, file-private, or private type,
    // because the type might not be available everywhere that the public variable is used.”

    // A function can’t have a higher access level than its parameter types and return type,
    // because the function could be used in situations where its constituent types are unavailable to the surrounding code.
    // The specific implications of this guiding principle for different aspects of the language are covered in detail below.

    // Default Access Levels
    // All entities in your code (with a few specific exceptions, as described later in this chapter)
    // have a default access level of internal if you don’t specify an explicit access level yourself.
    // As a result, in many cases you don’t need to specify an explicit access level in your code.

    // Access Levels for Single-Target Apps
    // When you write a simple single-target app, the code in your app is typically self-contained within the app and doesn’t need to be made available outside of the app’s module.
    // The default access level of internal already matches this requirement. Therefore, you don’t need to specify a custom access level.
    // You may, however, want to mark some parts of your code as file private or private in order to hide their implementation details from other code within the app’s module.
    // Access Levels for Frameworks
    // When you develop a framework, mark the public-facing interface to that framework as open or public so that it can be viewed and accessed by other modules,
    // such as an app that imports the framework. This public-facing interface is the application programming interface (or API) for the framework.

    // Any internal implementation details of your framework can still use the default access level of internal,
    // or can be marked as private or file private if you want to hide them from other parts of the framework’s internal code.
    // You need to mark an entity as open or public only if you want it to become part of your framework’s API.
    
    // Access Levels for Unit Test Targets
    // When you write an app with a unit test target, the code in your app needs to be made available to that module in order to be tested.
    // By default, only entities marked as open or public are accessible to other modules.
    // However, a unit test target can access any internal entity,
    // if you mark the import declaration for a product module with the @testable attribute and compile that product module with testing enabled.
    
    // -----------------------------------------------------------------------------
    // [🔷 Access Control Syntax]
    // -----------------------------------------------------------------------------
    // Define the access level for an entity by placing one of the open, public, internal,
    // fileprivate, or private modifiers at the beginning of the entity’s declaration.
    
    // public class SomePublicClass {}
    // internal class SomeInternalClass {}
    // fileprivate class SomeFilePrivateClass {}
    // private class SomePrivateClass {}
    //
    // public var somePublicVariable = 0
    // internal let someInternalConstant = 0
    // fileprivate func someFilePrivateFunction() {}
    // private func somePrivateFunction() {}

    // Unless otherwise specified, the default access level is internal,
    // as described in Default Access Levels.
    // This means that SomeInternalClass and someInternalConstant can be written without an explicit access-level modifier,
    // and will still have an access level of internal:

    // class SomeInternalClass {}              // implicitly internal
    // let someInternalConstant = 0            // implicitly internal

    // -----------------------------------------------------------------------------
    // [🔷 Custom Types]
    // -----------------------------------------------------------------------------

    // If you want to specify an explicit access level for a custom type, do so at the point that you define the type.
    // The new type can then be used wherever its access level permits. For example, if you define a file-private class,
    // that class can only be used as the type of a property, or as a function parameter or return type,
    // in the source file in which the file-private class is defined.”

    // The access control level of a type also affects the default access level of that type’s members (its properties, methods, initializers, and subscripts).
    // If you define a type’s access level as private or file private, the default access level of its members will also be private or file private.
    // If you define a type’s access level as internal or public (or use the default access level of internal without specifying an access level explicitly),
    // the default access level of the type’s members will be internal.

    // A public type defaults to having internal members, not public members.
    // If you want a type member to be public, you must explicitly mark it as such.
    // This requirement ensures that the public-facing API for a type is something you opt in to publishing,
    // and avoids presenting the internal workings of a type as public API by mistake.

    //    public class SomePublicClass {                  // explicitly public class
    //        public var somePublicProperty = 0            // explicitly public class member
    //        var someInternalProperty = 0                 // implicitly internal class member
    //        fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    //        private func somePrivateMethod() {}          // explicitly private class member
    //    }
    //
    //    class SomeInternalClass {                       // implicitly internal class
    //        var someInternalProperty = 0                 // implicitly internal class member
    //        fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    //        private func somePrivateMethod() {}          // explicitly private class member
    //    }
    //
    //    fileprivate class SomeFilePrivateClass {        // explicitly file-private class
    //        func someFilePrivateMethod() {}              // implicitly file-private class member
    //        private func somePrivateMethod() {}          // explicitly private class member
    //    }
    //
    //    private class SomePrivateClass {                // explicitly private class
    //        func somePrivateMethod() {}                  // implicitly private class member
    //    }

    // Tuple Types
    // The access level for a tuple type is the most restrictive access level of all types used in that tuple.
    // For example, if you compose a tuple from two different types, one with internal access and one with private access,
    // the access level for that compound tuple type will be private.
    
    // Function Types
    // The access level for a function type is calculated as the most restrictive access level of the function’s parameter types and return type.
    // You must specify the access level explicitly as part of the function’s definition if the function’s calculated access level doesn’t match the contextual default.
    // The example below defines a global function called someFunction(), without providing a specific access-level modifier for the function itself.
    // You might expect this function to have the default access level of “internal”, but this isn’t the case. In fact, someFunction() won’t compile as written below:

    //  func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    //    // function implementation goes here
    //  }

    // The function’s return type is a tuple type composed from two of the custom classes defined above in Custom Types.
    // One of these classes is defined as internal, and the other is defined as private.
    // Therefore, the overall access level of the compound tuple type is private (the minimum access level of the tuple’s constituent types).
    // Because the function’s return type is private, you must mark the function’s overall access level with the private modifier for the function declaration to be valid:
    
    // private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
        // function implementation goes here
    // }

    // It’s not valid to mark the definition of someFunction() with the public or internal modifiers, or to use the default setting of internal,
    // because public or internal users of the function might not have appropriate access to the private class used in the function’s return type.

    // -----------------------------------------------------------------------------
    // [🔷 Enumeration Types]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Subclassing]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Constants, Variables, Properties, and Subscripts]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Initializers]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Extensions]
    // -----------------------------------------------------------------------------

    // -----------------------------------------------------------------------------
    // [🔷 Generics & Type Aliases]
    // -----------------------------------------------------------------------------

    
    
    
}

// Experiment: know if fileprivate works per file or per definition

/// CHAT-GPT NOTE....
/// The reason "public" works differently is due to the design of Swift's access control system. When you declare a type as "public," its members default to "internal" access, meaning they can be accessed within the same module but not outside of it.
///  This design choice ensures that the internal implementation details of a type are not inadvertently exposed as part of the public API.
/// On the other hand, when a type is declared as "open," it is intended to be subclassed and overridden outside of the module where it's defined.
/// Therefore, the default access level for its members is set to "open," allowing for greater extensibility and customization.
/// This distinction allows developers to carefully control which parts of their code are accessible outside the module and which parts are open for subclassing and overriding, providing a balance between encapsulation and extensibility in Swift.

open class SomeOpenClass {                      // explicitly open class
    open var someOpenProperty = 0                // explicitly open class member
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

// This is a public class
//public class MyClass {
//    // This is a private property
//    private var privateProperty = 10
//
//    // This is a fileprivate method
//    fileprivate func filePrivateMethod() {
//        print("This is a fileprivate method")
//    }
//
//    // This is a private method
//    private func privateMethod() {
//        print("This is a private method")
//    }
//
//    // This is a public method
//    public func publicMethod() {
//        print("This is a public method")
//
//        // Accessing private property and methods within the same class
//        print(privateProperty)
//    }
//}

// Another class in the same file
//class AnotherClass {
//    // Trying to access private property and methods from a different class
//    func accessPrivateMembers() {
//        let myClass = MyClass()
//
//        // Error: 'privateProperty' is inaccessible due to 'private' protection level
//        print(myClass.privateProperty)
//
//        // Error: 'filePrivateMethod()' is inaccessible due to 'fileprivate' protection level
//        myClass.filePrivateMethod()
//
//        // Error: 'privateMethod()' is inaccessible due to 'private' protection level
//        myClass.privateMethod()
//    }
//}


// NOTE: from chatgpt, here's an example that demonstrates the access level requirements for raw values and associated values in Swift enums:
//public struct Location {
//    public var latitude: Double
//    public var longitude: Double
//}
//
//public enum Place {
//    case city(name: String, location: Location)
//    case countryside(name: String, location: Location)
//}
//
//let newYork = Location(latitude: 40.7128, longitude: -74.0060)
//let city = Place.city(name: "New York City", location: newYork)
