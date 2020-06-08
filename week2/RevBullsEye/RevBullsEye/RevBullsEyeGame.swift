//
//  RevBullsEyeGame.swift
//  RevBullsEye
//
//  Created by Donald Seo on 2020-06-07.
//  Copyright © 2020 Donald Seo. All rights reserved.
//

import Foundation


struct RevBullsEyeGame {
    var score = 0
    var round = 0
    var currentValue = 0
    var targetValue = 0
    
    mutating func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
    }
    
    mutating func calculateScore() -> (String, Int) {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
 
        let title: String
        if difference == 0 {
          title = "Perfect!"
          points += 100
        } else if difference < 5 {
          title = "You almost had it!"
          if difference == 1 {
            points += 50
          }
        } else if difference < 10 {
          title = "Pretty good!"
        } else {
          title = "Not even close..."
        }
        score += points
        return (title, points)
    }
    
    mutating func resetGame() {
        round = 0
        score = 0
    }

}
