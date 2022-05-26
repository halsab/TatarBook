//
//  Config.swift
//  TatarBook
//
//  Created by halsab on 25.05.2022.
//

import Foundation

struct Config: Serializable {
    struct File: Serializable {
        let name: String
        let version: String
    }
    let files: [File]
}
