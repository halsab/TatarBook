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
        let file = FileName(name: "book", type: "json")
        let bookModel: BookModel = JSONSerializer.shared.getModel(of: file)
        contents = bookModel.content
    }
}
