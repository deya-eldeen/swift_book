//
//  StackHeap.swift
//  swiftBook
//
//  Created by Deya Elkhawaldeh on 27/06/2023.
//  Copyright © 2023 DeyaEldeen. All rights reserved.
//

import Foundation

// autoreleasepool

// NSOBject

// h, m

// interface, property attributes

/*

 In Objective-C and Swift programming languages, an autorelease pool is a mechanism used for managing the lifetime of autoreleased objects.

 In Objective-C, when you create an object using a method that starts with "alloc", "new", "copy", or "mutableCopy", you are responsible for releasing that object when you no longer need it. However, there are cases where you want an object to be automatically released at some later point without explicitly invoking the release or autorelease methods. This is where autorelease pools come into play.

 An autorelease pool is a container that temporarily holds autoreleased objects. When an object is sent the autorelease message, it is added to the innermost autorelease pool. The autorelease pool keeps track of the objects added to it and releases them when the pool itself is deallocated or when an explicit drain message is sent to the pool.

 Autorelease pools are useful in situations where you want to avoid manually managing the release of temporary objects, especially in loops or when working with large amounts of data. They help simplify memory management by deferring the release of objects until a later point.

 In Swift, autorelease pools are still available for compatibility with Objective-C code. However, Swift encourages the use of automatic reference counting (ARC) for memory management, which eliminates the need for explicit autorelease pools. With ARC, the memory management is handled automatically by the compiler, and objects are deallocated as soon as they are no longer referenced.

 It's worth noting that in modern Objective-C and Swift programming, explicit autorelease pools are typically not necessary for most scenarios. ARC and the built-in memory management mechanisms handle memory management efficiently in the majority of cases. Autorelease pools are generally used in specific situations where you need more fine-grained control over the lifetime of autoreleased objects.
 
 */


//Stack
//Heap
//Automatic Memory Allocation
//Dynamic Memory Allocation
//Static Memory Allocation
//Memory Fragmentation
//External Fragmentation
//Internal Fragmentation
//Memory Alignment
//Memory Overflows
//Memory Underflows
//Memory Leaks
//Garbage Collection
//Memory Debugging
//Memory Profiling
//Memory Segmentation
//Memory Paging
//Virtual Memory
//Paging Fault
//Swapping
//Address Space
//Memory Protection
//Memory Map
//Memory Management Unit (MMU)
//Page Table
//Page Fault
//Memory-Mapped I/O
//Aliasing
//Memory Copying
//Memory Pool
//Buddy Allocation
//First-Fit Allocation
//Best-Fit Allocation
//Worst-Fit Allocation
//Next-Fit Allocation
//Slab Allocation
//Mark and Sweep
//Reference Counting
//Generational Garbage Collection
//Copying Garbage Collection
//Tracing Garbage Collection
//Boehm-Demers-Weiser Garbage Collector (BDWGC)
//Stack Overflow
//Memory Protection Violation
//Memory Barrier
//Memory Cache
//Memory Fence
//Cache Coherency
//Cache Hit
//Cache Miss



//Memory Reclamation
//Memory Segments
//Memory Footprint
//Memory Hierarchy
//Memory Reservation
//Memory Locking
//Memory Mapping
//Memory Protection Unit (MPU)
//Memory Sharing
//Memory Coalescing
//Memory Defragmentation
//Memory Balancing
//Memory Alias Analysis
//Memory Access Patterns
//Memory Bandwidth
//Memory Interleaving
//Memory Page Coloring
//Memory Page Replacement
//Memory Page Table Entry (PTE)
//Memory Paging Policy
//Memory Thrashing
//Memory Write Buffer
//Memory Read Latency
//Memory Write Latency
//Memory Cache Line
//Memory Cache Coherence
//Memory Cache Miss Rate
//Memory Cache Hit Rate
//Memory Cache Associativity
//Memory Cache Replacement Policy
//Memory Cache Write Policy
//Memory Cache Line Size
//Memory Cache Victim Cache
//Memory Cache Inclusive/Exclusive
//Memory Cache Set-Associative
//Memory Cache Direct-Mapped
//Memory Cache Fully Associative
//Memory Cache Write-Through
//Memory Cache Write-Back
//Memory Cache Write-Allocate
//Memory Cache Non-Write-Allocate
//Memory Cache Write-Miss
//Memory Cache Write-Hit
//Memory Cache Invalidation
//Memory Cache Prefetching
//Memory Cache Tag
//Memory Cache Set Index
//Memory Cache Offset
//Memory Cache Line Fill
//Memory Cache Line Flush
