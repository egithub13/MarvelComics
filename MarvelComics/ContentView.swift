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
    CharacterRowView(viewModel: $viewModel, showAlert: $showAlert)
  }
}

struct CharacterRowView: View {
  
  @Binding var viewModel: ContentViewModel
  @Binding var showAlert: Bool
  var smallImg = "/standard_small."
  var mediumImg = "/standard_medium."
  
  var body: some View {
    VStack {
      NavigationStack {
        List(viewModel.characters) { character in
          NavigationLink(destination: CharacterDetailView(character: character)) {
            HStack {
              if let url = URL(string: character.thumbnail.path + smallImg + character.thumbnail.ext) {
                AsyncImage(url: url) { image in
                    image
                    .image?.resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 65)
                    .clipShape(RoundedRectangle(cornerRadius: 16.0))
                }
              }
              Text(character.name)
                .fontWeight(.bold)
            }
          }
          .onAppear {
            //Use .id because character is not equatable
            if character.id == viewModel.characters.last?.id {
              //print("DEBUG: Paginate here...")
              viewModel.loadData()
            }
          }
        }
        .refreshable {
          viewModel.refresh()
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
