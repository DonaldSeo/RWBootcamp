//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var compatibilityItemLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var questionLabel: UILabel!

    var currentItemIndex = 0
    var currentSliderValue: Float = 0.0
    var compatibilityCheck = Compatibility()
    var currentPerson: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        //start off with person1
        
        currentPerson = compatibilityCheck.person1
        questionLabel.text = "Person\(compatibilityCheck.person1.id), " + "how do you feel about..."
        compatibilityItemLabel.text = compatibilityCheck.compatibilityItems[0]
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value.rounded())
        currentSliderValue = sender.value.rounded()
        //get current slider value, save it in variable
    }

    @IBAction func didPressNextItemButton(_ sender: Any) {
        
        let currentItem = compatibilityCheck.compatibilityItems[currentItemIndex]
        currentPerson?.items.updateValue(currentSliderValue, forKey: currentItem)
        currentItemIndex += 1
        //need to check array index out of bound error
        if compatibilityCheck.person1.items.count == compatibilityCheck.person2.items.count {
            openResultAlertView()
        }
        checkItemIndex()

    }
    
    func checkItemIndex() {
        if currentPerson?.id == 2 && currentItemIndex == compatibilityCheck.compatibilityItems.count {
            //if person 1 and person 2 both went through all item list
            //reset each persons items dict and start over from person 1
            compatibilityCheck.person1.items.removeAll()
            compatibilityCheck.person2.items.removeAll()
            resetPerson(to: compatibilityCheck.person1)
 
        } else if currentPerson?.id == 1 && currentItemIndex == compatibilityCheck.compatibilityItems.count {
            // if only first person went through the items
            //change the turn to next person
            resetPerson(to: compatibilityCheck.person2)
            
        } else {
            //either person 1 or person 2 is going through items
            //show next in list item
            compatibilityItemLabel.text = compatibilityCheck.compatibilityItems[currentItemIndex]
        }
    }
    
    func resetPerson(to person: Person) {
        //with given person, reset labels and item index
        currentPerson = person
        currentItemIndex = 0
        questionLabel.text = "Person\(person.id), How do you feel about..."
        compatibilityItemLabel.text = compatibilityCheck.compatibilityItems[currentItemIndex]
    }

    func openResultAlertView() {
        
        let compatibilityResult = compatibilityCheck.calculateCompatibility()
        let message = "you two are \(compatibilityResult) compatible!"
        
        let alert = UIAlertController(title: "Comatibility Match Result", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)

    }

}

