//
//  Problem_003.swift
//  swiftBook
//
//  Created by Deya on 08/09/2022.
//  Copyright © 2022 DeyaEldeen. All rights reserved.
//

import Foundation

// Bad solution, appending is expensive, it's better to init an array with the length
func sortedSquaredArray_solution1(_ array: [Int]) -> [Int] {
    var sortedSquares = [Int]()
    for value in array {
        sortedSquares.append(value * value)
    }
    return sortedSquares.sorted()
}

// Time: O(nlog(n)) | Space O(n)
func sortedSquaredArray_solution2(_ array: [Int]) -> [Int] {
    var sortedSquares = Array(repeating: 0, count: array.count)
    for (idx, value) in array.enumerated() {
        sortedSquares[idx] = value * value
    }
    return sortedSquares.sorted()
}

// same as before, but higher order functions is tuned for high performance
func sortedSquaredArray_solution3(_ array: [Int]) -> [Int] {
    return array.map { $0 * $0 }.sorted()
}

// Time: O(n) | Space O(n)
func sortedSquaredArray_solution4(_ array: [Int]) -> [Int] {
    var sortedSquares = Array(repeating: 0, count: array.count)
    
    var smallerValueIdx : Int = 0
    var largerValueIdx : Int = array.count - 1
    
    for idx in stride(from: array.count - 1, through: 0, by: -1) {
        let smallerValue = array[smallerValueIdx]
        let largerValue = array[largerValueIdx]
        if abs(smallerValue) > abs(largerValue) {
            sortedSquares[idx] = smallerValue * smallerValue
            smallerValueIdx += 1
        } else {
            sortedSquares[idx] = largerValue * largerValue
            largerValueIdx -= 1
        }
    }
    return sortedSquares
}

let myArraySortedSquares1 = Array(stride(from: -5000000, through: 5000000, by: 1))
let myArraySortedSquares2 = Array(stride(from: -5000000, through: 5000000, by: 1))
let myArraySortedSquares3 = Array(stride(from: -5000000, through: 5000000, by: 1))
let myArraySortedSquares4 = Array(stride(from: -5000000, through: 5000000, by: 1))

func problem_03_solutions() {
    printTimeElapsedWhenRunningCode(title:"solution1") {
        sortedSquaredArray_solution1(myArraySortedSquares1)
    }

    printTimeElapsedWhenRunningCode(title:"solution2") {
        sortedSquaredArray_solution2(myArraySortedSquares2)
    }

    printTimeElapsedWhenRunningCode(title:"solution3") {
        sortedSquaredArray_solution3(myArraySortedSquares3)
    }

    printTimeElapsedWhenRunningCode(title:"solution4") {
        sortedSquaredArray_solution4(myArraySortedSquares4)
    }

}

