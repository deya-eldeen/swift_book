
import Foundation

func BasicOperators() {
    
    
//    Operators are unary, binary, or ternary:
//
//    Unary operators operate on a single target (such as -a). Unary prefix operators appear immediately before their target (such as !b), and unary postfix operators appear immediately after their target (such as c!).
//    Binary operators operate on two targets (such as 2 + 3) and are infix because they appear in between their two targets.
//    Ternary operators operate on three targets. Like C, Swift has only one ternary operator, the ternary conditional operator (a ? b : c).
//    The values that operators affect are operands. In the expression 1 + 2, the + symbol is an infix operator and its two operands are the values 1 and 2.
//
    
    let (x, y) = (1, 2)
    
    print(9 % 4)    // equals 1
    
    // The sign of b is ignored for negative values of b. This means that a % b and a % -b always give the same answer.


                                    
                                    
    let contentHeight = 40
    let hasHeader = true
    let rowHeight = contentHeight + (hasHeader ? 50 : 20)
    // rowHeight is equal to 90
    
    //The nil-coalescing operator (a ?? b) unwraps an optional a if it contains a value,
    //or returns a default value b if a is nil. The expression a is always of an optional type.
    //The expression b must match the type that is stored inside a.
    
    //The nil-coalescing operator is shorthand for the code below:
    
    //a != nil ? a! : b
    
    //The code above uses the ternary conditional operator and forced unwrapping (a!) to access the value wrapped inside a when a is not nil,
    //and to return b otherwise.
    //The nil-coalescing operator provides a more elegant way to encapsulate this conditional checking and unwrapping in
    //a concise and readable form.
    
    //If the value of a is non-nil, the value of b is not evaluated. This is known as short-circuit evaluation
    
    
    
    
    let defaultColorName = "red"
    var userDefinedColorName: String?   // defaults to nil
    var colorNameToUse = userDefinedColorName ?? defaultColorName
    // userDefinedColorName is nil, so colorNameToUse is set to the default of "red”
    
    
    
    userDefinedColorName = "green"
    colorNameToUse = userDefinedColorName ?? defaultColorName
    // userDefinedColorName is not nil, so colorNameToUse is set to "green"
    
    // a...b
    // a..<b half open ranges
    
    
    
//    5. Swift Bitwise Operators
//    In Swift, bitwise operators are used to perform operations on individual bits.
//    Operator    Description
//    &    Binary AND
//    |    Binary OR
//    ^    Binary XOR
//    ~    Binary One's Complement
//    <<    Binary Shift Left
//    >>    Binary Shift Right
//    Bitwise operators are rarely used in everyday programming. To learn more, visit Swift bitwise operators to learn more.
//
//
    
}
