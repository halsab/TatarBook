//
//  DictionaryViewModel.swift
//  TatarBook
//
//  Created by Ha Sab on 25.03.2022.
//

import SwiftUI
import Combine

class DictionaryViewModel: ObservableObject {
    
    @Published var model: DictionaryModel
    @Published var words: [String] = []
    @Published var currentVersion: String = ""
    
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        model = DataManager.shared.getLocalFile(type: .dictionary) ?? DictionaryModel(version: "", content: [])
        $model
            .sink { [unowned self] sinkModel in
                words = sinkModel.content.sorted { $0.lowercased() < $1.lowercased() }
                currentVersion = sinkModel.version
            }
            .store(in: &cancellabels)
    }
}
