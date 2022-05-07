import Cocoa

// https://alisoftware.github.io/swift/closures/2016/07/25/closure-capture-1/

// Class & Helper
class Pokemon: CustomDebugStringConvertible {
    let name: String
    init(name: String) {
        self.name = name
    }
    var debugDescription: String { return "<Pokemon \(name)>" }
    deinit { print("\(self) escaped!") }
}

func delay(_ seconds: Int, closure: @escaping ()->()) {
    let time = DispatchTime.now() + .seconds(seconds)
    DispatchQueue.main.asyncAfter(deadline: time) {
        print("🕑")
        closure()
    }
}

// Demo functions

func demo1() {
    print("--------------------- DEMO 1")
    let pokemon = Pokemon(name: "Mewtwo")
    print("before closure: \(pokemon)")
    delay(1) {
        print("inside closure: \(pokemon)")
    }
    print("bye")
}

func demo2() {
    print("---------------------  DEMO 2")
    var pokemon = Pokemon(name: "Pikachu")
    print("before closure: \(pokemon)")
    delay(1) {
        print("inside closure: \(pokemon)")
    }
    pokemon = Pokemon(name: "Mewtwo")
    print("after closure: \(pokemon)")
}

func demo3() {
    print("---------------------  DEMO 3")
    var value = 42
    print("before closure: \(value)")
    delay(1) {
        print("inside closure: \(value)")
    }
    value = 1337
    print("after closure: \(value)")
}


// Run Demos
let delayBetweenDemos = 1
delay(delayBetweenDemos, closure: {
    demo1()
    delay(delayBetweenDemos) {
        demo2()
        delay(delayBetweenDemos) {
            demo3()
        }
    }
})

