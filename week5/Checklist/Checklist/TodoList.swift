//
//  TodoList.swift
//  Checklist
//
//  Created by Donald Seo on 2020-06-24.
//  Copyright © 2020 Donald Seo. All rights reserved.
//

import Foundation


class TodoList {
    
    var todos: [ChecklistItem] = []
    
    init() {
        let row0Item = ChecklistItem()
        let row1Item = ChecklistItem()
        let row2Item = ChecklistItem()
        let row3Item = ChecklistItem()
        let row4Item = ChecklistItem()
        
        row0Item.text = "Take a jog"
        row1Item.text = "watch a movie"
        row2Item.text = "code an app"
        row3Item.text = "Walk the dog"
        row4Item.text = "Study design patterns"
        
        todos.append(row0Item)
        todos.append(row1Item)
        todos.append(row2Item)
        todos.append(row3Item)
        todos.append(row4Item)
    }
}
