//
//  NetworkManager.swift
//  TatarBook
//
//  Created by halsab on 25.05.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func getModel<T: Decodable>(of fileType: FileType, completion: @escaping (T?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    private enum ServerState {
        case prod, dev, test
    }
    
    static let shared: NetworkManagerProtocol = NetworkManager()
    private init() {}
    
    private var serverState: ServerState = .prod
    private var endpoint: String {
        switch serverState {
        case .prod:
            return "https://raw.githubusercontent.com/halsab/Database/main/TatarBook/"
        case .dev:
            return "https://raw.githubusercontent.com/halsab/Database/dev/TatarBook/"
        case .test:
            return "https://raw.githubusercontent.com/halsab/Database/test/TatarBook/"
        }
    }
    
    private func getData(of fileType: FileType, completion: @escaping (Data?) -> Void) {
        let url = URL(string: endpoint + fileType.rawValue + ".json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil,
               let r = response as? HTTPURLResponse,
               r.statusCode == 200,
               let data = data {
                completion(data)
            } else {
                Logger.log(.error, "Can't get data type '\(fileType)'")
                completion(nil)
            }
        }.resume()
    }
    
    func getModel<T: Decodable>(of fileType: FileType, completion: @escaping (T?) -> Void) {
        getData(of: fileType) { data in
            guard let data = data,
                  let model: T = DataManager.shared.getObject(from: data) else {
                completion(nil)
                return
            }
            if DataManager.shared.saveObject(data: data, to: fileType) {
                completion(model)
            } else {
                completion(nil)
            }
        }
    }
}
