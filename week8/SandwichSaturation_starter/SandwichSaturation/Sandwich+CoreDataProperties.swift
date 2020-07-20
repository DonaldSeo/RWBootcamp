//
//  Sandwich+CoreDataProperties.swift
//  SandwichSaturation
//
//  Created by Donald Seo on 2020-07-19.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//
//

import Foundation
import CoreData


extension Sandwich {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sandwich> {
        return NSFetchRequest<Sandwich>(entityName: "Sandwich")
    }

    @NSManaged public var image: String
    @NSManaged public var name: String
    @NSManaged public var sauceAmount: SauceAmountModel

}
