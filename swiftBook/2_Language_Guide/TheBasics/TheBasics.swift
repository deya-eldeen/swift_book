import Foundation

func _3_TheBasics() {
     
     /*
     
     Swift introduces advanced types not found in Objective-C, such as tuples.
     Tuples enable you to create and pass around groupings of values.
     You can use a tuple to return multiple values from a function as a single compound value.and
     
     Swift also introduces optional types, which handle the absence of a value.
     Optionals say either “there is a value, and it equals x” or “there isn’t a value at all
     Using optionals is similar to using nil with pointers in Objective-C
     but they work for any type, not just classes. Not only are optionals safer and more expressive than nil pointers in Objective-C
     they are at the heart of many of Swift’s most powerful features.
     
     let maxNumberOfLoginAttempts = 10
     var loginAttempts = 0
     
     type annotation
     
     “let π = 3.14159
     let 你好 = "你好世界"
     let 🐶🐮 = "dogcow”
     
    interpolation
    print("The current value of friendlyWelcome is \(friendlyWelcome)")
     
     comments // /* */
     
     On a 32-bit platform, Int is the same size as Int32
     On a 64-bit platform, Int is the same size as Int64
     
     */
    
    var red, green, blue: Double
    
    let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
    let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8
    
    let decimalInteger = 17
    let binaryInteger = 0b10001       // 17 in binary notation
    let octalInteger = 0o21           // 17 in octal notation
    let hexadecimalInteger = 0x11     // 17 in hexadecimal notation
    
    
    /*
     
     let cannotBeNegative: UInt8 = -1
    // UInt8 cannot store negative numbers, and so this will report an error
    let tooBig: Int8 = Int8.max + 1
    // Int8 cannot store a number larger than its maximum value,
    // and so this will also report an error”
    
     */
    
    
    
    /*Type aliases are useful when you want to refer to an existing type by a name that is contextually more appropriate, such as when working with data of a specific size from an external source:
    
    typealias AudioSample = UInt16
    Once you define a type alias, you can use the alias anywhere you might use the original name:
    
    var maxAmplitudeFound = AudioSample.min
    // maxAmplitudeFound is now 0”
    */
    
    
    /*
     
     Swift’s type safety prevents non-Boolean values from being substituted for Bool.
     The following example reports a compile-time error:
     
     if 1 { }
     
     
     
 
 */
    
    
    if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100
    {
        print("\(firstNumber) < \(secondNumber) < 100")
    }
    // Prints "4 < 42 < 100"
    
    if let firstNumber = Int("4")
    {
        if let secondNumber = Int("42")
        {
            if firstNumber < secondNumber && secondNumber < 100
            {
                print("\(firstNumber) < \(secondNumber) < 100")
            }
        }
    }
    // Prints "4 < 42 < 100”
    
    
    
    /*
     In this example, (404, "Not Found") is a tuple that describes an HTTP status code.
     
     let http404Error = (404, "Not Found")
     let (statusCode, statusMessage) = http404Error
     print("The status code is \(statusCode)")
     // Prints "The status code is 404"
     print("The status message is \(statusMessage)")
     // Prints "The status message is Not Found
     
     If you only need some of the tuple’s values, ignore parts of the tuple with an underscore (_) when you decompose the tuple:
     
     let (justTheStatusCode, _) = http404Error
     print("The status code is \(justTheStatusCode)")
     // Prints "The status code is 404
     
     
     print("The status code is \(http404Error.0)")
     // Prints "The status code is 404"
     print("The status message is \(http404Error.1)")
     // Prints "The status message is Not Found
     
     let http200Status = (statusCode: 200, description: "OK")
     
     print("The status code is \(http200Status.statusCode)")
     // Prints "The status code is 200"
     print("The status message is \(http200Status.description)")
     // Prints "The status message is OK
     
     tuples are useful as return values in general
     
     */
    
    
    // Optionals
    
    let possibleNumber = "123"
    let convertedNumber = Int(possibleNumber)
    // convertedNumber is inferred to be of type "Int?", or "optional Int
    
    /*
    Because the initializer might fail, it returns an optional Int, 
    rather than an Int. An optional Int is written as Int?, not Int.
    The question mark indicates that the value it contains is optional,
    meaning that it might contain some Int value, or it might contain no value at all.
     
    */
    
    //You set an optional variable to a valueless state by assigning it the special value nil:
    // If you define an optional variable without providing a default value, the variable is automatically set to nil for you:
    
    var serverResponseCode: Int? = 404
    // serverResponseCode contains an actual Int value of 404
    serverResponseCode = nil
    // serverResponseCode now contains no value”
    
    
    
    // 1--- If Statements and Forced Unwrapping
    if convertedNumber != nil
    {
        print("convertedNumber contains some integer value.")
    }
    //     Prints "convertedNumber contains some integer value.”
    
    //Once you’re sure that the optional does contain a value,
    //you can access its underlying value by adding an exclamation mark (!) to the end of the optional’s name.
    //The exclamation mark effectively says, “I know that this optional definitely has a value; please use it.”
    //This is known as forced unwrapping of the optional’s value:”
    
    if convertedNumber != nil {
        print("convertedNumber has an integer value of \(convertedNumber!).")
    }
    // Prints "convertedNumber has an integer value of 123.
    

    // 2--- Optional binding
    if let actualNumber = Int(possibleNumber)
    {
        print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
    }
    else
    {
        print("\"\(possibleNumber)\" could not be converted to an integer")
    }
    //      Prints ""123" has an integer value of 123”
    
    if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100
    {
        print("\(firstNumber) < \(secondNumber) < 100")
    }
    // Prints "4 < 42 < 100"

    if let firstNumber = Int("4")
    {
        if let secondNumber = Int("42")
        {
            if firstNumber < secondNumber && secondNumber < 100
            {
                print("\(firstNumber) < \(secondNumber) < 100")
            }
        }
    }
    // Prints "4 < 42 < 100”
    
    //Constants and variables created with optional binding in an if statement are available only within the body of the if statement.
    //In contrast, the constants and variables created with a guard statement are available in the lines of code that follow the guard statement,
    //as described in Early Exit.”
    
    //** we can also use if var, too !
    // if var actualValue
    
    
    // 3--- Implicitly unwrapped optionals
    
    //An Implicitly Unwrapped Optional is an optional that doesn't need to be unwrapped because it is done implicitly.
    //These types of optionals are declared with an ! instead of a ?
    
//    let possibleString: String!
//    print(possibleString)
    
    
    
    // SO post by Drewag
    /*
     
     When To Use An Implicitly Unwrapped Optional
     
     There are four main reasons that one would create an Implicitly Unwrapped Optional. All have to do with defining a variable that will never be accessed when nil because otherwise, the Swift compiler will always force you to explicitly unwrap an Optional.
     
     1. A Constant That Cannot Be Defined During Initialization
     
     Every member constant must have a value by the time initialization is complete. Sometimes, a constant cannot be initialized with its correct value during initialization, but it can still be guaranteed to have a value before being accessed.
     
     Using an Optional variable gets around this issue because an Optional is automatically initialized with nil and the value it will eventually contain will still be immutable. However, it can be a pain to be constantly unwrapping a variable that you know for sure is not nil. Implicitly Unwrapped Optionals achieve the same benefits as an Optional with the added benefit that one does not have to explicitly unwrap it everywhere.
     
     A great example of this is when a member variable cannot be initialized in a UIView subclass until the view is loaded:
     
     class MyView : UIView {
     @IBOutlet var button : UIButton!
     var buttonOriginalWidth : CGFloat!
     
     override func awakeFromNib() {
     self.buttonOriginalWidth = self.button.frame.size.width
     }
     }
     Here, you cannot calculate the original width of the button until the view loads, but you know that awakeFromNib will be called before any other method on the view (other than initialization). Instead of forcing the value to be explicitly unwrapped pointlessly all over your class, you can declare it as an Implicitly Unwrapped Optional.
     
     2. Interacting with an Objective-C API
     
     Every reference to an object in Objective-C is a pointer, which means that it can be nil. That means, that every interaction with an Objective-C API from Swift must use an optional where there is a reference to an object. You could use a normal Optional in every one of these cases, but if you know for sure that the reference will not be nil, you can save yourself unwrapping code by declaring it as an Implicitly Unwrapped Optional.
     
     A good example of this is a UITableViewDataSource:
     
     EDIT: UITableViewDataSource example is no longer valid. Apple refined the API and none of the parameters are optional and neither is the return value.
     
     override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? { return nil }
     Here, you know that the method will never be called without a tableView or indexPath. It would be a waste of time to check it for nil. If this were a purely Swift API, one would not declare it as an Optional at all.
     
     3. When Your App Cannot Recover From a Variable Being nil
     
     This should be extremely rare, but if your app could literally not continue to run if a variable is nil when accessed, it would be a waste of time to bother testing it for nil. Normally if you have a condition that must absolutely be true for your app to continue running, you would use an assert. An Implicitly Unwrapped Optional has an assert for nil built right into it.
     
     4. NSObject Initializers
     
     Apple does have at least one strange case of Implicitly Unwrapped Optionals. Technically, all initializers from classes that inherit from NSObject return Implicitly Unwrapped Optionals. This is because initialization in Objective-C can return nil. That means, in some cases, that you will still want to be able to test the result of initialization for nil. A perfect example of this is with UIImage if the image does not exist:
     
     var image : UIImage? = UIImage(named: "NonExistentImage")
     if image != nil {
     println("image exists")
     }
     else {
     println("image does not exist")
     }
     If you think there is a chance that your image does not exist and you can gracefully handle that scenario, you can declare the variable capturing the initialization explicitly as an Optional so that you can check it for nil. You could also use an Implicitly Unwrapped Optional here, but since you are planning to check it anyway, it is better to use a normal Optional.
     
     When Not To Use An Implicitly Unwrapped Optional
     
     1. Lazily Calculated Member Variables
     
     Sometimes you have a member variable that should never be nil, but it cannot be set to the correct value during initialization. One solution is to use an Implicitly Unwrapped Optional, but a better way is to use a lazy variable:
     
     class FileSystemItem {
     }
     
     class Directory : FileSystemItem {
     lazy var contents : [FileSystemItem] = {
     var loadedContents = [FileSystemItem]()
     // load contents and append to loadedContents
     return loadedContents
     }()
     }
     Now, the member variable contents is not initialized until the first time it is accessed. This gives the class a chance to get into the correct state before calculating the initial value.
     
     Note: This may seem to contradict #1 from above. However, there is an important distinction to be made. The buttonOriginalWidth above must be set during viewDidLoad to prevent anyone changing the buttons width before the property is accessed.
     
     2. Everywhere Else
     
     For the most part, Implicitly Unwrapped Optionals should be avoided because if used mistakenly, your entire app will crash when it is accessed while nil. If you are ever not sure about whether a variable can be nil, always default to using a normal Optional. Unwrapping a variable that is never nil certainly doesn't hurt very much.
 
     */
    
    
    
    
    
    
    // Error Handeling
    
    
    //In contrast to optionals, which can use the presence or absence of a value to communicate success or failure of a function,
    //error handling allows you to determine the underlying cause of failure, and, if necessary,
    //propagate the error to another part of your program.
    //When a function encounters an error condition, it throws an error.
    //That function’s caller can then catch the error and respond appropriately.
    
    func canThrowAnError() throws
    {
        // this function may or may not throw an error
    }
    
    do
    {
        try canThrowAnError()
        // no error was thrown
    }
    catch
    {
        // an error was thrown
    }
    
    // Assertions
    
    let age = -3
    assert(age >= 0, "A person's age cannot be less than zero")
    // this causes the assertion to trigger, because age is not >= 0”
    
    
    
}
