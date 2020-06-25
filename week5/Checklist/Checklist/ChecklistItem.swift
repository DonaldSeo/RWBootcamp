//
//  ChecklistItem.swift
//  Checklist
//
//  Created by Donald Seo on 2020-06-24.
//  Copyright © 2020 Donald Seo. All rights reserved.
//

import Foundation


class ChecklistItem {
    
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
}
