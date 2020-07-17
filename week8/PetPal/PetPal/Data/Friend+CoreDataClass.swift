//
//  Friend+CoreDataClass.swift
//  PetPal
//
//  Created by Donald Seo on 2020-07-17.
//  Copyright © 2020 Razeware. All rights reserved.
//
//

import Foundation
import CoreData


public class Friend: NSManagedObject {

  var age: Int {
    if let dob = dob as Date? {
      return Calendar.current.dateComponents([.year], from: dob, to: Date()).year!
    }
    return 0
  }
  
}
