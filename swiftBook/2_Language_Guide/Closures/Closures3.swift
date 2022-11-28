//
//  Closures3.swift
//  swiftBook
//
//  Created by Deya on 14/03/2022.
//  Copyright © 2022 DeyaEldeen. All rights reserved.
//

import Foundation

// https://alisoftware.github.io/swift/closures/2016/07/25/closure-capture-1/

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

class Closures3 {

    // Demo functions

    // ----------------------------------------
    // Default capture semantics
    
    //That’s because the closure strongly captures the variable pokemon: as the Swift compiler sees that the closure references that pokemon variable inside the closure, it automatically captures it (strongly by default), so that this pokemon is alive as long as the closure itself is alive.

    //In this example, the closure itself gets released once it has been executed by GCD, so that’s when the pokemon’s deinit method gets called too.

    func demo1() {
        print("--------------------- DEMO 1")
        let pokemon = Pokemon(name: "Mewtwo")
        print("before closure: \(pokemon)")
        delay(1) {
            print("inside closure: \(pokemon)")
        }
        print("bye")
    }

    // ----------------------------------------
    // Captured variables are evaluated on execution
    
    // One important thing to note though is that in Swift the captured variables are evaluated at the closure execution’s time1. We could say that it captures the reference (or pointer) to the variable.

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

    // ----------------------------------------
    // What might seems odd is that this works for value types too, like Int for example:
    // Yes, the closure prints the new value of the Int — even if Int is a value type! — because it captures a reference to the variable, not the variable content itself.

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

    // ----------------------------------------
    // You can modify captured values in closures
    
    // Note that if the captured value is a var (and not a let), you can also modify the value from within the closure2.

    func demo4() {
      var value = 42
      print("before closure: \(value)")
      delay(1) {
        print("inside closure 1, before change: \(value)")
        value = 1337
        print("inside closure 1, after change: \(value)")
      }
      delay(2) {
        print("inside closure 2: \(value)")
      }
    }
    
    // ----------------------------------------
    // Capturing a variable as a constant copy

    // If you want to capture the value of a variable at the point of the closure creation, instead of having it evaluate only when the closure executes,
    // you can use a capture list.

    func demo5() {
      var value = 42
      print("before closure: \(value)")
      delay(1) { [constValue = value] in
        print("inside closure: \(constValue)")
      }
      value = 1337
      print("after closure: \(value)")
    }
    
    //    before closure: 42
    //    after closure: 1337
    //    🕑
    //    inside closure: 42
    
    // ----------------------------------------
    // Back to Pokemons
    // What we saw just above also means that if that value is a reference type — like our Pokemon class — the closure does not really strongly capture the variable reference, but rather somehow capture a copy of the original instance contained in the pokemon variable being captured.:

    func demo6() {
      var pokemon = Pokemon(name: "Pikachu")
      print("before closure: \(pokemon)")
      delay(1) { [pokemonCopy = pokemon] in
        print("inside closure: \(pokemonCopy)")
      }
      pokemon = Pokemon(name: "Mewtwo")
      print("after closure: \(pokemon)")
    }

    func demo6_equivalent() {
      var pokemon = Pokemon(name: "Pikachu")
      print("before closure: \(pokemon)")
      // here we create an intermediate variable to hold the instance
      // pointed by the variable at that point in the code:
      let pokemonCopy = pokemon
      delay(1) {
        print("inside closure: \(pokemonCopy)")
      }
      pokemon = Pokemon(name: "Mewtwo")
      print("after closure: \(pokemon)")
    }
    // In fact, using the capture list is exactly equivalent in behavior to that code above… except that this pokemonCopy intermediate variable is local to the closure and will only be accessible from within the closure body.

    // ----------------------------------------
    // Mixing it all

    func demo7() {
      var pokemon = Pokemon(name: "Mew")
      print("➡️ Initial pokemon is \(pokemon)")

      delay(1) { [capturedPokemon = pokemon] in
        print("closure 1 — pokemon captured at creation time: \(capturedPokemon)")
        print("closure 1 — variable evaluated at execution time: \(pokemon)")
        pokemon = Pokemon(name: "Pikachu")
        print("closure 1 - pokemon has been now set to \(pokemon)")
      }

      pokemon = Pokemon(name: "Mewtwo")
      print("🔄 pokemon changed to \(pokemon)")

      delay(2) { [capturedPokemon = pokemon] in
        print("closure 2 — pokemon captured at creation time: \(capturedPokemon)")
        print("closure 2 — variable evaluated at execution time: \(pokemon)")
        pokemon = Pokemon(name: "Charizard")
        print("closure 2 - value has been now set to \(pokemon)")
      }
    }
    
//    ➡️ Initial pokemon is <Pokemon Mew>
//    🔄 pokemon changed to <Pokemon Mewtwo>
//    🕑
//    closure 1 — pokemon captured at creation time: <Pokemon Mew>
//    closure 1 — variable evaluated at execution time: <Pokemon Mewtwo>
//    closure 1 - pokemon has been now set to <Pokemon Pikachu>
//    <Pokemon Mew> escaped!
//    🕑
//    closure 2 — pokemon captured at creation time: <Pokemon Mewtwo>
//    closure 2 — variable evaluated at execution time: <Pokemon Pikachu>
//    <Pokemon Pikachu> escaped!
//    closure 2 - value has been now set to <Pokemon Charizard>
//    <Pokemon Mewtwo> escaped!
//    <Pokemon Charizard> escaped!

    

    
}
