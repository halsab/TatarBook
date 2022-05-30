//
//  BookViewModel.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

class BookViewModel: ObservableObject {
    
    @Published var model: BookModel = BookModel(version: "", content: [])
    @Published var contents: [ContentModel] = []
    
    init() {
        if let model: BookModel = DataManager.shared.getLocalFile(type: .book) {
            self.model = model
            contents = model.content
        }
    }
    
    func loadModel(completion: @escaping (BookModel?) -> Void) {
        NetworkManager.shared.getData(of: .book) { data in
            guard let data = data,
                  let model: BookModel = DataManager.shared.getObject(from: data) else {
                completion(nil)
                return
            }
            if DataManager.shared.saveObject(data: data, to: .book) {
                completion(model)
            } else {
                completion(nil)
            }
        }
    }
}
