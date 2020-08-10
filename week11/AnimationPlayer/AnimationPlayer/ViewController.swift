//
//  ViewController.swift
//  AnimationPlayer
//
//  Created by Donald Seo on 2020-08-09.
//  Copyright © 2020 Donald Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  
  @IBOutlet weak var leftPlayConstraint: NSLayoutConstraint!
  @IBOutlet weak var rightPlayConstraint: NSLayoutConstraint!
  @IBOutlet weak var upPlayConstraint: NSLayoutConstraint!
  
  
  @IBOutlet weak var animationView: UIView!
  
  var animationRule: UIViewPropertyAnimator?
  
  private let buttonOpen: CGFloat = 20
  private let buttonClosed: CGFloat = -60
  
  
  private var isDeployed = true
  private var isLaunched = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let frameSize = animationView.superview!.frame.size.width / 4
    animationView.frame.size = CGSize(width: frameSize, height: frameSize)
    animationView.center = animationView.superview!.center
    animationView.translatesAutoresizingMaskIntoConstraints = false
    toggleButtons()

  }

  func toggleButtons() {
    isDeployed.toggle()
    
    leftPlayConstraint.constant = isDeployed ? buttonOpen : buttonClosed
    rightPlayConstraint.constant = isDeployed ? buttonOpen : buttonClosed
    upPlayConstraint.constant = isDeployed ? buttonOpen : buttonClosed
    
    if isLaunched {
      UIView.animate(
        withDuration: 0.25, delay: 0,
        usingSpringWithDamping: isDeployed ? 0.6 : 1,
        initialSpringVelocity: 30,
        options: [],
        animations: {
          self.view.layoutIfNeeded()
        })
    } else {
      self.view.layoutIfNeeded()
      isLaunched = true
    }
  }

  @IBAction func playPressed(_ sender: Any) {
    if animationRule == nil {
      toggleButtons()
      return
    }
    toggleButtons()
    animationRule?.startAnimation()
    print("doing animation now")
  }
  
  func setAnimationRule() {
    if animationRule == nil {
      animationRule = UIViewPropertyAnimator(duration: TimeInterval.random(in: 0.1...3.0), curve: .easeInOut)

      animationRule!.addCompletion({ (_) in
        self.animationRule = nil
        print("Animation complete")
      })
    }
  }
  
  @IBAction func colorPressed(_ sender: Any) {
    setAnimationRule()
    animationRule?.addAnimations {
      self.animationView.backgroundColor = UIColor.random
    }
    print("color rule added")
  }
  
  @IBAction func translatePressed(_ sender: Any) {
    setAnimationRule()
    animationRule?.addAnimations {
      let containerView = self.animationView.superview!
      let offSet = self.animationView.frame.size.width/2
      let maxRangeX = containerView.frame.size.width
      let maxRangeY = containerView.frame.size.height
      
      let randomX = CGFloat.random(in: offSet...maxRangeX-offSet)
      let randomY = CGFloat.random(in: offSet...maxRangeY-offSet)
      self.animationView.center = CGPoint(x: randomX, y: randomY)
    }
    print("translation added")
    
  }
  
  @IBAction func scalePressed(_ sender: Any) {
    setAnimationRule()
    animationRule?.addAnimations {
      let randomSizeScale = CGFloat.random(in: 0.1...1)
      self.animationView.transform = CGAffineTransform(scaleX: randomSizeScale, y: randomSizeScale)
    }
    print("size scale rule added")
    
  }
  
  
  
}

extension CGFloat {
    static var random: CGFloat {
           return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static var random: UIColor {
           return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}

