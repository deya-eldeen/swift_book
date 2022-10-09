import Combine
import UIKit

// Ch2: Exploring Publishers and Subscribers

// CreatingyourfirstPublisher
// Subscribingtoapublisher’sstream
// Understandingthelifecycleofastream

// In Combine, everything starts with a publisher. Without a publisher, there is nothing to subscribe to and nothing to receive values from

// [basic publisher]

// this code converts an array to a publisher that emits the contents of this array one by one. It will do this as soon as an object subscribes to it

let publisher = [1, 2, 3].publisher

// if we look at the variable type, it will be Publishers.Sequence<[Int], Never>
// this type signature takes an object that conforms to Sequence as its first generic argument, and an Error as its second argument.
// Publishers: A namespace for types that serve as publishers.
// declared as: enum Publishers

// Publisher’s associated types: Output and Failure.

//Every publisher in Combine has an Output and a Failure.
// The Output of a publisher is the type of value that it produces.
// For the Publishers.Sequence publisher that we created earlier, the Output is Int.
// This means that subscribers of a sequence publisher will receive Int objects as their input.
// Even though the publisher itself takes a Sequence as its generic argument, it produces single elements as its output.
// The failure type of the Publisher.Sequence from before is Never. This means that this publisher can only complete successfully. It never emits error events.

let myUrl = URL(string: "https://www.donnywals.com")!
let publisher2 = URLSession.shared.dataTaskPublisher(for: myUrl)

//The publisher created by the preceding code is a URLSession.DataTaskPublisher. This pub- lisher conforms to the Publisher protocol just like any other publisher. Its Output is (data: Data, response: URLResponse) and its Failure is URLError.

let publisher3 = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)

//Publishers in Combine emit values and we call this a stream.
//A subscriber, as the name suggests, subscribes to the output of a publisher.

// Combine provides us with two very convenient general-purpose subscribers out of the box.
// 1- sink
// 2- assign

// I will show them one by one, starting with the sink subscriber:

// 1- sink

[1, 2, 3].publisher.sink(receiveCompletion: { completion in
    print("publisher completed: \(completion)")
}, receiveValue: {
    value in print("received a value: \(value)")
})

// The sink method that’s used in the preceding code is defined as an extension on Publisher.

// 2- assign

// The assign subscriber is also defined on Publisher and it allows us to directly assign publisher values to a property on an object:

class User {
    var email = "default"
}

var user = User()
["test@email.com"].publisher.assign(to: \.email, on: user)
// while the assign subscriber is very convenient, it’s not always feasible to use.

// Understanding the lifecycle of a stream

// In Combine, a publisher that doesn’t have a subscriber will not emit any values. This means that publishers won’t perform any work unless they have a subscriber to send the result of their work to. This is a powerful feature of Combine, and it’s one of Combine’s core principles.

// you will not need to worry about this. Both sink and assign create subscribers that are always willing to receive values so the publishers they subscribe to will immediately perform work when needed, and they will emit values as often as needed.

// The principle of making the emission of values subscriber-driven is called backpressure management.

// Both the sink and assign methods return a very important object that I have not mentioned yet.
// This object is an AnyCancellable and it’s a crucial object in the lifecycle of a subscriber.
// When an AnyCancellable is deallocated, the subscription that is associated with this object is torn down along with it.

let myNotification = Notification.Name("com.donnywals.customNotification")

func listenToNotifications() {
    NotificationCenter.default.publisher(for: myNotification)
        .sink(receiveValue: { notification in
            print("Received a notification!")
        })
    NotificationCenter.default.post(Notification(name: myNotification))
}

listenToNotifications()

// this specific notification is not received by the subscriber because the AnyCancellable is already torn down.
NotificationCenter.default.post(Notification(name: myNotification))

// You can fix this by holding on to the AnyCancellable outside of the function body.
// One way to do is by assigning the AnyCancellable to a property outside of the function scope:


// METHOD 1, using subscriptions

var subscription: AnyCancellable?

func listenToNotifications2() {
    subscription = NotificationCenter.default.publisher(for: myNotification)
        .sink(receiveValue: { notification in
            print("Received a notification 2")
        })
    NotificationCenter.default.post(Notification(name: myNotification))
}

// METHOD 2, using store
// Every AnyCancellable has a store(in:) method.
// This method takes an inout parameter which means that this method can append an AnyCancellable to the Set that you pass it.
// In this case a set of AnyCancellable objects.

var cancellables = Set<AnyCancellable>()

func listenToNotifications3() {
    NotificationCenter.default.publisher(for: myNotification)
        .sink(receiveValue: { notification in
            print("Received a notification 3")
        })
        .store(in: &cancellables)
    NotificationCenter.default.post(Notification(name: myNotification))
}

listenToNotifications2()

NotificationCenter.default.post(Notification(name: myNotification))

// When a publisher completes and you have a subscription (AnyCancellable) for that publisher stored in a set or property, the AnyCancellable is not deallocated automatically.
// Typically, you don’t need to worry about this.
// The publisher and subscription will usually do enough cleanup to prevent any major memory leaks, and the objects that hold on to the AnyCancellable objects are typically not around for the entire lifetime of your application.
// Regardless, it’s good to be aware of this and I would recommend that you keep an eye out for any potential memory problems related to persisted AnyCancellable instances even though in my experience you shouldn’t run into problems with them.

// When you subscribe to a publisher you can react to incoming values and the completion event using sink, or you can assign values directly to a key path.

// Every subscription can be wrapped in an AnyCancellable object that tears down its subscriber when it’s deallocated.
