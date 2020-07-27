//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

class Networking {

  static let sharedInstance = Networking()
  
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
      completion(clue[0].categoryID)
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
      completion(clues)
    }.resume()
  }
}
