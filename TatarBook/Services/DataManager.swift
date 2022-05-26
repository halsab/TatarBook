//
//  DataManager.swift
//  TatarBook
//
//  Created by halsab on 25.05.2022.
//

import Foundation

protocol DataManagerProtocol {
    func getLocalFile<Model: Decodable>(type: FileType) -> Model?
    func getObject<Model: Decodable>(from data: Data) -> Model?
    func saveObject(data: Data, to file: FileType) -> Bool
}

class DataManager: DataManagerProtocol {
    
    static let shared: DataManagerProtocol = DataManager()
    private init() {}
    
    func getObject<Model: Decodable>(from data: Data) -> Model? {
        try? JSONDecoder().decode(Model.self, from: data)
    }
    
    func getLocalFile<Model: Decodable>(type: FileType) -> Model? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = url.appendingPathComponent(type.rawValue).appendingPathExtension("json")
        if let data = try? Data(contentsOf: fileURL) {
            return getObject(from: data)
        }
        return nil
    }
    
    func saveObject(data: Data, to file: FileType) -> Bool {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let url = urls.first else { return false }
        var fileURL = url.appendingPathComponent(file.rawValue)
        fileURL = fileURL.appendingPathExtension("json")
        return (try? data.write(to: fileURL, options: [.atomicWrite])) != nil
    }
}
