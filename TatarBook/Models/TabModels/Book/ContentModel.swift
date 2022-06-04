//
//  ContentModel.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import Foundation

struct ContentModel: Serializable {
    let title: String?
    
    let text: TextContent?
    let list: TextContent?
    
    let vTable: [TableSimpleCellContent]?
    let hTable: [TableSimpleCellContent]?
    
    let rule: [String]?
    
    let contents: [ContentModel]?
}
