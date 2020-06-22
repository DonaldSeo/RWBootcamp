//
//  Compatibility.swift
//  CompatibilitySlider-Start
//
//  Created by Donald Seo on 2020-06-22.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

struct Compatibility {
    var compatibilityItems = ["Cats", "Dogs", "Video Game", "Exercise"]
    var person1 = Person(id: 1, items: [:])
    var person2 = Person(id: 2, items: [:])
    
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
