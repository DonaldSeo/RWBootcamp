//
//  ViewController.swift
//  RGB Color Picker
//
//  Created by Donald Seo on 2020-05-28.
//  Copyright © 2020 Donald Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    @IBOutlet weak var rValueLabel: UILabel!
    @IBOutlet weak var gValueLabel: UILabel!
    @IBOutlet weak var bValueLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func setColorPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        
    }
    

}

