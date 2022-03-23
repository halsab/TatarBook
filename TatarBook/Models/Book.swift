//
//  Book.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import Foundation

struct Book: Serializable {
    let title: String
    let contents: [Content]
}
