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
            appManager.updateFileIfNeed(type: .book, version: vm.currentVersion) { (model: BookModel?) in
                if let model = model {
                    DispatchQueue.main.async {
                        vm.model = model
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
