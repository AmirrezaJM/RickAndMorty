//
//  ContentView.swift
//  RickAndMorty
//
//  Created by joooli on 4/1/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CharacterTabView()
                .tabItem {
                    Label("Characters",systemImage: "character.book.closed")
                }
            SearchTabView()
                .tabItem {
                    Label("Search",systemImage: "magnifyingglass")
                }
            BookmarkTabView()
                .tabItem {
                    Label("Bookmark",systemImage: "bookmark")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
