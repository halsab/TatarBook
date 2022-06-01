//
//  DictView.swift
//  TatarBook
//
//  Created by halsab on 01.06.2022.
//

import SwiftUI

struct DictView: View {
    
    @StateObject var vm = DictViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.filteredObjects, id: \.id) { object in
                    VStack(alignment: .leading) {
                        Text("Char: \(object.char)")
                        Text("Number: \(object.number)")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .id(UUID())
            .listStyle(.plain)
            .searchable(text: $vm.searchQuery, prompt: Text("Сүзне яза башлагыз...")) {}
            .navigationTitle("Сүзлек")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}
