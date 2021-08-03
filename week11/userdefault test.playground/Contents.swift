import UIKit

let dict = [0: "this is my note", 1: "my second note"]

dict[0]

let dictarray: [[Int: String]] = [dict]

dictarray[0][1]

var workoutNoteDict = [[Int : String]]()
workoutNoteDict.insert([0 : "hello"], at: 1)

//let defaults = UserDefaults.standard
//
//defaults.set(dictarray, forKey: "userWorkoutNote")
//
//
//if let readingArray = defaults.object(forKey: "userWorkoutNote") as? [[Int: String]] {
  print(readingArray)
  print(readingArray[0][1])
}


