//
//  DictionaryView.swift
//  TatarBook
//
//  Created by Ha Sab on 25.03.2022.
//

import SwiftUI

struct DictionaryView: View {
    
    @StateObject private var vm = DictionaryViewModel()
    @State private var searchText = ""
    var searchResults: [String] {
        if searchText.isEmpty {
            return vm.words
        } else {
            return vm.words.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { name in
                    Text(.init(name))
                        .font(.system(.body, design: .serif))
                }
            }
            .listStyle(PlainListStyle())
            .searchable(text: $searchText) {
                ForEach(searchResults, id: \.self) { result in
                    Text(.init(result)).searchCompletion(result)
                        .font(.system(.body, design: .serif))
                }
            }
            .navigationTitle(Text("Сүзлек"))
        }
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
    }
}
