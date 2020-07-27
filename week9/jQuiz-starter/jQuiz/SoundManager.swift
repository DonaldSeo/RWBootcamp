//
//  SoundManager.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

//import Foundation
import AVFoundation

class SoundManager: NSObject {

  static let shared = SoundManager()
  let jeopardyAudio = URL(fileURLWithPath: Bundle.main.path(forResource: "Jeopardy-theme-song", ofType: "mp3")!)
 
  private var player: AVAudioPlayer?

  var isSoundEnabled: Bool? {
    get {
      // Since UserDefaults.standard.bool(forKey: "sound") will default to "false" if it has not been set
      // You might want to use `object`, because if an object has not been set yet it will be nil
      // Then if it's nil you know it's the user's first time launching the app
      UserDefaults.standard.object(forKey: "sound") as? Bool
    }
  }

  func playSound() {
    do {
      player = try AVAudioPlayer(contentsOf: jeopardyAudio)
      player?.numberOfLoops = -1
      player?.play()
    } catch {
      print("could not load mp3 file")
    }
  }
  
  func stopSound() {
    do {
      player = try AVAudioPlayer(contentsOf: jeopardyAudio)
      player?.stop()
    } catch {
      print("could not load mp3 file")
    }
  }

  func toggleSoundPreference() {
    if isSoundEnabled == nil {
      UserDefaults.standard.set(false, forKey: "sound")
    }
    if isSoundEnabled == false {
      UserDefaults.standard.set(true, forKey: "sound")
    } else {
      UserDefaults.standard.set(false, forKey: "sound")
    }
  }

}
