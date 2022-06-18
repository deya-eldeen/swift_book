//
//  Leet_1.swift
//  swiftBook
//
//  Created by Deya on 14/06/2022.
//  Copyright © 2022 DeyaEldeen. All rights reserved.
//

import Foundation

func Leet_001_Solution_ON2(_ nums: [Int], _ target: Int) -> [Int] {
    
    for (numIndex,left) in nums.enumerated() {
        for (newNumIndex, right) in nums.enumerated() {
            if (numIndex == newNumIndex) { continue }
            if ( (left + right) == target) {
                return [numIndex, newNumIndex]
            }
        }
    }
    
    return []
    
}

func Leet_001_Solution_ON1(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int: Int]()

    for (i, num) in nums.enumerated() {
        if let lastIndex = dict[target - num] {
            return [lastIndex, i]
        }

        dict[num] = i
        print("i",i,dict)
    }

    fatalError("No valid outputs")
}

func Leet_1() {
    let nums = [-1,-2,-5,0,1,2,3,4,5,6,7,8,9]
    let target = 10

    let sON2 = Leet_001_Solution_ON2(nums, target)
    let sON1 = Leet_001_Solution_ON1(nums, target)

    print("sON1",sON1)
    print("sON2",sON2)

    let dictionary = [10:1, 11:2]

    if let z = dictionary[12] {
        print("z",z)
    }

}
