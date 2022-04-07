//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by joooli on 4/1/22.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    
    @StateObject var bookmarkVM = bookmarkViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookmarkVM)
        }
    }
}
