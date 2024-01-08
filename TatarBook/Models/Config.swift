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
    var files: [File]
    
    func getFileVersion(of fileType: FileType) -> String {
        files.first(where: { $0.name == fileType.rawValue })?.version ?? ""
    }
    
    func getPrettyName(of file: File) -> String {
        FileType.allCases.first(where: { $0.rawValue == file.name })?.prettyName ?? ""
    }
}
