//
//  RickAndMortyViewModel.swift
//  RickAndMorty
//
//  Created by joooli on 4/2/22.
//

import Foundation
import SwiftUI


enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

struct FetchTaskToken: Equatable {
    var category: Category
    var token: Date
}


@MainActor
class RickAndMortyViewModel: ObservableObject {
    @Published var phase = DataFetchPhase<[Character]>.empty
    @Published var checkStatus: Bool?
    private var AppApi = AppAPI.shared
    
    init(characters: [Character]? = nil) {
        if let characters = characters {
            self.phase = .success(characters)
        } else {
            self.phase = .empty
        }
    }
    
    // load character info
    func loadCharacter() async {
        if Task.isCancelled { return }
        phase = .empty
        do {
            let characters = try await AppApi.fetch()
            if Task.isCancelled { return }
            phase = .success(characters)
        }
        catch {
            if Task.isCancelled { return }
            phase = .failure(error)
        }
    }
}
