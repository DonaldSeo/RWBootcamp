/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import Foundation

struct BullsEyeGame {  // might be class?
    
    var score = 0
    var round = 0
    var targetR = 0
    var targetG = 0
    var targetB = 0
    
    
    mutating func startNewRound() {
        round += 1
        
    }
    
    mutating func resetGame() {
        score = 0
        round = 0
    }
    
    
    mutating func newTargetRGB() -> RGB {
        
        targetR = Int.random(in: 0...255)
        targetG = Int.random(in: 0...255)
        targetB = Int.random(in: 0...255)
        return RGB(r: targetR, g: targetG, b: targetB)
    }
    
    mutating func calculateScore(with difference: Double) ->(String, Int) {
        let diff_rounded = Int(difference*100.rounded())
        var points = 100 - diff_rounded
        let title: String
        
        if diff_rounded == 0 {
            title = "Perfect!!!"
            points += 100
        } else if diff_rounded < 5 {
            title = "You Almost Had it!!"
            if diff_rounded == 1 {
                points += 50
            }
        } else if diff_rounded  < 10 {
            title = "Pretty good!!"
        } else {
            title = "Not even close.. :("
        }
        score += points
        return (title, points)
    }


}
