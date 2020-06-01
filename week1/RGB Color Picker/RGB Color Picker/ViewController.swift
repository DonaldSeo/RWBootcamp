//
//  ViewController.swift
//  RGB Color Picker
//
//  Created by Donald Seo on 2020-05-28.
//  Copyright © 2020 Donald Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var rSlider: UISlider!
    @IBOutlet weak var gSlider: UISlider!
    @IBOutlet weak var bSlider: UISlider!
    @IBOutlet weak var rValueLabel: UILabel!
    @IBOutlet weak var gValueLabel: UILabel!
    @IBOutlet weak var bValueLabel: UILabel!
    @IBOutlet weak var rLabel: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    
    var rValue : CGFloat = 0.0
    var gValue : CGFloat  = 0.0
    var bValue : CGFloat  = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .light
        
    }
    @IBAction func setColorPressed(_ sender: UIButton) {
        

        var textField = UITextField()
        
        let alert = UIAlertController(title: "Enter the name for your color creation", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Set Color", style: .default) {
            (action) in
            if self.rValue <= 30.0 && self.gValue <= 30.0 && self.bValue <= 30.0 {
                self.colorNameLabel.text = textField.text!
                self.colorNameLabel.textColor = UIColor.white
                self.rValueLabel.textColor = UIColor.white
                self.gValueLabel.textColor = UIColor.white
                self.bValueLabel.textColor = UIColor.white
                self.rLabel.textColor = UIColor.white
                self.gLabel.textColor = UIColor.white
                self.bLabel.textColor = UIColor.white
                self.view.backgroundColor = UIColor(red: self.rValue/255, green: self.gValue/255, blue: self.bValue/255, alpha: 1.0)
                self.containerView.backgroundColor = UIColor(red: self.rValue/255, green: self.gValue/255, blue: self.bValue/255, alpha: 1.0)
                
            } else {
                self.colorNameLabel.text = textField.text!
                self.view.backgroundColor = UIColor(red: self.rValue/255, green: self.gValue/255, blue: self.bValue/255, alpha: 1.0)
                self.containerView.backgroundColor = UIColor(red: self.rValue/255, green: self.gValue/255, blue: self.bValue/255, alpha: 1.0)
            }
            
        }

        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "enter here"
            
        }
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        
        resetAll()
        
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        containerView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        colorNameLabel.text = "Create Your Color"
        colorNameLabel.textColor = UIColor.black


    }
    
    @IBAction func redSliderMoved(_ sender: UISlider) {
        
        rValue = CGFloat(rSlider.value.rounded())
        
        rValueLabel.text = String(Int(rValue))
    }
    
    
    @IBAction func greenSliderMoved(_ sender: UISlider) {
        
        gValue = CGFloat(gSlider.value.rounded())
        
        gValueLabel.text = String(Int(gValue))
    }
    
    
    @IBAction func blueSliderMoved(_ sender: UISlider) {
        
        bValue = CGFloat(bSlider.value.rounded())
        
        bValueLabel.text = String(Int(bValue))
    }
    
    func resetAll() {
        
        rValue = CGFloat(0.0)
        gValue = CGFloat(0.0)
        bValue = CGFloat(0.0)
        rSlider.value = 0
        gSlider.value = 0
        bSlider.value = 0
        rValueLabel.text = "0"
        gValueLabel.text = "0"
        bValueLabel.text = "0"
        
        self.rValueLabel.textColor = UIColor.black
        self.gValueLabel.textColor = UIColor.black
        self.bValueLabel.textColor = UIColor.black
        self.rLabel.textColor = UIColor.black
        self.gLabel.textColor = UIColor.black
        self.bLabel.textColor = UIColor.black
        
    }
}

