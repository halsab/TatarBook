//
//  BookViewModel.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

class BookViewModel: ObservableObject {
    
    @Published var contents: [Content]
    
    private let file = File(name: "book", type: "json")
    
    init() {
        contents = JSONSerializer.shared.getModel(of: file)
    }
}
