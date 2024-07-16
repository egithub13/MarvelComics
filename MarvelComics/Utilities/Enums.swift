//
//  Enums.swift
//  MarvelComics
//
//  Created by eric hayes on 7/15/24.
//

import Foundation

enum MarvelAPIError: Error {
  case invalidURL
  case invalidStatusCode
  case invalidData
  case unknown(Error)
  
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "The URL was invalid. Please try again."
    case .invalidStatusCode:
      return "There was an invalid status code. Please try again."
    case .invalidData:
      return "The character data is invalid. Please try again."
    case .unknown(let error):
      return error.localizedDescription
    }
  }
}
