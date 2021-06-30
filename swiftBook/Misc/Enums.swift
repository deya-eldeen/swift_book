//
//  Enums.swift
//  swiftBook
//
//  Created by Deya AlDeen on 30/06/2021.
//  Copyright © 2021 DeyaEldeen. All rights reserved.
//

import Foundation

enum HealthCondition {
    case ill
    case normal
    case ideal
}

// healthCase is not optional
class Enums1 {
    let healthCase: HealthCondition

    init() {
        self.healthCase = HealthCondition.normal
    }
    
    func printHealthCases2() {
        switch healthCase {
        case .ill:
            print("ill")
        case .normal:
            print("normal")
        case .ideal:
            print("ideal")
        }
    }
    
}

// healthCase is optional, so, we can use none or default
class Enums2 {
    let healthCase: HealthCondition?

    init() {
        self.healthCase = HealthCondition.normal
    }
    
    func printHealthCases() {
        switch healthCase {
        case .ill:
            print("ill")
        case .normal:
            print("normal")
        case .ideal:
            print("ideal")
        case .none:
            print("none")
        }
    }
    
    func printHealthCases2() {
        switch healthCase {
        case .ill:
            print("ill")
        case .normal:
            print("normal")
        case .ideal:
            print("ideal")
        default:
            print("default")
        }
    }
    
    // have a look at these 2 switches, the one with the @unknown default, will warn us about missing cases
    func printHealthCases3() {
        switch healthCase {
        case .ill:
            print("ill")
        default:
            print("default")
        }
    }
    
    func printHealthCases4() {
        switch healthCase {
        case .ill:
            print("ill")
        case .none:
            print("none")
        @unknown default:
            print("default")
        }
    }
    
}
