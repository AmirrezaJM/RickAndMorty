//
//  AppAPI.swift
//  RickAndMorty
//
//  Created by joooli on 4/2/22.
//

import Foundation


struct AppAPI {
    static let shared = AppAPI()
    private init() {
        
    }
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    // fetch data in project
    func fetch() async throws -> [Character] {
        try await fetchCharacter(from: generateRickAndMortyURL())
    }
    
    func search(for name: String) async throws -> [Character] {
        try await fetchCharacter(from: generateSearchURL(from: name))
    }
    
    private func fetchCharacter(from url: URL) async throws -> [Character] {
        let (data,response) = try await session.data(from: url)
        guard let response = response as? HTTPURLResponse else {
            throw generateErrorCode(description: "Bad Response")
        }
        switch response.statusCode {
        case (200...299), (400...499):
            let apiResponse = try jsonDecoder.decode(NEWAPIResponse.self, from: data)
            return apiResponse.results ?? []
        default:
            throw generateErrorCode(description: "A server Error")
        }
    }
    
    
    private func generateErrorCode(code: Int = 1, description: String) -> Error {
        NSError(domain: "CharacterAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    
    private func generateSearchURL(from query: String) -> URL {
        let percentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
//        print(percentEncodedString)
        var url = "https://rickandmortyapi.com/api/character/?"
        url += "page=1"
        url += "&name=\(percentEncodedString)"
        return URL(string: url)!
    }
    
    
    // generate news url with apiKey and other property
    private func generateRickAndMortyURL() -> URL {
        var url = "https://rickandmortyapi.com/api/character/?"
        url += "page=1"
        return URL(string: url)!
    }
}
