//
//  Bitwise.swift
//  swiftBook
//
//  Created by Deya on 27/02/2022.
//  Copyright © 2022 DeyaEldeen. All rights reserved.
//


extension Int {
    
    var binaryDescription: String {
        var binaryString = ""
        var internalNumber = self
        for _ in (1...self.bitWidth) {
            binaryString.insert(contentsOf: "\(internalNumber & 1)", at: binaryString.startIndex)
            internalNumber >>= 1
        }
        return "0b " + binaryString
    }
    
}

func bitwise_example() {
    
    let x1 = 0x1
    let x2 = 0x2

    print("x1\t", x1.binaryDescription )
    print("x2\t", x2.binaryDescription )
    
    let binary_and = (x1 & x2)
    let binary_or = (x1 | x2)
    let binary_xor = (x1 ^ x2)
    let binary_complement = (~x1)
    let binary_shiftL = (x1 << 1)
    let binary_shiftR = (x1 >> 1)

    print("&\t",  binary_and.binaryDescription )
    print("|\t", binary_or.binaryDescription )
    
    print("^\t", binary_xor.binaryDescription )
    print("~\t", binary_complement.binaryDescription )
    print("<<\t", binary_shiftL.binaryDescription )
    print(">>\t", binary_shiftR.binaryDescription )
    
}

















//////////////////////////////////
///


//func FastInvSqrt(x: Float) {
//    let xhalf: Float = 0.5 * x;
//    let i = *(int*)&x;         // evil floating point bit level hacking
//  i = 0x5f3759df - (i >> 1);  // what the fuck?
//  x = *(float*)&i;
//  x = x*(1.5f-(xhalf*x*x));
//  return x;
//}


//let a = 4012
//let b = 8100
//let c = 9100
//
//func dirtyHash(a: Int, b: Int, c: Int) -> Int{
//    return ( a ^ b ^ c ^ 9999)
//}
//
//let hashed = dirtyHash(a: a, b: b, c: c)
//print("__hashed__",hashed)
//
//func isEven(number: Int) -> Bool{
//    return ((number & 0x1) == 0)
//}
//
//func isOdd(number: Int) -> Bool{
//    return ((number & 0x1) > 0)
//}
//
//print("isEven",isEven(number: 100))
//print("isOdd",isOdd(number: 100))



//bitwise_example()

let s1 = """
\r_
__
\n_
_
\r_
_
"""

let s2 = """
\n_
__
\r_
_
\n_
_
"""

let s3 = "_\n___\r__\n__"
let s4 = "_\r___\n__\r__"

//print(">>>>",s3)
//print(">>>>",s4)

