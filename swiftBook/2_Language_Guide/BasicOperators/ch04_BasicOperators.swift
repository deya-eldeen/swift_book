
import Foundation

func _4_BasicOperators()
{
    let (x, y) = (1, 2)
    
    print(9 % 4)    // equals 1
    
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
    
}
