//
//  CharacterSearchViewModel.swift
//  RickAndMorty
//
//  Created by joooli on 4/6/22.
//

import Foundation


@MainActor
class CharacterSearchViewModel: ObservableObject {
    
    @Published var phase: DataFetchPhase<[Character]> = .empty
    @Published var searchQuery = ""
    private let newApi = AppAPI.shared
    
    func searchCharacter() async {
        if Task.isCancelled { return }
        
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let characters = try await newApi.search(for: searchQuery)
            if Task.isCancelled { return }
            phase = .success(characters)
        } catch {
            if Task.isCancelled { return }
            phase = .failure(error)
            
        }
    }
}
