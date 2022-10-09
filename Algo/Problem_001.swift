//
//  Problem_001.swift
//  swiftBook
//
//  Created by Deya on 08/09/2022.
//  Copyright © 2022 DeyaEldeen. All rights reserved.
//

import Foundation


// Time: O(n^2)
func solution1(_ array: [Int], _ targetSum: Int) -> [Int] {
    for i in 0 ..< array.count-1 {
        for j in i+1 ..< array.count {
            if array[i] + array[j] == targetSum {
                return [array[i],array[j]]
            }
        }
    }
    return []
}

// Time: O(n^2)
func solution2(_ array: [Int], _ targetSum: Int) -> [Int] {
    for i in array {
        for j in array {
            if (i != j) && targetSum == (i + j) {
                return [i,j]
            }
        }
    }
    return []
}

// Time: O(n*log(n))
func solution3(_ array: [Int], _ targetSum: Int) -> [Int] {
    let sorted = array.sorted()
    var leftPointer = 0
    var rightPointer = sorted.count - 1
    while leftPointer < rightPointer {
        let leftMost = sorted[leftPointer]
        let rightMost = sorted[rightPointer]
        let currentSum = leftMost + rightMost
        if currentSum == targetSum {
            return [leftMost, rightMost]
        } else if currentSum < targetSum {
            leftPointer = leftPointer + 1
        } else if currentSum > targetSum {
            rightPointer = rightPointer - 1
        }
    }
    return []
}

// Time: O(n)
func solution4(_ array: [Int], _ targetSum: Int) -> [Int] {
    var numberDictionary = [Int: Bool]()
    for number in array {
        let mayMatch = targetSum - number
        if let exists = numberDictionary[mayMatch], exists {
            return [mayMatch, number]
        } else {
            numberDictionary[number] = true
        }
    }
    return []
}
let myArray = Array(stride(from: -5_000_0, through: 5_000_0, by: 9)).shuffled()

let myArray1 = Array(stride(from: -900005, through: 900005, by: 1))
let myArray2 = Array(stride(from: -900000, through: 900000, by: 1))

let targetNumber = 888

func problem_001_solutions() {
    printTimeElapsedWhenRunningCode(title:"solution1") {
        solution1(myArray, targetNumber)
    }

    printTimeElapsedWhenRunningCode(title:"solution2") {
        solution2(myArray, targetNumber)
    }

    printTimeElapsedWhenRunningCode(title:"solution3") {
        solution3(myArray, targetNumber)
    }
    printTimeElapsedWhenRunningCode(title:"solution4") {
        solution4(myArray, targetNumber)
    }
}


