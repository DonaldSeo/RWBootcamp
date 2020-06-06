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

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var targetTextLabel: UILabel!
  @IBOutlet weak var guessLabel: UILabel!
  
  @IBOutlet weak var redLabel: UILabel!
  @IBOutlet weak var greenLabel: UILabel!
  @IBOutlet weak var blueLabel: UILabel!
  
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  
  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  
  var game = BullsEyeGame()
  var rgb = RGB()
  var targetRGB = RGB()
    

  
  @IBAction func aSliderMoved(sender: UISlider) {
    
    switch sender {
    case redSlider:
        let roundedValue = redSlider.value.rounded()
        rgb.r = Int(roundedValue)
        redLabel.text = String(rgb.r)
    case greenSlider:
        let roundedValue = greenSlider.value.rounded()
        rgb.g = Int(roundedValue)
        greenLabel.text = String(rgb.g)
    case blueSlider:
        let roundedValue = blueSlider.value.rounded()
        rgb.b = Int(roundedValue)
        blueLabel.text = String(rgb.b)
    default:
        print("this will never happen")
    }
    
//    print(targetRGB)
    guessLabel.backgroundColor = UIColor.init(rgbStruct: rgb)
    
//    print(Int(rgb.difference(target: targetRGB)*100.rounded()))
    print(rgb.difference(target: targetRGB)*100)
  }
  
  @IBAction func showAlert(sender: AnyObject) {
    
    
    //
    // calculate difference
    let difference = rgb.difference(target: targetRGB)
    let (title, points) = game.calculateScore(with: difference)
    //display and points earned in alertview
    
    let message = "you scored \(points) points!"
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //call startNewRound and updateView in action
    let action = UIAlertAction(title: "OK", style: .default) { (action) in
        self.game.startNewRound()
        self.rgb.setDefault()
        self.updateView()
    }
    
    //present
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  @IBAction func startOver(sender: AnyObject) {
    game.resetGame()
    game.startNewRound()
    rgb.setDefault()
    updateView()

  }
  
  func updateView() {
    //resetting rgb sliders and labels to default
    redLabel.text = String(rgb.r)
    greenLabel.text = String(rgb.r)
    blueLabel.text = String(rgb.r)
    redSlider.value = Float(rgb.r)
    greenSlider.value = Float(rgb.g)
    blueSlider.value = Float(rgb.b)
    
    //resetting guessLabel's background color to default
    guessLabel.backgroundColor = UIColor.init(rgbStruct: rgb)
    
    //set target label's background color with random rgb values
    targetRGB = game.newTargetRGB()
    targetLabel.backgroundColor = UIColor.init(rgbStruct: targetRGB)
    
    
    //reset round & score label
    scoreLabel.text = "Score: \(String(game.score))"
    roundLabel.text = "Round: \(String(game.round))"

  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    game.startNewRound()
    updateView()

  }
}

