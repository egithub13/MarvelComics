//
//  ContentView.swift
//  MarvelComics
//
//  Created by eric hayes on 7/15/24.
//

import SwiftUI

struct ContentView: View {
  
  @State private var viewModel = ContentViewModel()
  @State private var showAlert = false
  
  var body: some View {
    CharacterRowView(viewModel: $viewModel)
  }
}

struct CharacterRowView: View {
  
  @Binding var viewModel: ContentViewModel
  var smallImg = "/standard_small."
  var mediumImg = "/standard_medium."
  
  var body: some View {
    VStack {
      NavigationStack {
        List(viewModel.characters) { character in
          NavigationLink(destination: CharacterDetailView(character: character)) {
            HStack {
              AsyncImage(url: URL(string: character.thumbnail.path + smallImg + character.thumbnail.ext))
              Text(character.name)
            }
          }
        }
        .navigationTitle("Marvel Characters")
        .navigationBarTitleDisplayMode(.inline)
      }
    }
  }
}


#Preview {
  ContentView()
}
