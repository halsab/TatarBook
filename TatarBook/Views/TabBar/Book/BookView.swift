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
            ContentsView(contents: vm.contents)
                .navigationTitle(Text("Китап"))
        }
        .onAppear {
            updateModelIfNeed()
        }
    }
    
    private func updateModelIfNeed() {
        let configFileVersion = appManager.config.files.first(where: { $0.name == FileType.book.rawValue })?.version ?? ""
        if vm.model.version < configFileVersion {
            Logger.log(.info, "Update book")
            vm.loadModel { model in
                if let model = model {
                    DispatchQueue.main.async {
                        vm.model = model
                        vm.contents = model.content
                        Logger.log(.success, "Book updated")
                    }
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
