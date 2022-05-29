//
//  BookViewModel.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

class BookViewModel: ObservableObject {
    
    @Published var contents: [ContentModel] = []
    
    init() {
        if let bookModel: BookModel = DataManager.shared.getLocalFile(type: .book) {
            contents = bookModel.content
        }
    }
}
