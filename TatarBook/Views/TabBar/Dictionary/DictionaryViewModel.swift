//
//  DictionaryViewModel.swift
//  TatarBook
//
//  Created by Ha Sab on 25.03.2022.
//

import SwiftUI
import Combine

class DictionaryViewModel: ObservableObject {
    
    @Published var model: DictionaryModel = DictionaryModel(version: "", content: [])
    @Published var currentVersion: String = ""
    @Published var filteredWords: [Word] = []
    @Published var searchQuery = ""
    @Published var isLoading = false
    @Published var needData = false
    
    private var words: [Word] = []
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        model = DataManager.shared.getLocalFile(type: .dictionary) ?? DictionaryModel(version: "", content: [])
        $model
            .sink { [unowned self] sinkModel in
                words = sinkModel.content.sorted { $0.tatar.lowercased() < $1.tatar.lowercased() }
                needData = words.isEmpty
                filteredWords = words
                currentVersion = sinkModel.version
            }
            .store(in: &cancellabels)
        $searchQuery
            .sink(receiveValue: { [unowned self] searchQueryValue in
                if searchQueryValue.isEmpty {
                    filteredWords = words
                } else {
                    filteredWords = words
                        .filter { $0.searchString.contains(searchQueryValue.lowercased()) }
                }
            })
            .store(in: &cancellabels)
    }
    
    func update() {
        isLoading = true
        NetworkManager.shared.getModel(of: .dictionary) { [weak self] (model: DictionaryModel?) in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let model = model {
                    self?.model = model
                }
            }
        }
    }
}
