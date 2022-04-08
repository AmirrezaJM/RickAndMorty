//
//  CharacterListVIew.swift
//  RickAndMorty
//
//  Created by joooli on 4/1/22.
//

import SwiftUI

struct CharacterListView: View {
    // MARK: - Property
    let character: [Character]
    
    var isFetchingNextPage = false
    var nextPageHandler: (() async -> ())? = nil
    // MARK: - Body
    var body: some View {
        List {
            ForEach(character) { item in
                if let nextPageHandler = nextPageHandler, item == character.last {
                    CharacterRowView(character: item)
                        .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
                        .task {
                            await nextPageHandler()
                        }
                    if isFetchingNextPage {
                         bottomProgressView
                    } //:CONDITION
                } else {
                    CharacterRowView(character: item)
                        .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
                } //:CONDITION
            } //:LOOP
        } //:LIST
        .listStyle(.plain)
    } //: Body

    
    @ViewBuilder
    private var bottomProgressView: some View {
        Divider()
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }.padding()
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(character: Character.previewData)
    }
}
