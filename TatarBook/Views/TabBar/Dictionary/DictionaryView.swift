//
//  DictionaryView.swift
//  TatarBook
//
//  Created by Ha Sab on 25.03.2022.
//

import SwiftUI

struct DictionaryView: View {
    
    @EnvironmentObject var appManager: AppManager
    @StateObject private var vm = DictionaryViewModel()
    @State private var isLoading = false
    @State private var searchText = ""
    var searchResults: [String] {
        if searchText.isEmpty {
            return vm.words
        } else {
            return vm.words.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(1.5)
        } else {
            NavigationView {
                List {
                    ForEach(searchResults, id: \.self) { name in
                        Text(.init(name))
                            .font(.system(.body, design: .serif))
                    }
                }
                .listStyle(PlainListStyle())
                .searchable(text: $searchText, prompt: "Сүзне яза башлагыз...") {
                    ForEach(searchResults, id: \.self) { result in
                        Text(.init(result)).searchCompletion(result)
                            .font(.system(.body, design: .serif))
                    }
                }
                .navigationTitle(Text("Сүзлек"))
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
            .onAppear {
                updateIfNeed()
            }
        }
    }
    
    private func updateIfNeed() {
        let configFileVersion = appManager.config.files.first(where: { $0.name == FileType.dictionary.rawValue })?.version ?? ""
        if vm.currentVersion < configFileVersion {
            isLoading = true
            NetworkManager.shared.getModel(of: .dictionary) { (model: DictionaryModel?) in
                if let model = model {
                    DispatchQueue.main.async {
                        vm.model = model
                        isLoading = false
                    }
                } else {
                    isLoading = false
                }
            }
        }
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
    }
}
