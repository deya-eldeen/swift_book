//
//  Concurrency_Azzam.swift
//  swiftBook
//
//  Created by Deya Elkhawaldeh on 27/11/2022.
//  Copyright © 2022 DeyaEldeen. All rights reserved.
//

import Foundation

// Concurrency is hard
// asyncDetached
// Task.detached
// Main/UI Thread
// the main thread is a sequential thread
// main thread is a serial queue (FIFO)
// global queue, concurrent
    // user interactive: animations
    // user initiated:
    // default:
    // utility:
    // background:
    // unspecified:


class AzzamConcurrency {

    let q1 = DispatchQueue(label: "first")
    let q2 = DispatchQueue(label: "second")

    // they will start and finish in the same order
    
    
    func start() {
        let cq = DispatchQueue(label: "concurrent", attributes: .concurrent)

        cq.async {
            
        }

        cq.async {
            
        }

        cq.async {
            
        }
    }
    
    // they will start in the same order, but can finish in any order

}




