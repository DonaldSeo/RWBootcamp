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

    var compatibilityItems = ["Cats", "Dogs", "Video Game", "Exercise"] // Add more!
    var currentItemIndex = 0
    var currentSliderValue: Float = 0.0

    var person1 = Person(id: 1, items: [:])
    var person2 = Person(id: 2, items: [:])
    var currentPerson: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        //start off with person1
        currentPerson = person1
        questionLabel.text = "Person\(person1.id), " + "how do you feel about..."
        compatibilityItemLabel.text = compatibilityItems[0]
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value.rounded())
        currentSliderValue = sender.value.rounded()
        //get current slider value, save it in variable
    }

    @IBAction func didPressNextItemButton(_ sender: Any) {
        
        let currentItem = compatibilityItems[currentItemIndex]
        currentPerson?.items.updateValue(currentSliderValue, forKey: currentItem)
        currentItemIndex += 1
        //need to check array index out of bound error
        if person1.items.count == person2.items.count {
            print(calculateCompatibility())
            //TODO
            //need to reset counters
            //need to reset person 1 person 2 items dict
        }
        checkItemIndex()

    }
    
    func checkItemIndex() {
        if currentItemIndex == compatibilityItems.count {
            currentPerson = person2
            currentItemIndex = 0
            questionLabel.text = "Person\(person2.id), " + "what do you think about..."
            compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
            
        } else {
           compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
        }
    }

    func calculateCompatibility() -> String {
        // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
        var percentagesForAllItems: [Double] = []

        for (key, person1Rating) in person1.items {
            let person2Rating = person2.items[key] ?? 0
            let difference = abs(person1Rating - person2Rating)/5.0
            percentagesForAllItems.append(Double(difference))
        }

        let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
        let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
        print(matchPercentage, "%")
        let matchString = 100 - (matchPercentage * 100).rounded()
        return "\(matchString)%"
    }

}

