//
//  CharacterRowView.swift
//  RickAndMorty
//
//  Created by joooli on 4/1/22.
//

import SwiftUI

struct CharacterRowView: View {
    // MARK: - Property
    let character: Character
    @StateObject private var characterVM = RickAndMortyViewModel()
    @EnvironmentObject private var bookmarkVM: bookmarkViewModel
    
    @State private var test: Bool = false
    // MARK: - Body
    var body: some View {
        NavigationLink {
            DetailView(character: character)
        } label: {
            HStack(alignment: .top,spacing: 8) {
                AsyncImage(url: character.imageURL) {
                    phase in
                    switch phase {
                        case .empty:
                        HStack(alignment:.center) {
                                Spacer()
                                ProgressView()
                                Spacer()
                            } //:HSTACK
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        HStack {
                            Spacer()
                            Image(systemName: "photo")
                                .imageScale(.large)
                            Spacer()
                        } //:HSTACK
                    @unknown default:
                        fatalError()
                    }
                }  //:AsyncImage
                .frame(width: 75, height: 75, alignment: .center)
                .cornerRadius(4)
                VStack(alignment:.leading, spacing: 4) {
                    Text("\(character.name)")
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(2)
                    HStack {
                        Circle()
                            .fill(checkStatus())
                            .frame(width: 12, height: 12, alignment: .center)
                        Text("\(character.status)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                    } //:HSTACK
                    Text("gender: \(character.gender)")
                        .font(.footnote)
                } //:VSTACK
                Spacer()
                VStack(alignment: .center) {
                    Spacer()
                    HStack(alignment: .lastTextBaseline) {
                        Spacer()
                        Button {
                            toggleBookmark(for: character)
                        } label: {
                            Image(systemName: bookmarkVM.isBookmarked(for: character) ? "bookmark.fill" : "bookmark")
                                .foregroundColor(.indigo)
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle)
                    } //:HSTACK
                    Spacer()
                } //:VSTACK
            } //:HSTACK
        }
    }
    
    
    // for checking bookmark is marked or not.
    private func toggleBookmark(for character: Character) {
        if bookmarkVM.isBookmarked(for: character) {
            bookmarkVM.removeBookmark(for: character)
        } else {
            bookmarkVM.addBookmark(for: character)
        }
       
    }
    
    // function: CheckStatus
    func checkStatus() -> Color {
        switch character.status {
            case "Alive":
                return Color.green
            case "unknown":
                return Color.gray
            case "Dead":
                return Color.red
            default:
                return Color.black
        }
    }
    
}


// MARK: - Preview
struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character: .previewData[0])
    }
}
