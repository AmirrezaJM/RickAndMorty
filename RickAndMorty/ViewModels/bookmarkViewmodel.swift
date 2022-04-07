//
//  bookmarkViewmodel.swift
//  RickAndMorty
//
//  Created by joooli on 4/3/22.
//

import Foundation


@MainActor
class bookmarkViewModel: ObservableObject {
    @Published private(set) var bookmarks: [Character] = []
    
    
    static let shared = bookmarkViewModel()
    
    func isBookmarked(for character: Character) -> Bool {
        return bookmarks.first { character.id == $0.id } != nil
    }
    
    func addBookmark(for character: Character) {
        // if not bookmark continue
        guard !isBookmarked(for: character) else {
            return
        }
        bookmarks.insert(character, at: 0)
    }
    
    
    func removeBookmark(for character:Character) {
        guard let index = bookmarks.firstIndex(where: {$0.id == character.id}) else {
            return
        }
        bookmarks.remove(at: index)
    }
}
