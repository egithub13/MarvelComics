//
//  ContentViewModel.swift
//  MarvelComics
//
//  Created by eric hayes on 7/15/24.
//

import Foundation
import CryptoKit
import Observation

@Observable
class ContentViewModel {
  
  var characters = [Character]()
  var error: Error?
  
  init() {
    loadData()
  }
}

// MARK: - async/await

extension ContentViewModel {
  
  @MainActor
  func fetchCharacters() async throws {
    let timestamp = "\(Date().timeIntervalSince1970)"
    let hashString = timestamp + Constants.Keys.privatekey + Constants.Keys.publickey
    let hash = hashString.MD5
    let endpoint = Constants.URLS.baseURL + "ts=\(timestamp)&apikey=\(Constants.Keys.publickey)&hash=\(hash)"
    
    do {
      guard let url = URL(string: endpoint) else {
        throw MarvelAPIError.invalidURL
      }
      
      let (data, response) = try await URLSession.shared.data(from: url)
    
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw MarvelAPIError.invalidStatusCode
      }
    
      guard let characters = try JSONDecoder().decode(CharacterDataWrapper?.self, from: data) else {
        throw MarvelAPIError.invalidData
      }
      self.characters = characters.data.results
      
    } catch {
      self.error = error
    }
  }
  
  func loadData() {
    Task(priority: .high) {
      try await fetchCharacters()
    }
  }
}

extension String {
  var MD5: String {
    let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
    return computed.map { String(format: "%02hhx", $0) }.joined()
  }
}
