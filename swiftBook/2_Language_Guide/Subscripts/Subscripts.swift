
import Foundation

func _14_Subscripts()
{
    // Subscripts enable you to query instances of a type by writing one or more values in square brackets after the instance name.
    
    struct Vehicle {
        subscript(index: Int) -> Int {
            get {
                // Return an appropriate subscript value here.
                return index
            }
            set(newValue) {
                // Perform a suitable setting action here.
            }
        }
    }

    struct Animal {
        subscript(index: Int) -> Int {
            // Return an appropriate subscript value here.
            return 0
        }
    }
    
    // Here’s an example of a read-only subscript implementation,
    // which defines a TimesTable structure to represent an n-times-table of integers:
    
    struct TimesTable {
        let multiplier: Int
        subscript(index: Int) -> Int {
            return multiplier * index
        }
    }
    let threeTimesTable = TimesTable(multiplier: 3)
    print("six times three is \(threeTimesTable[6])")
    // Prints "six times three is 18"
    
    // The exact meaning of “subscript” depends on the context in which it’s used.
    // Subscripts are typically used as a shortcut for accessing the member elements in a collection, list, or sequence.
    // You are free to implement subscripts in the most appropriate way for your particular class or structure’s functionality.
    
    // For example, Swift’s Dictionary type implements a subscript to set and retrieve the values stored in a Dictionary instance.
    // You can set a value in a dictionary by providing a key of the dictionary’s key type within subscript brackets,
    // and assigning a value of the dictionary’s value type to the subscript:


    
    var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
    numberOfLegs["bird"] = 2
    
    
    // A class or structure can provide as many subscript implementations as it needs,
    // and the appropriate subscript to be used will be inferred based on the types of the value or values that are contained within the subscript brackets at the point that the subscript is used.
    // This definition of multiple subscripts is known as subscript overloading.


    
    
    
    
    struct Matrix {
        let rows: Int, columns: Int
        var grid: [Double]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(repeating: 0.0, count: rows * columns)
        }
        func indexIsValid(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }
        subscript(row: Int, column: Int) -> Double {
            get {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }
    
    var matrix = Matrix(rows: 2, columns: 2)

    matrix[0, 1] = 1.5
    matrix[1, 0] = 3.2
    
    //Type Subscripts

    // Instance subscripts, as described above, are subscripts that you call on an instance of a particular type.
    // You can also define subscripts that are called on the type itself. This kind of subscript is called a type subscript.
    // You indicate a type subscript by writing the static keyword before the subscript keyword. Classes can use the class keyword instead,
    // to allow subclasses to override the superclass’s implementation of that subscript. The example below shows how you define and call a type subscript:
    

    enum Planet: Int {
        case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
        static subscript(n: Int) -> Planet {
            return Planet(rawValue: n)!
        }
    }
    let mars = Planet[4]
    print(mars)
    
}
