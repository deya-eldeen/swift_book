import Foundation

// [🔷 Concurrency]

// TERMS: throughput, parallelism, sequential, asynchronous, synchronous,
// Async, callbacks, concurrency, core, thread, thread pool, thread yielding,
// task, operation, queue, child task, deadlock, livelock, ...

// *** Swift has built-in support for writing asynchronous and parallel code in a structured way. Asynchronous code can be suspended and resumed later, although only one piece of the program executes at a time. Suspending and resuming code in your program lets it continue to make progress on short-term operations like updating its UI while continuing to work on long-running operations like fetching data over the network or parsing files. Parallel code means multiple pieces of code run simultaneously—for example, a computer with a four-core processor can run four pieces of code at the same time, with each core carrying out one of the tasks. A program that uses parallel and asynchronous code carries out multiple operations at a time; it suspends operations that are waiting for an external system, and makes it easier to write this code in a memory-safe way.

// Parallelism is like ancient Egypt, where the Pharaoh decides and the slaves work. Concurrency is like modern Italy, where everybody does what they want, and all use mobile phones.

// parallel programming design patterns such as master/worker or map/reduce


// Parallel programming is somewhat a special case of concurrency where separate entities collaborate to obtain high performance and throughput (generally).

// it would help to review a key difference in Asynchronous and Parallel programming. The two perform similar tasks and functions in most modern languages, but they have conceptual differences.
// each call to a parallel task spins up a brand new thread for execution.

// So you might ask yourself “Well these sound like the same deal!” In reality they are not by any means. With an asynchronous call you have no control over threads or a thread pool (which is a collection of threads) and are dependent on the system to handle the requests. With parallel programming you have much more control over the tasks chunks, and can even create a number of threads to be handled by a given number of cores in a processor. However each call to spin up or tear down a thread is very system intensive so extra care must be taken into account when creating your programming.

// keep in mind that an asynchronous calls will use threads already in use by the system and parallel programming requires the developer to break the work up, spinup, and teardown threads needed.


// The notion of concurrency should not be confused with the notion of parallelism. Parallel computations usually involve a central control which distributes the work among several processors. In concurrency we stress the independence of the components


// ** The additional scheduling flexibility from parallel or asynchronous code also comes with a cost of increased complexity. Swift lets you express your intent in a way that enables some compile-time checking—for example, you can use actors to safely access mutable state. However, adding concurrency to slow or buggy code isn’t a guarantee that it will become fast or correct. In fact, adding concurrency might even make your code harder to debug. However, using Swift’s language-level support for concurrency in code that needs to be concurrent means Swift can help you catch problems at compile time.

// ** The rest of this chapter uses the term concurrency to refer to this common combination of asynchronous and parallel code.

// ** If you’ve written concurrent code before, you might be used to working with threads. The concurrency model in Swift is built on top of threads, but you don’t interact with them directly. An asynchronous function in Swift can give up the thread that it’s running on, which lets another asynchronous function run on that thread while the first function is blocked. When an asynchronous function resumes, Swift doesn’t make any guarantee about which thread that function will run on.


// [🔷 Defining and Calling Asynchronous Functions]
// **An asynchronous function or asynchronous method is a special kind of function or method that can be suspended while it’s partway through execution.
// This is in contrast to ordinary, synchronous functions and methods, which either run to completion, throw an error, or never return. An asynchronous function or method still does one of those three things, but it can also pause in the middle when it’s waiting for something.
// Inside the body of an asynchronous function or method, you mark each of these places where execution can be suspended.

// To indicate that a function or method is asynchronous, you write the async keyword in its declaration after its parameters, similar to how you use throws to mark a throwing function. If the function or method returns a value, you write async before the return arrow (->). For example, here’s how you might fetch the names of photos in a gallery:

//func listPhotos(inGallery name: String) async -> [String] {
//    let result = // ... some asynchronous networking code ...
//    return result
//}

// ** When calling an asynchronous method, execution suspends until that method returns. You write await in front of the call to mark the possible suspension point. This is like writing try when calling a throwing function, to mark the possible change to the program’s flow if there’s an error. Inside an asynchronous method, the flow of execution is suspended only when you call another asynchronous method—suspension is never implicit or preemptive—which means every possible suspension point is marked with await.

class Concurrency1 {
    func returnData() async throws -> Data {
        return Data()
    }
    func someContext() async {
        do {
            let someFile = try await returnData()
        } catch {
            print("error", error)
        }
    }
}

// The possible suspension points in your code marked with await indicate that the current piece of code might pause execution while waiting for the asynchronous function or method to return. This is also called yielding the thread because, behind the scenes, Swift suspends the execution of your code on the current thread and runs some other code on that thread instead. Because code with await needs to be able to suspend execution, only certain places in your program can call asynchronous functions or methods:

// - Code in the body of an asynchronous function, method, or property.
// - Code in the static main() method of a structure, class, or enumeration that’s marked with @main.
// - Code in an unstructured child task, as shown in Unstructured Concurrency below.

// Code in between possible suspension points runs sequentially, without the possibility of interruption from other concurrent code.

//let firstPhoto = await listPhotos(inGallery: "Summer Vacation")[0]
//add(firstPhoto toGallery: "Road Trip")
// At this point, firstPhoto is temporarily in both galleries.
//remove(firstPhoto fromGallery: "Summer Vacation")

//There’s no way for other code to run in between the call to add(_:toGallery:) and remove(_:fromGallery:). During that time,
      
//func move(_ photoName: String, from source: String, to destination: String) {
    //add(photoName, to: destination)
    //remove(photoName, from: source)
//}
// ...
//let firstPhoto = await listPhotos(inGallery: "Summer Vacation")[0]
//move(firstPhoto, from: "Summer Vacation", to: "Road Trip")

// In the example above, because the move(_:from:to:) function is synchronous, you guarantee that it can never contain possible suspension points. In the future, if you try to add concurrent code to this function, introducing a possible suspension point, you’ll get compile-time error instead of introducing a bug.

// The Task.sleep(until:tolerance:clock:) method is useful when writing simple code to learn how concurrency works. This method does nothing, but waits at least the given number of nanoseconds before it returns. Here’s a version of the listPhotos(inGallery:) function that uses sleep(until:tolerance:clock:) to simulate waiting for a network operation:

// func listPhotos(inGallery name: String) async throws -> [String] {
// try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
// return ["IMG001", "IMG99", "IMG0404"]
// }

// [🔷 Asynchronous Sequences]
// The listPhotos(inGallery:) function in the previous section asynchronously returns the whole array at once, after all of the array’s elements are ready. Another approach is to wait for one element of the collection at a time using an asynchronous sequence. Here’s what iterating over an asynchronous sequence looks like:

class Concurrency2 {
    func start() async throws {
        let handle = FileHandle.standardInput
        for try await line in handle.bytes.lines {
            print(line)
        }
    }
}

// Instead of using an ordinary for-in loop, the example above writes for with await after it.
// Like when you call an asynchronous function or method, writing await indicates a possible suspension point.
// A for-await-in loop potentially suspends execution at the beginning of each iteration, when it’s waiting for the next element to be available.

// In the same way that you can use your own types in a for-in loop by adding conformance to the Sequence protocol, you can use your own types in a for-await-in loop by adding conformance to the AsyncSequence protocol.

// [🔷 Calling Asynchronous Functions in Parallel]

// Calling an asynchronous function with await runs only one piece of code at a time.
// While the asynchronous code is running, the caller waits for that code to finish before moving on to run the next line of code.
// For example, to fetch the first three photos from a gallery, you could await three calls to the downloadPhoto(named:) function as follows:

class Concurrency3 {

    func start() {
        
    //  let firstPhoto = await downloadPhoto(named: photoNames[0])
    //  let secondPhoto = await downloadPhoto(named: photoNames[1])
    //  let thirdPhoto = await downloadPhoto(named: photoNames[2])
    //  let photos = [firstPhoto, secondPhoto, thirdPhoto]
    //  show(photos)

    // This approach has an important drawback: Although the download is asynchronous and lets other work happen while it progresses, only one call to downloadPhoto(named:) runs at a time. Each photo downloads completely before the next one starts downloading. However, there’s no need for these operations to wait—each photo can download independently, or even at the same time.

    // To call an asynchronous function and let it run in parallel with code around it, write async in front of let when you define a constant, and then write await each time you use the constant.

    //  async let firstPhoto = downloadPhoto(named: photoNames[0])
    //  async let secondPhoto = downloadPhoto(named: photoNames[1])
    //  async let thirdPhoto = downloadPhoto(named: photoNames[2])
    //
    //  let photos = await [firstPhoto, secondPhoto, thirdPhoto]
    //  show(photos)

    // In this example, all three calls to downloadPhoto(named:) start without waiting for the previous one to complete. If there are enough system resources available, they can run at the same time. None of these function calls are marked with await because the code doesn’t suspend to wait for the function’s result. Instead, execution continues until the line where photos is defined—at that point, the program needs the results from these asynchronous calls, so you write await to pause execution until all three photos finish downloading.

    // You can also mix both of these approaches in the same code.

    }
        
}

// [🔷 Tasks and Task Groups]

//  [🔷 Unstructured Concurrency]
//  [🔷 Task Cancellation]


// [🔷 Actors]
// [🔷 Sendable Types]




