//
//  Serializable.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import Foundation

protocol Serializable: Identifiable, Codable, Hashable {
    var id: UUID? { get }
}

extension Serializable {
    var id: UUID? {
        UUID()
    }
}
