//
//  Enums.swift
//  MarvelComics
//
//  Created by eric hayes on 7/15/24.
//

import Foundation

enum NetworkError: Error {
  case invalidURL
  case invalidStatusCode
  case decodingError
}
