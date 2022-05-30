//
//  BookViewModel.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI
import Combine

class BookViewModel: ObservableObject {
    
    @Published var model: BookModel = BookModel(version: "", content: [])
    @Published var contents: [ContentModel] = []
    
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        $model
            .sink { [unowned self] sinkModel in
                contents = sinkModel.content
            }
            .store(in: &cancellabels)
        
        if let model: BookModel = DataManager.shared.getLocalFile(type: .book) {
            self.model = model
        }
    }
}
