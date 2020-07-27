//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var soundButton: UIButton!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var clueLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var scoreLabel: UILabel!

  var clues: [Clue] = []
  var correctAnswerClue: Clue?
  var points: Int = 0



  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    getClues()
    
    self.scoreLabel.text = "\(self.points)"

    if SoundManager.shared.isSoundEnabled == false {
        soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
    } else {
        soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
    }
    if SoundManager.shared.isSoundEnabled == true {
      SoundManager.shared.playSound()
    }
    
}
  
  func getClues() {
    Networking.sharedInstance.getRandomCategory(completion: { (categoryId) in

      guard let id = categoryId else { return }
      Networking.sharedInstance.getAllCluesInCategory(categoryId: id) { (clues) in
        DispatchQueue.main.async {
          self.clues = Array(clues.prefix(upTo: 4))
          self.setUpView()
        }
      }
    })
  }
  
  func setUpView() {
    categoryLabel.text = clues[0].category.title
    var randomClue = clues.randomElement()
    while (randomClue?.question == "") {
      randomClue = clues.randomElement()
    }
    clueLabel.text = randomClue?.question
    scoreLabel.text = "\(self.points)"
    print("here is answer \(clues.randomElement()?.answer ?? "no clues here")")
    tableView.reloadData()
  }
  
  func calculateScore(answer: Clue) {
    if answer.question == clueLabel.text {
      points += 10
      getClues()
    } else {
      getClues()
    }
  }

  @IBAction func didPressVolumeButton(_ sender: Any) {
    SoundManager.shared.toggleSoundPreference()
    if SoundManager.shared.isSoundEnabled == false {
      soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
      SoundManager.shared.stopSound()
    } else {
      soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
      SoundManager.shared.playSound()
    }
  }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return clues.count
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
    cell.textLabel?.text = clues[indexPath.row].answer
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    calculateScore(answer: clues[indexPath.row])
    tableView.deselectRow(at: indexPath, animated: true)
    
  }
}

