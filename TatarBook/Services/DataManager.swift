//
//  DataManager.swift
//  TatarBook
//
//  Created by halsab on 25.05.2022.
//

import Foundation

protocol DataManagerProtocol {
    func getLocalObject<Model: Decodable>(for fileType: FileType) -> Model?
    func getObject<Model: Decodable>(from data: Data) -> Model?
}

class DataManager: DataManagerProtocol {
    
    static let shared: DataManagerProtocol = DataManager()
    private init() {}
    
    func getData(for fileType: FileType) -> Data? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = url.appendingPathComponent(fileType.rawValue).appendingPathExtension("json")
        return try? Data(contentsOf: fileURL)
    }
    
    func getObject<Model: Decodable>(from data: Data) -> Model? {
        try? JSONDecoder().decode(Model.self, from: data)
    }
    
    func getLocalObject<Model: Decodable>(for fileType: FileType) -> Model? {
        if let data = getData(for: fileType) {
            Logger.log(.success, "Successfully got local object type '\(fileType)'", shouldLogContext: false)
            return getObject(from: data)
        } else {
            Logger.log(.error, "Cant find local object type '\(fileType)'", shouldLogContext: false)
            return nil
        }
    }
}
