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

enum FileType: String, CaseIterable {
    case config, book, test, dictionary
}

class DataManager: DataManagerProtocol {
    
    static let shared: DataManagerProtocol = DataManager()
    private init() {}
    
    func getObject<Model: Decodable>(from data: Data) -> Model? {
        do {
            let model: Model = try JSONDecoder().decode(Model.self, from: data)
            return model
        } catch {
            Logger.log(.error, "Can't decode data to object type '\(Model.Type.self)'. " + error.localizedDescription)
            return nil
        }
    }
    
    func getLocalFile<Model: Decodable>(type: FileType) -> Model? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = url.appendingPathComponent(type.rawValue).appendingPathExtension("json")
        do {
            let data = try Data(contentsOf: fileURL)
            return getObject(from: data)
        } catch {
            Logger.log(.error, "Can't find data of file '\(type)'. " + error.localizedDescription)
            return nil
        }
    }
    
    func saveObject(data: Data, to file: FileType) -> Bool {
        guard let url = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false) else { return false }
        var fileURL = url.appendingPathComponent(file.rawValue)
        fileURL = fileURL.appendingPathExtension("json")
        do {
            try data.write(to: fileURL)
            return true
        } catch {
            Logger.log(.error, "Can't save data of file '\(file)'. " + error.localizedDescription)
            return false
        }
    }
}
