//
//  CharacterDetailView.swift
//  MarvelComics
//
//  Created by eric hayes on 7/15/24.
//

import SwiftUI

struct CharacterDetailView: View {
  
  var character: Character
  var largeImg = "/standard_fantastic."
  
  var body: some View {
    ZStack {
      BackgroundView()
      VStack {
        Spacer()
        AsyncImage(url: URL(string: character.thumbnail.path + largeImg + character.thumbnail.ext))
          .cornerRadius(12)
        Text(character.name)
          .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
          
        Text(character.description)
          .font(.body)
          .padding(.horizontal)
          .padding(.top)
        Spacer()
        Text("Data provided by Marvel. © 2014 Marvel")
          .foregroundColor(.red)
      }
      .foregroundColor(.white)
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
  CharacterDetailView(
    character: Character(
      id: 0001,
      name: "3-D Man",
      description: "He's a 3-d generated man that does stuff",
      thumbnail: Thumbnail(
        path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", ext: "jpg")))
}
