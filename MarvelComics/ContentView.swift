//
//  ContentView.swift
//  MarvelComics
//
//  Created by eric hayes on 7/15/24.
//

import SwiftUI

struct ContentView: View {
  
  @State private var viewModel = ContentViewModel()
  
  var body: some View {
    NavigationStack {
      List(viewModel.characters) { character in
        NavigationLink(destination: CharacterDetailView()) {
          Text(character.name)
        }
      }
      .navigationTitle("Marvel Characters")
      .navigationBarTitleDisplayMode(.inline)
    }
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
