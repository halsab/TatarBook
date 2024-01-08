//
//  FileType.swift
//  TatarBook
//
//  Created by halsab on 02.06.2022.
//

import Foundation

enum FileType: String, CaseIterable {
    case config, book, test, dictionary
    
    var prettyName: String {
        switch self {
        case .config:
            return "Конфигурация"
        case .book:
            return "Китап"
        case .test:
            return "Тест"
        case .dictionary:
            return "Сүзлек"
        }
    }
}
