//
//  DictionaryViewModel.swift
//  TatarBook
//
//  Created by Ha Sab on 25.03.2022.
//

import SwiftUI

class DictionaryViewModel: ObservableObject {
    
    @Published var words: [String] = []
    
    init() {
        if let dictionaryModel: DictionaryModel = DataManager.shared.getLocalFile(type: .dictionary) {
            let rawWords = dictionaryModel.content
            words = rawWords.sorted { $0.lowercased() < $1.lowercased() }
        }
    }
}
