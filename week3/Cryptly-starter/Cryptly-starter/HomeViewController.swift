/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class HomeViewController: UIViewController{

  

  @IBOutlet weak var view1: CustomView!
  @IBOutlet weak var view2: CustomView!
  @IBOutlet weak var view3: CustomView!
  
  @IBOutlet weak var mostFallingView: CustomView!
  @IBOutlet weak var mostRisingView: CustomView!
  
  @IBOutlet weak var mostFallingViewLabel: UILabel!
  @IBOutlet weak var mostRisingViewLabel: UILabel!
  
  @IBOutlet weak var mostRisingTitleLabel: UILabel!
  @IBOutlet weak var mostFallingTitleLabel: UILabel!
  
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  @IBOutlet weak var themeSwitch: UISwitch!
  
  let cryptoData = DataGenerator.shared.generateData()
    
  override func viewDidLoad() {
    super.viewDidLoad()

    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()
    setMostFallingView()
    setMostRisingView()
    overrideUserInterfaceStyle = .light
    

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }

  
  func setupLabels() {
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    view1TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view2TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
  }
  
  func setMostFallingView() {
    guard let cryptoData = cryptoData
      else {
        return
    }
    let mostFallingCurr = cryptoData.min { $0.difference < $1.difference }
    
    mostFallingViewLabel.text = "\(mostFallingCurr!.difference)"
    
  }
  
  func setMostRisingView() {
    guard let cryptoData = cryptoData
      else {
        return
    }
    let mostRisingCurr = cryptoData.max { $0.difference < $1.difference }
    mostRisingViewLabel.text = "\(mostRisingCurr!.difference)"
    
  }
  
  func setView1Data() {
    
    guard let cryptoData = cryptoData
      else {
        return
    }
    let allCryptoCurrency = cryptoData.reduce("") { result, currency in
      return currency.name + ", " + result
    }.dropLast(2)
    
    view1TextLabel.text = String(allCryptoCurrency)

  }
  
  func setView2Data() {
    
    guard let cryptoData = cryptoData
      else {
        return
    }
    
    let incCryptoCurrency = cryptoData.filter { $0.previousValue < $0.currentValue
    }.reduce("") { (result, currency) in
      return currency.name + ", " + result
    }.dropLast(2)
    
    view2TextLabel.text = String(incCryptoCurrency)
    
  }
  
  func setView3Data() {
    
    guard let cryptoData = cryptoData
      else {
        return
    }
    let decCryptoCurrency = cryptoData.filter { $0.previousValue > $0.currentValue
    }.reduce("") { (result, currency) in
      return currency.name + ", " + result
    }.dropLast(2)
    
    view3TextLabel.text = String(decCryptoCurrency)
    
  }
  
  @IBAction func switchPressed(_ sender: Any) {
    if themeSwitch.isOn {
      ThemeManager.shared.set(theme: DarkTheme())
    } else {
      ThemeManager.shared.set(theme: LightTheme())
    }
  }
}

extension HomeViewController: Themeable {
  func registerForTheme() {
    NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: Notification.Name.init("themeChanged"), object: nil)
  }
  
  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func themeChanged() {
    guard let theme = ThemeManager.shared.currentTheme
      else {
        return
    }
    let view_list = [view1, view2, view3, mostFallingView, mostRisingView]
    let viewLabel_list = [view1TextLabel, view2TextLabel, view3TextLabel, mostRisingTitleLabel, mostFallingTitleLabel, mostFallingViewLabel, mostRisingViewLabel]
    
    view_list.forEach { $0?.backgroundColor = theme.widgetBackgroundColor }
    
    view_list.forEach { $0?.layer.borderColor = theme.borderColor.cgColor }
    
    viewLabel_list.forEach { $0?.textColor = theme.textColor }
    
    headingLabel.textColor = theme.textColor
    
    self.view.backgroundColor = theme.backgroundColor
    
  }
  
  
}
