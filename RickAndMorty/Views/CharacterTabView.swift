//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by joooli on 4/1/22.
//

import SwiftUI

struct CharacterTabView: View {
    // MARK: - Property
    @StateObject var characterVM = RickAndMortyViewModel()
    // MARK: - Body
    var body: some View {
        NavigationView {
            CharacterListView(character: characters)
                .overlay(overlayView)
                .refreshable {
                    await characterVM.loadCharacter()
                }
                .task {
                    await loadTask()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("test")
                        } label: {
                            Image(systemName: "list.bullet")
                        } // :Button
                    } // :ToolbarItem
                } // :Toolbar
                .navigationTitle("Rick And Morty")
        } // :NavigationView
    } // :Body
    
    // check the phase of characters
    private var characters: [Character] {
        if case let .success(characters) = characterVM.phase {
            return characters
        } else {
            return []
        }
    }
    
    
    
    @ViewBuilder
    private var overlayView: some View {
        switch characterVM.phase {
        case .empty:
            ProgressView()
        case .success(let characters)  where characters.isEmpty:
            EmptyPlaceholderView(text: "No Character", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription,retryAction: {

            })
        default:
            EmptyView()
        }
    }
    
    @Sendable
    private func loadTask() async {
        await characterVM.loadCharacter()
    }
    
}


// MARK: - Preview
struct CharacterTabView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterTabView(characterVM: RickAndMortyViewModel(characters: Character.previewData))
    }
}
