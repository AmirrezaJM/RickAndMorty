//
//  DetailView.swift
//  RickAndMorty
//
//  Created by joooli on 4/1/22.
//

import SwiftUI

struct DetailView: View {
    // MARK: - Property
    let character: Character
    let characterInfo: [String] = ["Status","species","Type"]
    @State private var showFlag: Bool = false
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment:.center) {
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
                            .scaledToFit()
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
                }  //:ASyncImage
                .frame(height: 300, alignment: .center)
                .background(Color.gray.opacity(0.3))
                HStack(alignment:.center) {
                    Text(character.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .underline()
                } //:HSTACK
                GroupBox {
                    DisclosureGroup("\(character.name) info",isExpanded: $showFlag) {
                        Divider().padding(.vertical,2)
                        DisclosureGroupView(char: character.status,name: "Status",stat: true,finalColor: checkStatus())
                        Divider().padding(.vertical,2)
                        DisclosureGroupView(char: character.species,name: "species",stat: false, finalColor: nil)
                        Divider().padding(.vertical,2)
                        DisclosureGroupView(char: character.gender, name: "Gender",stat: false, finalColor: nil)
                    } //:DisclosureGroup
                } //:GroupBox
                .padding()
            } //:VSTACK
        } //:ScrollView
        .ignoresSafeArea()
    } //:Body
    
    
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
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(character: Character.previewData[0])
    }
}


// MARK: - DisclosureGroupView
struct DisclosureGroupView: View {
    let char: String
    let name: String
    let stat: Bool
    let finalColor: Color?
    var body: some View {
        if !stat {
            HStack {
                Group {
                    Image(systemName: "info.circle")
                    Text(name)
                    Spacer()
                    Text(char)
                }
                .font(Font.system(.body))
                .padding(.vertical,12)
                Spacer(minLength: 15)
            }
        } else {
            HStack {
                Group {
                    Image(systemName: "info.circle")
                    Text(name)
                    Spacer()
                    Circle()
                        .fill(finalColor ?? Color.clear)
                        .frame(width: 12, height: 12, alignment: .center)
                    Text(char)
                }
                .font(Font.system(.body))
                .padding(.vertical,12)
                Spacer(minLength: 15)
            }
        }
    }
}
