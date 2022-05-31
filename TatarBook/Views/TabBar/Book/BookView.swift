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
    @State private var isLoading = false
    
    var body: some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(1.5)
        } else {
            NavigationView {
                ContentsView(contentTitle: "Иске имля", contents: vm.contents)
                    .navigationTitle(Text("Китап"))
                    .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
            .onAppear {
                updateIfNeed()
            }
        }
    }
    
    private func updateIfNeed() {
        let configFileVersion = appManager.config.files.first(where: { $0.name == FileType.book.rawValue })?.version ?? ""
        if vm.currentVersion < configFileVersion {
            isLoading = true
            NetworkManager.shared.getModel(of: .book) { (model: BookModel?) in
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

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
            .preferredColorScheme(.dark)
    }
}
