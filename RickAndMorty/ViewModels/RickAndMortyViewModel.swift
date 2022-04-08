//
//  RickAndMortyViewModel.swift
//  RickAndMorty
//
//  Created by joooli on 4/2/22.
//

import Foundation
import SwiftUI


@MainActor
class RickAndMortyViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Character]>.empty
    @Published var checkStatus: Bool?
    private let AppApi = AppAPI.shared
    private let pagingData = PagingData()
    
    var characters: [Character] {
        phase.value ?? []
    }
    
    init(characters: [Character]? = nil) {
        if let characters = characters {
            self.phase = .success(characters)
        } else {
            self.phase = .empty
        }
    }
    
    // load character info
    func loadFirstPage() async {
        await pagingData.reset()
        if Task.isCancelled { return }
        phase = .empty
        do {
            let characters = try await pagingData.loadNextPage(dataFetchProvider: loadCharacter(page:))
            if Task.isCancelled { return }
            phase = .success(characters)
        }
        catch {
            if Task.isCancelled { return }
            phase = .failure(error)
        }
    }
    
    var isFetchingNextPage:Bool {
        if case .fetchNextPage = phase {
            return true
        } else {
            return false
        }
    }
    
    func loadNextPage() async {
        if Task.isCancelled { return }
        
        let characters = self.phase.value ?? []
        phase = .fetchNextPage(characters)
        
        do {
            let nextCharacter = try await pagingData.loadNextPage(dataFetchProvider: loadCharacter(page:))
            if Task.isCancelled { return }
            phase = .success(characters + nextCharacter)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func loadCharacter(page: Int) async throws -> [Character] {
        let characters = try await AppApi.fetch(page: page)
        if Task.isCancelled { return [] }
        return characters
    }
}
