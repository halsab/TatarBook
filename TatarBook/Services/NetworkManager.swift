//
//  NetworkManager.swift
//  TatarBook
//
//  Created by halsab on 25.05.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func getData(of type: FileType, completion: @escaping (Data?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    enum ServerState {
        case prod, dev
    }
    
    static let shared: NetworkManagerProtocol = NetworkManager()
    private init() {}
    
    private var serverState: ServerState = .dev
    private var endpoint: String {
        switch serverState {
        case .prod:
            return "https://raw.githubusercontent.com/halsab/Database/main/TatarBook/"
        case .dev:
            return "https://raw.githubusercontent.com/halsab/Database/dev/TatarBook/"
        }
    }
    
    func getData(of type: FileType, completion: @escaping (Data?) -> Void) {
        let url = URL(string: endpoint + type.rawValue + ".json")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil,
               let r = response as? HTTPURLResponse,
               r.statusCode == 200,
               let data = data
            {
                Logger.log(.info, "Got data type '\(type)'", withContext: false)
                completion(data)
            } else {
                Logger.log(.error, "Can't get data type '\(type)'", withContext: false)
                completion(nil)
            }
        }.resume()
    }
}
