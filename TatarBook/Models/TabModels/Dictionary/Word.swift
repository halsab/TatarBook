//
//  Word.swift
//  TatarBook
//
//  Created by halsab on 01.06.2022.
//

import Foundation

struct Word: Serializable {
    let tatar: String
    let oldTatar: String
    
    var searchString: String {
        (tatar + oldTatar).lowercased()
    }
}
