//
//  BookView.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

struct BookView: View {
    
    @EnvironmentObject var appManager: AppManager
    @StateObject private var vm = BookViewModel()
    
    var body: some View {
        NavigationView {
            MainContentView(
                isLoading: $vm.isLoading,
                showReloadButton: $vm.needData,
                contentView: AnyView(BookContentView(contents: $vm.contents))
            ) {
                updateIfNeed()
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            updateIfNeed()
        }
    }
    
    private func updateIfNeed() {
        appManager.updateFileIfNeed(.book, vm.currentVersion, isNoInfo: vm.needData) {
            vm.update()
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
