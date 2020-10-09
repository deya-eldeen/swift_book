
import Foundation

func _07_ControlFlow()
{
    //Swift’s switch statement is considerably more powerful than its counterpart in many C-like languages. Cases can match many different patterns, including interval matches, tuples, and casts to a specific type. Matched values in a switch case can be bound to temporary constants or variables for use within the case’s body, and complex matching conditions can be expressed with a where clause for each case.
    
    let names = ["Anna", "Alex", "Brian", "Jack"]
    for name in names {
        print("Hello, \(name)!")
    }
    // Hello, Anna!
    // Hello, Alex!
    // Hello, Brian!
    // Hello, Jack!”
    
    
    let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
    for (animalName, legCount) in numberOfLegs {
        print("\(animalName)s have \(legCount) legs")
    }
    
    
    for index in 1...5 {
        print("\(index) times 5 is \(index * 5)")
    }
    // 1 times 5 is 5
    // 2 times 5 is 10
    // 3 times 5 is 15
    // 4 times 5 is 20
    // 5 times 5 is 25
    
    
    
    let base = 3
    let power = 10
    var answer = 1
    for _ in 1...power {
        answer *= base
    }
    print("\(base) to the power of \(power) is \(answer)")
    // Prints "3 to the power of 10 is 59049
    
    //The example above calculates the value of one number to the power of another (in this case, 3 to the power of 10). It multiplies a starting value of 1 (that is, 3 to the power of 0) by 3, ten times, using a closed range that starts with 1 and ends with 10. For this calculation, the individual counter values each time through the loop are unnecessary—the code simply executes the loop the correct number of times. The underscore character (_) used in place of a loop variable causes the individual values to be ignored and does not provide access to the current value during each iteration of the loop.
    
    let minutes = 60
    for tickMark in 0..<minutes {
        // render the tick mark each minute (60 times)
    }
    
    let minuteInterval = 5
    for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
        // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
    }
    
    let hours = 12
    let hourInterval = 3
    for tickMark in stride(from: 3, through: hours, by: hourInterval) {
        // render the tick mark every 3 hours (3, 6, 9, 12)
    }
    
    //
    //
    // while loops are not tidy in swift book, .. should use another source
    //
    //
    
    var temperatureInFahrenheit = 30
    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    }
    // Prints "It's very cold. Consider wearing a scarf.
    
    temperatureInFahrenheit = 40
    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    } else {
        print("It's not that cold. Wear a t-shirt.")
    }
    // Prints "It's not that cold. Wear a t-shirt.
    
    temperatureInFahrenheit = 90
    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    } else if temperatureInFahrenheit >= 86 {
        print("It's really warm. Don't forget to wear sunscreen.")
    } else {
        print("It's not that cold. Wear a t-shirt.")
    }
    // Prints "It's really warm. Don't forget to wear sunscreen.
    
    temperatureInFahrenheit = 72
    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    } else if temperatureInFahrenheit >= 86 {
        print("It's really warm. Don't forget to wear sunscreen.")
    }
    
    //A switch statement considers a value and compares it against several possible matching patterns. It then executes an appropriate block of code, based on the first pattern that matches successfully. A switch statement provides an alternative to the if statement for responding to multiple potential states.”
    
    let someCharacter: Character = "z"
    switch someCharacter {
    case "a":
        print("The first letter of the alphabet")
    case "z":
        print("The last letter of the alphabet")
    default:
        print("Some other character")
    }
    // Prints "The last letter of the alphabet
    
    //In contrast with switch statements in C and Objective-C, switch statements in Swift do not fall through the bottom of each case and into the next one by default. Instead, the entire switch statement finishes its execution as soon as the first matching switch case is completed, without requiring an explicit break statement. This makes the switch statement safer and easier to use than the one in C and avoids executing more than one switch case by mistake.
    
    /*
    let anotherCharacter: Character = "a"
    switch anotherCharacter {
    case "a": // Invalid, the case has an empty body
    case "A":
        print("The letter A")
    default:
        print("Not the letter A")
    }
    // This will report a compile-time error.”
    */
    
    let anotherCharacter: Character = "a"
    switch anotherCharacter {
    case "a", "A":
        print("The letter A")
    default:
        print("Not the letter A")
    }
    // Prints "The letter A
    

    
    let approximateCount = 62
    let countedThings = "moons orbiting Saturn"
    let naturalCount: String
    switch approximateCount {
    case 0:
        naturalCount = "no"
    case 1..<5:
        naturalCount = "a few"
    case 5..<12:
        naturalCount = "several"
    case 12..<100:
        naturalCount = "dozens of"
    case 100..<1000:
        naturalCount = "hundreds of"
    default:
        naturalCount = "many"
    }
    print("There are \(naturalCount) \(countedThings).")
    // Prints "There are dozens of moons orbiting Saturn.
    
    
    let somePoint = (1, 1)
    switch somePoint {
    case (0, 0):
        print("\(somePoint) is at the origin")
    case (_, 0):
        print("\(somePoint) is on the x-axis")
    case (0, _):
        print("\(somePoint) is on the y-axis")
    case (-2...2, -2...2):
        print("\(somePoint) is inside the box")
    default:
        print("\(somePoint) is outside of the box")
    }
    // Prints "(1, 1) is inside the box
    

    
    //value binding
    let anotherPoint = (2, 0)
    switch anotherPoint {
    case (let x, 0):
        print("on the x-axis with an x value of \(x)")
    case (0, let y):
        print("on the y-axis with a y value of \(y)")
    case let (x, y):
        print("somewhere else at (\(x), \(y))")
    }
    // Prints "on the x-axis with an x value of 2
    
    // using where
    let yetAnotherPoint = (1, -1)
    switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        print("(\(x), \(y)) is just some arbitrary point")
    }
    // Prints "(1, -1) is on the line x == -y
    
    let stillAnotherPoint = (9, 0)
    switch stillAnotherPoint {
    case (let distance, 0), (0, let distance):
        print("On an axis, \(distance) from the origin")
    default:
        print("Not on an axis")
    }
    // Prints "On an axis, 9 from the origin
    
    // Swift has five control transfer statements: continue, break, fallthrough, return, throw
    // the first three could be used in switch
    
    //Continue
    //The continue statement tells a loop to stop what it is doing and start again at the beginning of the next iteration through the loop. It says “I am done with the current loop iteration” without leaving the loop altogether.
    //
    let puzzleInput = "great minds think alike"
    var puzzleOutput = ""
    let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
    for character in puzzleInput.characters {
        if charactersToRemove.contains(character) {
            continue
        } else {
            puzzleOutput.append(character)
        }
    }
    print(puzzleOutput)
    // Prints "grtmndsthnklk
    
    //Break
    //When used inside a loop statement, break ends the loop’s execution immediately and transfers control to the code after the loop’s closing brace (}). No further code from the current iteration of the loop is executed, and no further iterations of the loop are started.

    let numberSymbol: Character = "三"  // Chinese symbol for the number 3
    var possibleIntegerValue: Int?
    switch numberSymbol {
    case "1", "١", "一", "๑":
        possibleIntegerValue = 1
    case "2", "٢", "二", "๒":
        possibleIntegerValue = 2
    case "3", "٣", "三", "๓":
        possibleIntegerValue = 3
    case "4", "٤", "四", "๔":
        possibleIntegerValue = 4
    default:
        break
    }
    if let integerValue = possibleIntegerValue {
        print("The integer value of \(numberSymbol) is \(integerValue).")
    } else {
        print("An integer value could not be found for \(numberSymbol).")
    }
    // Prints "The integer value of 三 is 3.
    
    //In Swift, switch statements don’t fall through the bottom of each case and into the next one. That is, the entire switch statement completes its execution as soon as the first matching case is completed. By contrast, C requires you to insert an explicit break statement at the end of every switch case to prevent fallthrough. Avoiding default fallthrough means that Swift switch statements are much more concise and predictable than their counterparts in C, and thus they avoid executing multiple switch cases by mistake.”
    
    
    //If you need C-style fallthrough behavior, you can opt in to this behavior on a case-by-case basis with the fallthrough keyword.”
    let integerToDescribe = 5
    var description = "The number \(integerToDescribe) is"
    switch integerToDescribe {
    case 2, 3, 5, 7, 11, 13, 17, 19:
        description += " a prime number, and also"
        fallthrough
    default:
        description += " an integer."
    }
    print(description)
    // Prints "The number 5 is a prime number, and also an integer.
    
    
    /*
    //labels
    gameLoop: while square != finalSquare {
        diceRoll += 1
        if diceRoll == 7 { diceRoll = 1 }
        switch square + diceRoll {
        case finalSquare:
            // diceRoll will move us to the final square, so the game is over
            break gameLoop
        case let newSquare where newSquare > finalSquare:
            // diceRoll will move us beyond the final square, so roll again
            continue gameLoop
        default:
            // this is a valid move, so find out its effect
            square += diceRoll
            square += board[square]
        }
    }
    print("Game over!")
    */
    
    // guard
    //guard is a new conditional statement that requires execution to exit the current block if the condition isn’t met, else is mandatory
    
    func greet(person: [String: String]) {
        guard let name = person["name"] else {
            return
        }
        
        print("Hello \(name)!")
        
        guard let location = person["location"] else {
            print("I hope the weather is nice near you.")
            return
        }
        
        print("I hope the weather is nice in \(location).")
    }
    
    greet(person: ["name": "John"])
    // Prints "Hello John!"
    // Prints "I hope the weather is nice near you."
    greet(person: ["name": "Jane", "location": "Cupertino"])
    // Prints "Hello Jane!"
    // Prints "I hope the weather is nice in Cupertino.
    
    
    // checking API availability
    if #available(iOS 10, macOS 10.12, *) {
        // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
    } else {
        // Fall back to earlier iOS and macOS APIs
    }
    
    //The availability condition above specifies that in iOS, the body of the if statement executes only in iOS 10 and later; in macOS, only in macOS 10.12 and later. The last argument, *, is required and specifies that on any other platform, the body of the if executes on the minimum deployment target specified by your target.
    
    
    
    
    
    
    
    
    
}
