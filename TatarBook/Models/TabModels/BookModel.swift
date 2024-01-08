//
//  BookModel.swift
//  TatarBook
//
//  Created by halsab on 26.05.2022.
//

import Foundation

struct BookModel: Serializable {
    let version: String
    let content: [ContentModel]
}
