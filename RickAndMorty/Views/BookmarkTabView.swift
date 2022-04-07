//
//  BookmarkTabView.swift
//  RickAndMorty
//
//  Created by joooli on 4/3/22.
//

import SwiftUI

struct BookmarkTabView: View {
    // MARK: - Property
    @EnvironmentObject private var bookmarkVM: bookmarkViewModel
    // MARK: - Body
    var body: some View {
        NavigationView {
            CharacterListView(character: bookmarkVM.bookmarks)
                .overlay(overlayView(isEmpty: bookmarkVM.bookmarks.isEmpty))
            .navigationTitle("Bookmark")
        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaceholderView(text: "No Bookmark", image: Image(systemName: "bookmark"))
        }
    }
}

struct BookmarkTabView_Previews: PreviewProvider {
    @StateObject static var bookmarkVM = bookmarkViewModel()
    static var previews: some View {
        BookmarkTabView()
            .environmentObject(bookmarkVM)
    }
}
