//
//  InfoViewController.swift
//  RGB Color Picker
//
//  Created by Donald Seo on 2020-05-29.
//  Copyright © 2020 Donald Seo. All rights reserved.
//

import UIKit
import WebKit

class InfoViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let url = URL(string:"https://en.wikipedia.org/wiki/RGB_color_model")!
        let request = URLRequest(url: url)
        webView.load(request)


        // Do any additional setup after loading the view.
    }
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
