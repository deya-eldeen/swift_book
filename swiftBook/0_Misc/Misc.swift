//
//  Misc.swift
//  swiftBook
//
//  Created by Deya AlDeen on 01/04/2021.
//  Copyright © 2021 DeyaEldeen. All rights reserved.
//

import Foundation

func misc() {

    let someArray = [String]()
    print("someArray.first",someArray.first)
    
// wht then is now working?
// https://masterofcode.com/blog/4-ways-apples-new-programming-language-swift-enhances-safety
//    if planning?.then(analyzing)?.then(coding)?.then(testing)?.then(packages) {
//
//    }
//
//    let z1: Bool
//    let z2: Bool
//    let z3: Bool
//    let z4: Bool
//
//    if z1.then(z2) {
//
//    }
    

}

class Device {
    var name: String
    var yom: Int
    
    init(name:String, yom:Int) {
        self.name = name
        self.yom = yom
    }
    
    deinit {
        print("♦️ deinit Device",self.name)
    }
}

class Cart {
    var devices: [Device]
    
    init(devices:[Device]) {
        self.devices = devices
    }
    
    deinit {
        print("♦️ deinit Cart")
    }
}

func classStruct() {
    var d1 = Device(name: "D1", yom: 2019)
    var d2 = Device(name: "D2", yom: 2019)
    weak var d3 :Device?
    weak var d4 = Device(name: "D4", yom: 2021)

    unowned let d5 = d1

    d3 = Device(name: "D3", yom: 0)
    d2 = Device(name: "D2B", yom: 2020)
    //d5 = Device(name: "D5B", yom: 2020)

    var cart : Cart? = Cart(devices: [d1,d2,d5])
    
    
    cart = nil
}

class Account {
    // MARK: - Properties
    var plan: Plan!
}

class Plan {
    // MARK: - Properties
    private(set) unowned var account: Account
    // MARK: - Initialization
    init(account: Account) {
        self.account = account
    }
}

//“Use a class-only protocol when the behavior defined by that protocol’s requirements assumes or requires that a conforming type has reference semantics rather than value semantics.”

// an unowned reference has the added benefit of not being an Optional.  This makes them easier to manage rather than resorting to using optional binding.

// If you can guarantee that the reference will not be nil at its point of use, use unowned. If not, then you should be using weak.

// The only difference is that weak gives you an optional type in the closure. In contrast, unowned gives you an implicitly unwrapped optional in the closure.

// The advantage to using unowned self is that you don't have to unwrap an optional which can be unnecessary code if you know for sure by design, that it will never be nil. Ultimately, unowned self is used for brevity and perhaps also as a hint to future developers that you never expect a nil value.

// A case for using [weak self] in an asynchronous network request, is in a view controller where that request is used to populate the view. If the user backs out, we no longer need to populate the view, nor do we need a reference to the view controller.

//There are some great answers here. But recent changes to how Swift implements weak references should change everyone's weak self vs. unowned self usage decisions. Previously, if you needed the best performance using unowned self was superior to weak self, as long as you could be certain that self would never be nil, because accessing unowned self is much faster than accessing weak self.

//But Mike Ash has documented how Swift has updated the implementation of weak vars to use side-tables and how this substantially improves weak self performance.

//https://mikeash.com/pyblog/friday-qa-2017-09-22-swift-4-weak-references.html

//Now that there isn't a significant performance penalty to weak self, I believe we should default to using it going forward. The benefit of weak self is that it's an optional, which makes it far easier to write more correct code, it's basically the reason Swift is such a great language. You may think you know which situations are safe for the use of unowned self, but my experience reviewing lots of other developers code is, most don't. I've fixed lots of crashes where unowned self was deallocated, usually in situations where a background thread completes after a controller is deallocated.

//Bugs and crashes are the most time-consuming, painful and expensive parts of programming. Do your best to write correct code and avoid them. I recommend making it a rule to never force unwrap optionals and never use unowned self instead of weak self. You won't lose anything missing the times force unwrapping and unowned self actually are safe. But you'll gain a lot from eliminating hard to find and debug crashes and bugs.
