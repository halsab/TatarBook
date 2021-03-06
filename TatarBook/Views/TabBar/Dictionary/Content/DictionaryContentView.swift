//
//  DictionaryContentView.swift
//  TatarBook
//
//  Created by halsab on 02.06.2022.
//

import SwiftUI

struct DictionaryContentView: View {
    @Binding var filteredWords: [Word]
    @Binding var searchQuery: String
    var body: some View {
        List {
            ForEach(filteredWords, id: \.self) { word in
                WordView(word: word)
            }
        }
        .id(UUID())
        .listStyle(.plain)
        .searchable(text: $searchQuery, prompt: Text("Сүзне яза башлагыз...")) {}
    }
}

struct DictionaryContentView_Previews: PreviewProvider {
    @State private static var words: [Word] = []
    @State private static var query: String = ""
    static var previews: some View {
        DictionaryContentView(filteredWords: $words, searchQuery: $query)
    }
}
