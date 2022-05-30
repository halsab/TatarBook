//
//  BookViewModel.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI
import Combine

class BookViewModel: ObservableObject {
    
    @Published var model: BookModel
    @Published var contents: [ContentModel] = []
    @Published var currentVersion: String = ""
    
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        model = DataManager.shared.getLocalFile(type: .book) ?? BookModel(version: "", content: [])
        $model
            .sink { [unowned self] sinkModel in
                contents = sinkModel.content
                currentVersion = sinkModel.version
            }
            .store(in: &cancellabels)
    }
}
