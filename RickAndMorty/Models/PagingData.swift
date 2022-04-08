//
//  PagingData.swift
//  RickAndMorty
//
//  Created by joooli on 4/8/22.
//

import Foundation


actor PagingData {
    private(set) var currentPage = 0
    private(set) var hasReachEnd = false
    
    let itemsPerPage: Int
    
    init(itemsPerPage: Int) {
        assert(itemsPerPage > 0, "ITEMS per page and max page limit must be more than 0")
        
        self.itemsPerPage = itemsPerPage
    }
    
    var nextPage: Int { currentPage + 1 }
    var shouldLoadNextPage: Bool {
        !hasReachEnd
    }
    
    func reset() {
        print("Paging Reset")
        currentPage = 0
        hasReachEnd = false
    }
    
    func loadNextPage<T>(dataFetchProvider: @escaping(Int) async throws -> [T]) async throws -> [T] {
        if Task.isCancelled { return [] }
        print("PAGING: Current Page \(currentPage), next Page: \(nextPage)")
        
        guard shouldLoadNextPage else { return [] }
        
        let nextPage = self.nextPage
        let items = try await dataFetchProvider(nextPage)
        if Task.isCancelled || nextPage != self.nextPage { return [] }
        
        currentPage = nextPage
        hasReachEnd = items.count < itemsPerPage
        
        print("PAGING: fetch \(items.count) items successfully current page: \(currentPage)")
        
        return items
    }
    
}
