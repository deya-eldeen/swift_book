//
//  DependencyInjectionn.swift
//  swiftBook
//
//  Created by Deya AlDeen on 10/06/2021.
//  Copyright © 2021 DeyaEldeen. All rights reserved.
//

import Foundation

// Dependency injection means giving an object its instance variables. Really. That's it. - James Shore


//Dependency injection is nothing more than injecting dependencies into an object instead of tasking the object with the responsibility of creating its dependencies.
//Or, as James Shore puts it, you give an object its instance variables.

//What Do We Gain
//
//Raise Transparency
//
//By injecting the dependencies of an object, the responsibilities and requirements of a class or structure become more clear and transparent. By injecting a request manager into a view controller, we understand that the view controller depends on the request manager and we can assume the view controller is responsible for request managing and/or handling.
//Improve Testability
//
//Unit testing is much easier with dependency injection. Dependency injection allows developers to replace an object's dependencies with mock objects, which makes isolating behavior and setting up unit tests easier and less complicated.

// initializer injection has an advantage that it has dependencies stored as constant and private.


// Doing dependency injection with programmatic views, will not allow us to use "init injection", ...

// The “injection” refers to the passing of a dependency (a service) into the object (a client) that would use it.


//Reduce coupling.
//The code is reusable.
//The code is testable.
//Facilitates code maintenance.


//Dependency injection is such a simple thing, but for some reason the name puts people off – maybe it sounds medically invasive?

