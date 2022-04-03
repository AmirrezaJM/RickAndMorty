//
//  Character.swift
//  RickAndMorty
//
//  Created by joooli on 4/1/22.
//

import Foundation


struct Character: Identifiable,Codable,Equatable {
    let id: Int
    let name: String
    let image: String
    let status: String
    let gender: String
    let species: String
    
    
    var imageURL: URL {
        return URL(string: image)!
    }
}

extension Character {
    static var previewData: [Character] {
        let previewDataURL = Bundle.main.url(forResource: "RickAndMorty", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(NEWAPIResponse.self, from: data)
        return apiResponse.results ?? []
    }
}


