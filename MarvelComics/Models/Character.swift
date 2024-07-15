//
//  Character.swift
//  MarvelComics
//
//  Created by eric hayes on 7/15/24.
//

import Foundation

struct CharacterDataWrapper: Decodable {
  var attributionText: String
  var data: CharacterDataContainer
}

struct CharacterDataContainer: Decodable {
  var offset: Int?
  var limit: Int?
  var results: [Character]
}

struct Character: Decodable, Identifiable {
  var id: Int
  var name: String
  var description: String
  var thumbnail: Thumbnail
  
}

struct Thumbnail: Decodable {
  var path: String
  var ext: String
  
  private enum CodingKeys: String, CodingKey {
    case path
    case ext = "extension"
  }
}
