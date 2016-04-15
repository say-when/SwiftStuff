//: Playground - noun: a place where people can play
//
// Fibonacci Sequence
//
/* Copyright (c) 2016 by Scott Grant
 
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
enum FibError : ErrorType {
    case NumberIsYUGE
    case NumberIsTooSmall
}

func fibonacci(iterations:Int) throws {
    
    var count = 0       // Store the current iteration count
    var lastNum = 0     // The previous number value...
    
    // Insure we have valid input...
    if (iterations <= 0) {
        throw FibError.NumberIsTooSmall // Use our new Swift error...
    }
    
    // Use recursion with Swift's inner functions to iterate the fibonacci sequence...
    func sequence(n:Int) throws {
        
        count = count + 1   // Swift 3.0 is removing the ++ operator...
        // need to use var = var + 1
        
        // Are we done?
        if (count == iterations) {
            return
        }
        
        print("\(n), ", terminator:"")
        
        // create the new value and store 'n' as the
        // previous number for the next recursive call...
        let result = Int.addWithOverflow(lastNum, n)  // Test the new value we're going to add, first, is it too YUGE?...
        if (result.overflow) {
            throw FibError.NumberIsYUGE // Yep, it's YUGE, throw our new error...
        } else {
            // Everything is good...
            let newVal = result.0 // A successful addition in addWithOverflow has
            // our result in the first value of the tuple it returned...
            lastNum = n
            try sequence(newVal)
        }
    }
    
    // '0' is a special case...
    print("0, ", terminator:"")
    
    // Start the sequence generation with '1'
    try sequence(1)
}

// Now let's try out our Fibonacci function...
do {
    
    try fibonacci(10)  // Try 10 iterations...(change it to a large value 
                       // or negative value to test the error handling)
    
} catch FibError.NumberIsYUGE {     // This is way more graceful than letting it crap out...
    print("\n\nWhoa there, Sparky! These numbers are getting YUGE!")
} catch FibError.NumberIsTooSmall {
    print("\n\nUmmm...you actually need to enter something bigger than 0.")
} catch {                           // Something else happened...
    print("\n\nSorry, I choked!")
}
