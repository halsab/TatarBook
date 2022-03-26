//
//  DictionaryViewModel.swift
//  TatarBook
//
//  Created by Ha Sab on 25.03.2022.
//

import SwiftUI

class DictionaryViewModel: ObservableObject {
    
    @Published var words: [String]
    
    init() {
        let file = File(name: "dictionary", type: "json")
        let rawWords: [String] = JSONSerializer.shared.getModel(of: file)
        words = rawWords.sorted { $0.lowercased() < $1.lowercased() }
    }
}
