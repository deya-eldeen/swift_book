
import Foundation


func _21_TypeCasting()
{
    
    // [Type Casting]
    // Type casting in Swift is implemented with the is and as operators.
    // These two operators provide a simple and expressive way to check the type of a value or cast a value to a different type.
    
    // [Defining a Class Hierarchy for Type Casting]
    // You can use type casting with a hierarchy of classes and subclasses to check the type of a particular class instance and to cast that instance to another class within the same hierarchy.
    // The three code snippets below define a hierarchy of classes and an array containing instances of those classes, for use in an example of type casting.

    class MediaItem {
        var name: String
        init(name: String) {
            self.name = name
        }
    }

    // The next snippet defines two subclasses of MediaItem. The first subclass, Movie, encapsulates additional information about a movie or film.
    // It adds a director property on top of the base MediaItem class, with a corresponding initializer. The second subclass, Song, adds an artist property and initializer on top of the base class:

    class Movie: MediaItem {
        var director: String
        init(name: String, director: String) {
            self.director = director
            super.init(name: name)
        }
    }

    class Song: MediaItem {
        var artist: String
        init(name: String, artist: String) {
            self.artist = artist
            super.init(name: name)
        }
    }
    
    let library = [
        Movie(name: "Casablanca", director: "Michael Curtiz"),
        Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
        Movie(name: "Citizen Kane", director: "Orson Welles"),
        Song(name: "The One And Only", artist: "Chesney Hawkes"),
        Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
    ]
    // the type of "library" is inferred to be [MediaItem]
    


    //print("Media library contains \(movieCount) movies and \(songCount) songs")
    // Prints "Media library contains 2 movies and 3 songs"
    
    
    
    // [Checking Type]
    
    var movieCount = 0
    var songCount = 0

    for item in library {
        if item is Movie {
            movieCount += 1
        } else if item is Song {
            songCount += 1
        }
    }
    
    
    // [Downcasting]
    
    for item in library {
        if let movie = item as? Movie {
            print("Movie: \(movie.name), dir. \(movie.director)")
        } else if let song = item as? Song {
            print("Song: \(song.name), by \(song.artist)")
        }
    }

    // Movie: Casablanca, dir. Michael Curtiz
    // Song: Blue Suede Shoes, by Elvis Presley
    // Movie: Citizen Kane, dir. Orson Welles
    // Song: The One And Only, by Chesney Hawkes
    // Song: Never Gonna Give You Up, by Rick Astley
    
    // [Type Casting for Any and AnyObject]
    
    
    //Swift provides two special types for working with nonspecific types:

    //Any can represent an instance of any type at all, including function types.
    //AnyObject can represent an instance of any class type.

    var things: [Any] = []

    things.append(0)
    things.append(0.0)
    things.append(42)
    things.append(3.14159)
    things.append("hello")
    things.append((3.0, 5.0))
    things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
    things.append({ (name: String) -> String in "Hello, \(name)" })
    
    for thing in things {
        switch thing {
        case 0 as Int:
            print("zero as an Int")
        case 0 as Double:
            print("zero as a Double")
        case let someInt as Int:
            print("an integer value of \(someInt)")
        case let someDouble as Double where someDouble > 0:
            print("a positive double value of \(someDouble)")
        case is Double:
            print("some other double value that I don't want to print")
        case let someString as String:
            print("a string value of \"\(someString)\"")
        case let (x, y) as (Double, Double):
            print("an (x, y) point at \(x), \(y)")
        case let movie as Movie:
            print("a movie called \(movie.name), dir. \(movie.director)")
        case let stringConverter as (String) -> String:
            print(stringConverter("Michael"))
        default:
            print("something else")
        }
    }

    // zero as an Int
    // zero as a Double
    // an integer value of 42
    // a positive double value of 3.14159
    // a string value of "hello"
    // an (x, y) point at 3.0, 5.0
    // a movie called Ghostbusters, dir. Ivan Reitman
    // Hello, Michael
    
    
    
    //The Any type represents values of any type, including optional types. Swift gives you a warning if you use an optional value where a value of type Any is expected. If you really do need to use an optional value as an Any value, you can use the as operator to explicitly cast the optional to Any, as shown below.

    let optionalNumber: Int? = 3
    things.append(optionalNumber)        // Warning
    things.append(optionalNumber as Any) // No warning
    
    
}
