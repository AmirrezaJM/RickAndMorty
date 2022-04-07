//
//  SearchTabView.swift
//  RickAndMorty
//
//  Created by joooli on 4/6/22.
//

import SwiftUI

struct SearchTabView: View {
    // MARK: - Property
    @StateObject var searchVM = CharacterSearchViewModel()
    // MARK: - Body
    var body: some View {
        NavigationView {
            CharacterListView(character: characters)
                .overlay(overlayView)
                .navigationTitle("Search")
        } //: NavigationView
        .searchable(text: $searchVM.searchQuery)
        .onChange(of: searchVM.searchQuery, perform: { newValue in
            if newValue.isEmpty {
                searchVM.phase = .empty
            }
        })
        .onSubmit(of: .search,search)
    }
    
    private var characters: [Character] {
        if case let .success(characters) = searchVM.phase {
            return characters
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch searchVM.phase {
            case .empty:
                if !searchVM.searchQuery.isEmpty {
                    ProgressView()
                } else {
                    EmptyPlaceholderView(text: "Type your query to search from NewAPI", image: Image(systemName: "magnifyingglass"))
                }
            case .success(let characters) where characters.isEmpty:
                EmptyPlaceholderView(text: "no Search result found ", image: Image(systemName: "magnifyingglass"))
            case .failure(let error):
            RetryView(text: error.localizedDescription,retryAction: search)
            default:
                EmptyView()
        }
    }
    
    private func search() {
        Task {
            await searchVM.searchCharacter()
        }
    }
    
}

struct SearchTabView_Previews: PreviewProvider {
    
    @StateObject var bookmarkVM = bookmarkViewModel.shared
    
    static var previews: some View {
        SearchTabView()
    }
}
