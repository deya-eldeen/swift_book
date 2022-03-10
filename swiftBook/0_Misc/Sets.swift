//
//  Sets.swift
//  swiftBook
//
//  Created by Deya on 07/03/2022.
//  Copyright © 2022 DeyaEldeen. All rights reserved.
//

import Foundation

func sets_example_1() {
    
    var myKitchenItemsSet: Set = ["Mozzarella","Mushrooms","Pineapples","Tomatoes","Mushrooms","Garlic"]
    
    let shoppingListItemsSet: Set = ["Olives", "Tomatoes","Sourdough"]
    let pizzaIngredientsSet: Set = ["Sourdough","Mozzarella","Mushrooms","Tomatoes","Olives"]

    // the order of union operator is not important, even union1 and union2 show up differnlt when printing!
    let union1 = myKitchenItemsSet.union(shoppingListItemsSet)
    let union2 = shoppingListItemsSet.union(myKitchenItemsSet)
    
    // union1 and union2 show up differently when printed, but keep in mind that they are equal
    let areUnionsEqual = (union1 == union2)
    
    print("s1",union1)
    print("s2",union2)
    print("areUnionsEqual",areUnionsEqual)

    let whatINeedToBuy = shoppingListItemsSet.subtracting(myKitchenItemsSet)
    print("whatINeedToBuy",whatINeedToBuy)
    
    // buy the needed elements
    myKitchenItemsSet.formUnion(whatINeedToBuy)
    
    let canMakePizza = pizzaIngredientsSet.isSubset(of: myKitchenItemsSet)
    print("canMakePizza",canMakePizza)

    var pizzaIngredientsForMyGirlfriendSet: Set = ["Sourdough","Mozzarella","Amanita phalloides","Tomatoes","Olives"]
    let canMakePizzaForGirlfriend = pizzaIngredientsForMyGirlfriendSet.isSubset(of: union1)
    print("canMakePizzaForGirlfriend",canMakePizzaForGirlfriend)

    pizzaIngredientsForMyGirlfriendSet.remove("Amanita phalloides")
    pizzaIngredientsForMyGirlfriendSet.insert("Mushrooms")
    
    let canMakePizzaForGirlfriendAfterUpdate = pizzaIngredientsForMyGirlfriendSet.isSubset(of: union1)
    print("canMakePizzaForGirlfriendAfterUpdate",canMakePizzaForGirlfriendAfterUpdate)
    
    
    func canPreparePizza(itemsSet:Set<String>, pizzaSet:Set<String>) {
        
    }
    
    
    
}

func sets_example_2() {
    

    
}
