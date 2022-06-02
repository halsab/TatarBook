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
    @Published var isLoading = false
    @Published var needData = false
    
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        model = DataManager.shared.getLocalFile(type: .book) ?? BookModel(version: "", content: [])
        $model
            .sink { [unowned self] sinkModel in
                contents = sinkModel.content
                needData = contents.isEmpty
                currentVersion = sinkModel.version
            }
            .store(in: &cancellabels)
    }
    
    func update() {
        isLoading = true
        NetworkManager.shared.getModel(of: .book) { [weak self] (model: BookModel?) in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let model = model {
                    self?.model = model
                }
            }
        }
    }
}
