
    var round = 0
    var currentValue = 0
    var targetValue = 0

    mutating func startNewRound() {...}
    mutating func calculateScore() -> (String, Int) {...}
    mutating func resetGame() {...}

```

## After conforming to MVC pattern

the ViewController itself became more concise and clean. 

With BullsEyeGame model providing all game related methods, the ViewController's job is only to interact with UI Elements. 


