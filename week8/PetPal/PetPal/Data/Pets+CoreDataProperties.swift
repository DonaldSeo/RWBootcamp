//
//  Pets+CoreDataProperties.swift
//  PetPal
//
//  Created by Donald Seo on 2020-07-17.
//  Copyright © 2020 Razeware. All rights reserved.
//
//

import Foundation
import CoreData


extension Pets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pets> {
        return NSFetchRequest<Pets>(entityName: "Pet")
    }

    @NSManaged public var name: String
    @NSManaged public var kind: String
    @NSManaged public var picture: Data?
    @NSManaged public var dob: Date?
    @NSManaged public var owner: Friend

}
