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
    
    var body: some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(1.5)
        } else {
            NavigationView {
                List {
                    ForEach(vm.filteredWords, id: \.self) { word in
                        HStack {
                            Text(.init(word.tatar))
                                .font(.system(.body, design: .serif))
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(.init(word.oldTatar))
                                .font(.system(.title, design: .serif))
                        }
                    }
                }
                .id(UUID())
                .listStyle(.plain)
                .searchable(text: $vm.searchQuery, prompt: Text("Сүзне яза башлагыз...")) {}
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
