//
//  ContentView.swift
//  MarvelComics
//
//  Created by eric hayes on 7/15/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      BackgroundView()
      VStack {
        Image("marvel")
      }
    }
    .background(Color.red)
  }
}

struct BackgroundView: View {
  var body: some View {
    LinearGradient(gradient: Gradient(colors: [.red, .black]),
                   startPoint: .topLeading,
                   endPoint: .bottomTrailing)
    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    
  }
}



#Preview {
    ContentView()
}
