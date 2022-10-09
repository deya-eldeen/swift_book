//
//  Problem_002.swift
//  swiftBook
//
//  Created by Deya on 08/09/2022.
//  Copyright © 2022 DeyaEldeen. All rights reserved.
//

import Foundation

// Time: O(n)
func isValidSubsequence_solution1(_ array: [Int], _ sequence: [Int]) -> Bool {
    
    // sequence is empty
    if (sequence.count == 0) {
      return false
    }
    
    // if arrays are equal, directly return true.
    if (array == sequence) {
        return true
    }
    
    // the sequence is larger than the array, return false.
    if (sequence.count > array.count) {
        return false
    }
    
    var arrIdx = 0
    var seqIdx = 0
    
    while arrIdx < array.count, seqIdx < sequence.count {
        if array[arrIdx] == sequence[seqIdx] {
            seqIdx += 1
        }
        arrIdx += 1
    }
    
    return seqIdx == sequence.count
}

// Time: O(n)
func isValidSubsequence_solution2(_ array: [Int], _ sequence: [Int]) -> Bool {
    
    // sequence is empty
    if (sequence.count == 0) {
      return false
    }
    
    // if arrays are equal, directly return true.
    if (array == sequence) {
        return true
    }
    
    // the sequence is larger than the array, return false.
    if (sequence.count > array.count) {
        return false
    }
    
    var seqIdx = 0
    
    for value in array {
        if seqIdx == sequence.count {
            break
        }
        if value == sequence[seqIdx] {
            seqIdx += 1
        }
    }
    return seqIdx == sequence.count
}

func problem_02_solutions() {
    printTimeElapsedWhenRunningCode(title:"solution1") {
        isValidSubsequence_solution1(myArray1, myArray2)
    }

    printTimeElapsedWhenRunningCode(title:"solution2") {
        isValidSubsequence_solution2(myArray1, myArray2)
    }
}

