//
//  ViewController.swift
//  RevBullsEye
//
//  Created by Donald Seo on 2020-06-07.
//  Copyright © 2020 Donald Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var guessInputField: UITextField!
    
    @IBOutlet weak var guessSlider: UISlider!
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var game = RevBullsEyeGame()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guessInputField.delegate = self
        game.startNewRound()
        
    }
    
    func updateViews() {
        guessSlider.value = Float(game.currentValue)
        scoreLabel.text = String(game.score)
        roundLabel.text = String(game.round)
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        game.resetGame()
        game.startNewRound()
        updateViews()
    }
    
    @IBAction func hitMeButtonPressed(_ sender: UIButton) {
        
        //show alert and update score and rounds
        //do calculation on score, points
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let numRange = 1...100
        if let input = Int(textField.text!) {
            if numRange.contains(input){
                return false
            }
        }
        if (textField.text!.count >= 3 && !string.isEmpty) {
            return false
        }
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return (string.rangeOfCharacter(from: invalidCharacters) == nil) }
}

