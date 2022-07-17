import Cocoa

func transformToInt(_ array: [String]) -> some Sequence {
    
    let newArray = array
        .lazy
        .compactMap { Int($0) }
        .drop(while: { $0 < 10 } )
    // newArray has this gigantic dataType !!!
    // LazyDropWhileSequence<LazyMapSequence<LazyFilterSequence<LazyMapSequence<LazySequence<[String]>.Elements, Int?>>, Int>.Elements>

    //print("NA",type(of: newArray))
    
    return newArray
}


func run() {
    let transformed = transformToInt(["A","B","4","40","A","B",])

    for item in transformed {
        print("ITEM",item)
    }
}

run()
