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
  let pageLimit = 20
  var page = 0
  var baseURL = "https://gateway.marvel.com/v1/public/characters?"
  
  var urlString: String {
    return "\(baseURL)limit=\(pageLimit)&offset=\(page)&"
  }
  
  init() {
    loadData()
  }
  
  func refresh() {
    characters.removeAll()
    page = 0
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
    let endpoint = urlString + "ts=\(timestamp)&apikey=\(Constants.Keys.publickey)&hash=\(hash)"
    
    do {
      
      page += 20
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
      self.characters.append(contentsOf: characters.data.results)
      
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
