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
    
    var body: some View {
        NavigationView {
            MainContentView(
                isLoading: $vm.isLoading,
                showReloadButton: $vm.needData,
                contentView: AnyView(
                    DictionaryContentView(
                        filteredWords: $vm.filteredWords,
                        searchQuery: $vm.searchQuery
                    )
                )
            ) {
                updateIfNeed()
            }
            .navigationTitle(Text("Сүзлек"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .onAppear {
            updateIfNeed()
        }
    }
    
    private func updateIfNeed() {
        appManager.updateFileIfNeed(.dictionary, vm.currentVersion, isNoInfo: vm.needData) {
            vm.update()
        }
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView()
    }
}
