//
//  BookViewModel.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

class BookViewModel: ObservableObject {
    
    @Published var contents: [ContentModel]
    
    init() {
        let file = File(name: "book", type: "json")
        contents = JSONSerializer.shared.getModel(of: file)
    }
}
