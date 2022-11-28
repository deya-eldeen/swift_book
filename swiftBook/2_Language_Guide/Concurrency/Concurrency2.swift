//
//  Concurrency.swift
//  swiftBook
//
//  Created by Deya on 23/02/2022.
//  Copyright © 2022 DeyaEldeen. All rights reserved.
//

import Foundation
//GCD: is a low-level C-based API interacts directly with Unix level of the system.
//NSOperation and NSOperationQueue are high-level Objective-C classes.
//Concurrency is execution of work in parallel.
import Foundation

extension Thread {
    class func printCurrent() {
        print("\r🧵: \(Thread.current)\r" + "⛓ : \(OperationQueue.current?.underlyingQueue?.label ?? "None")\r")
    }
}

//let key = DispatchSpecificKey<Any>()


//
//good article
//
//https://medium.com/flawless-app-stories/concurrency-visualized-part-1-sync-vs-async-c433ff7b3ebe
//
//

// a global dispatchQueue is concurrent by nature.
