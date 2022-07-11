//
//  Properties_LinearInterpolation.swift
//  swiftBook
//
//  Created by Deya on 01/07/2022.
//  Copyright © 2022 DeyaEldeen. All rights reserved.
//

import Foundation

func _12_Properties_Example_1() {
    
    @propertyWrapper
    struct Constrained<Value: Comparable> {
        private var range: ClosedRange<Value>
        private var value: Value
        init(wrappedValue value: Value, _ range: ClosedRange<Value>) {
            self.value = value
            self.range = range
        }
        var wrappedValue: Value {
            get {
                return max(min(value, range.upperBound), range.lowerBound)
            }
            set {
                value = newValue
            }
        }
    }



    @Constrained(0...100)
    var score: Int = 19
    
    print("score",score)
    score = -12
    print("score",score)
    score = 99
    print("score",score)
    score = 100
    print("score",score)
    score = -1
    print("score",score)
    

    //    @propertyWrapper
    //    struct LinearInterpolated {
    //
    //    }
    
    // TODO: make a property wrapper for coordinates LAT/LON
    
    
    
}
