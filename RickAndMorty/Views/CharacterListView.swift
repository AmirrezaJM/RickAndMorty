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
    // MARK: - Body
    var body: some View {
        List {
            ForEach(character) { item in
                CharacterRowView(character: item)
                    .listRowInsets(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
            } //:LOOP
        } //:LIST
        .listStyle(.plain)
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(character: Character.previewData)
    }
}
