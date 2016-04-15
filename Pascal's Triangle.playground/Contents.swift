//: Playground - noun: a place where people can play

//
//  Pascal's Triangle
//
/*  Copyright (c) 2016 by Scott Grant
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify,
 merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit

// Let's use Swift's new error handling...
enum PascalError : ErrorType {
    case NumberIsYUGE
    case NumberIsTooSmall
}

func pascal(iterations:Int) throws {
    
    if (iterations <= 0) {
        throw PascalError.NumberIsTooSmall
    }
    
    print("1")
    if (iterations == 1) {
        return
    }
    
    print("1, 1")
    if (iterations == 2) {
        return
    }
    
    var currentRow = [1, 1] // For iterations of 3 or more, we'll use our algorithm...
    for _ in (3...iterations) {
        var nextRow = [Int]() // Array for holding our next row's values
        nextRow.append(1)     // Always start row with 1
        print("\(nextRow.last!), ", terminator: "")
        
        // Run through the currentRow, add the value at the
        // current rowIndex to the value at the next index...
        for rowIndex in 0..<(currentRow.count - 1) {
            let result = Int.addWithOverflow(currentRow[rowIndex], currentRow[rowIndex + 1])
            if (result.overflow) {
                throw PascalError.NumberIsYUGE
            }
            nextRow.append(result.0)
            print("\(result.0), ", terminator: "")
        }
        
        nextRow.append(1)     // Always end row with 1
        print("\(nextRow.last!)")
        currentRow = nextRow // Now make our nextRow the currentRow...
    }
}

// Run it through 'n' iterations.
do {
    
    try pascal(10) // Let's do 10...(you can change this to a large value
                   // or negative value to test the error handling...)
    
} catch PascalError.NumberIsYUGE {  // Using Swift error handling for a much more graceful exit...
    print("\n\nWhoa there, Sparky! These numbers are getting YUGE!")
} catch PascalError.NumberIsTooSmall {
    print("\n\nUmmmm...you need to enter something bigger than 0.")
} catch {
    print("\n\nSorry, I choked!")
}