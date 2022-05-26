//
//  JSONSerializer.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import Foundation

protocol JSONSerializerProtocol {
    func getModel<T: Codable>(of file: FileName) -> T
}

class JSONSerializer: JSONSerializerProtocol {
    
    static let shared: JSONSerializerProtocol = JSONSerializer()
    
    private init() {}
    
    func getModel<T: Codable>(of file: FileName) -> T {
        let data = getData(of: file)
        let model: T = parse(data)
        return model
    }
    
    private func getData(of file: FileName) -> Data {
        if let path = Bundle.main.path(forResource: file.name, ofType: file.type) {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch (let error) {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Unable to get file: '\(file.name).\(file.type)'")
        }
    }
    
    private func parse<T: Codable>(_ data: Data) -> T {
        do {
            let jsonObject = try JSONDecoder().decode(T.self, from: data)
            return jsonObject
        } catch (let error) {
            fatalError(error.localizedDescription)
        }
    }
}
