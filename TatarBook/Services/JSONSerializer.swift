//
//  JSONSerializer.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import Foundation

class JSONSerializer {
    
    static let shared = JSONSerializer()
    
    private init() {}
    
    private func getData(of file: File) -> Data {
        if let path = Bundle.main.path(forResource: file.name, ofType: file.type) {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch (let error) {
                fatalError("### Error: \(error.localizedDescription)")
            }
        } else {
            fatalError("### Error: Unable to get file: '\(file.name).\(file.type)'")
        }
    }
    
    private func parse<T: Codable>(_ data: Data) -> T {
        do {
            let jsonObject = try JSONDecoder().decode(T.self, from: data)
            return jsonObject
        } catch (let error) {
            fatalError("### Error: \(error.localizedDescription)")
        }
    }
    
    func getModel<T: Codable>(of file: File) -> T {
        let data = getData(of: file)
        let model: T = parse(data)
        return model
    }
}
