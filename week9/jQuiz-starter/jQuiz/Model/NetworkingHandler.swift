//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit

class Networking {

  static let sharedInstance = Networking()
  let imageUrlString = "https://cdn1.edgedatg.com/aws/v2/abc/ABCUpdates/blog/2900129/8484c3386d4378d7c826e3f3690b481b/1600x900-Q90_8484c3386d4378d7c826e3f3690b481b.jpg"
  
  func getRandomCategory(completion: @escaping (Int?) -> ()) {
    guard let url = URL(string: "http://www.jservice.io/api/random") else {
      fatalError()
    }
    URLSession.shared.dataTask(with: url) {data, response, taskError in
      guard let httpResponse = response as? HTTPURLResponse,
        (200..<300).contains(httpResponse.statusCode),
        let data = data else {
          return
      }
      let decoder = JSONDecoder()
      guard let clue = try? decoder.decode([Clue].self, from: data) else {
        return
      }
      DispatchQueue.main.async {
        completion(clue[0].categoryID)
      }
    }.resume()
    
  }
  
  func getAllCluesInCategory(categoryId: Int, completion: @escaping ([Clue]) -> ()) {
    guard let url = URL(string: "http://www.jservice.io/api/clues/?category=\(categoryId)") else {
      fatalError()
    }
    URLSession.shared.dataTask(with: url) {data, response, taskError in
    guard let httpResponse = response as? HTTPURLResponse,
      (200..<300).contains(httpResponse.statusCode),
      let data = data else {
        return
      }

      let decoder = JSONDecoder()
      guard let clues = try? decoder.decode([Clue].self, from: data) else {
        print("clues are empty")
        return
      }
      DispatchQueue.main.async {
        completion(clues)
      }
    }.resume()
  }
  
  func storeImage(urlString: String, img: UIImage) {
    let path = NSTemporaryDirectory().appending(UUID().uuidString)
    let url = URL(fileURLWithPath: path)
    
    let data = img.jpegData(compressionQuality: 0.5)
    try? data?.write(to: url)
    
    var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String]
    if dict == nil {
      dict = [String:String]()
    }
    dict![urlString] = path
    UserDefaults.standard.set(dict, forKey: "ImageCache")
  }
  
  func getJeopardyImage(completion: @escaping (UIImage?) -> ()) {
    guard let imageUrl = URL(string: imageUrlString) else {
      return
    }
    
    //checking cached image here
    if let dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String] {
      if let path = dict[imageUrlString] {
        if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
          let image = UIImage(data: data)
          completion(image)
          return
        }
      }
    }
    
    URLSession.shared.downloadTask(with: imageUrl) { data, response, error in
      guard let data = data,
            let imageData = try? Data(contentsOf: data),
        let image = UIImage(data: imageData) else {
          print("failed to decode image")
          return
      }
      DispatchQueue.main.async {
        self.storeImage(urlString: self.imageUrlString, img: image)
        completion(image)
      }
      
    }.resume()
  }
}
