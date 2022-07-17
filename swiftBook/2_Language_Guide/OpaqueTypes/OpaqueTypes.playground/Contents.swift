// [Opaque Types]
// ** In programming languages, an abstract type is a type in a nominative type system that cannot be instantiated directly
// ** a type that is not abstract – which can be instantiated – is called a concrete type.

// ** Opaque types mask your concrete types, this help you to hide private API and type transformation
// ** The caller will use a view (Prototype type), but swift underlying is working with the concrete type, this allows optimization at compilation time vs regular protocols.

// A function or method with an opaque return type hides its return value’s type information.
// Instead of providing a concrete type as the function’s return type, the return value is described in terms of the protocols it supports.
// Hiding type information is useful at boundaries between a module and code that calls into the module, because the underlying type of the return value can remain private.
// Unlike returning a value whose type is a protocol type, opaque types preserve type identity—the compiler has access to the type information, but clients of the module don’t.


// [The Problem That Opaque Types Solve]
//A function or method with an opaque return type hides its return value’s type information. Instead of providing a concrete type as the function’s return type, the return value is described in terms of the protocols it supports.

// [Returning an Opaque Type]

protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    func draw() -> String {
        var result: [String] = []
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}
let smallTriangle = Triangle(size: 3)
print("smallTriangle")
print(smallTriangle.draw())

// *
// **
// ***

struct FlippedShape<T: Shape>: Shape {
    var shape: T
    func draw() -> String {
        let lines = shape.draw().split(separator: "\n")
        return lines.reversed().joined(separator: "\n")
    }
}
let flippedTriangle = FlippedShape(shape: smallTriangle)
print("flippedTriangle")
print(flippedTriangle.draw())
// ***
// **
// *

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}
let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
print("joinedTriangles")
print(joinedTriangles.draw())
// *
// **
// ***
// ***
// **
// *

struct Square: Shape {
    var size: Int
    func draw() -> String {
        let line = String(repeating: "*", count: size)
        let result = Array<String>(repeating: line, count: size)
        return result.joined(separator: "\n")
    }
}

func makeTrapezoid() -> some Shape {
    let top = Triangle(size: 5)
    let middle = Square(size: 6)
    let bottom = FlippedShape(shape: top)
    let trapezoid = JoinedShape(
        top: top,
        bottom: JoinedShape(top: middle, bottom: bottom)
    )
    return trapezoid
}
let trapezoid = makeTrapezoid()
print("trapezoid")
print(trapezoid.draw())

func flip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape)
}
func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
    JoinedShape(top: top, bottom: bottom)
}


// TAKHBEES START

func flip2<T: Shape>(_ shape: T) -> Shape {
    return FlippedShape(shape: shape)
}
func join2<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> Shape {
    JoinedShape(top: top, bottom: bottom)
}



let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
print("opaqueJoinedTriangles")
print(opaqueJoinedTriangles.draw())

// this 2 postfixed variable, produces this error
// Protocol 'Shape' as a type cannot conform to the protocol itself
//let opaqueJoinedTriangles2 = join2(smallTriangle, flip2(smallTriangle))
//print("opaqueJoinedTriangles2")
//print(opaqueJoinedTriangles2.draw())

//func returnSeq<T: Comparable> () -> some Comparable {
//
//    return 1
//
//}
//
//func returnSeq2<T: Comparable>() -> T where T is Comparable {
//
//    return 1
//
//}
//
//
//let z = returnSeq()
//let z2 = returnSeq2()

// TAKHBEES END


// [Differences Between Opaque Types and Protocol Types]
