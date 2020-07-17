//
//  ContentView.swift
//  Bulleseye
//
//  Created by Donald Seo on 2020-07-07.
//  Copyright © 2020 Donald Seo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State var alertIsVisible: Bool = false
  @State var sliderValue: Double = 50.0
  
  var body: some View {
    VStack {
      //target row
      Spacer()
      HStack {
        Text("Put the bullseye as close as you can to: ")
        Text("100")
      }
      Spacer()
      //slider row
      HStack {
        Text("1")
        Slider(value: self.$sliderValue, in: 1...100)
        Text("100")
      }
      Spacer()
      //button row
      Button(action: {
        print("Button pressed")
        self.alertIsVisible = true
      }) {
        Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/)
      }
      .alert(isPresented: $alertIsVisible) { () -> Alert in
        return Alert(title: Text("Hello there"), message: Text("The slider's value is \(Int(self.sliderValue.rounded(.towardZero)))"), dismissButton: .default(Text("Awesome")))
      }
      Spacer()
      HStack {
        Button(action: {}) {
          Text("Start over")
        }
        Spacer()
        Text("Score: ")
        Text("999999")
        Spacer()
        Text("Round: ")
        Text("999")
        Spacer()
        Button(action: {}) {
          Text("Info")
        }
      }.padding(.bottom, 20)
      
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
