//
//  Problem_005.swift
//  swiftBook
//
//  Created by Deya on 10/09/2022.
//  Copyright © 2022 DeyaEldeen. All rights reserved.
//

//
//func coins_solution_1(_ coins: inout [Int]) -> Int {
//    let coinsCount = coins.count
//
//    var min = coins.max() ?? 0
//    print("min",min)
//    for i in 0..<coinsCount {
//        print("__min",min)
//        if(i+1 > coinsCount) { break }
//        for j in i+1..<coinsCount {
//            print("__min",min)
//            if (coins[i] + coins[j] + 1)  < (min) {
//                min = coins[i] + coins[j] + 1
//            }
//        }
//    }
//
//    return min
//}

var coins = [5,7,1,1,2,3,22]

func coins_solution_1(_ coins: inout [Int]) -> Int {
    let coinsCount = coins.count

    var sums = [Int]()
    
    for i in 0..<coinsCount {
        if(i+1 > coinsCount) { break }
        var sum = coins[i]
        
        for j in i+1..<coinsCount {
            sums.append(sum)
            sum += coins[j]
            sums.append(sum)
        }
    }
    
    sums = Array(Set(sums)).sorted()
    
    print(sums)
    
    return 0
}

func coins_solution_2(_ coins: inout [Int]) -> Int {
  if (coins.count == 0) { return 1}

  coins.sort()

  var currentChangeCreated = 0
  for coin in coins {
    if coin > currentChangeCreated + 1 {
      return currentChangeCreated + 1
    }
    currentChangeCreated += coin
  }
  
  return currentChangeCreated + 1
}




func problem_05_solutions() {
    printTimeElapsedWhenRunningCode(title:"solution11") {
        let z = coins_solution_1(&coins)
        print(z)
    }
}
