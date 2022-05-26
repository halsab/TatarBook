//
//  NetworkManager.swift
//  TatarBook
//
//  Created by halsab on 25.05.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func getData(for fileType: FileType, completion: @escaping (Data?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    static let shared: NetworkManagerProtocol = NetworkManager()
    private init() {}
    
    private let endpoint = "https://raw.githubusercontent.com/halsab/Database/main/TatarBook/"

    func getData(for fileType: FileType, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: endpoint + fileType.rawValue + ".json") else {
            Logger.log(.error, "Cant create correct URL", shouldLogContext: false)
            return
        }
        Logger.log(.info, "Get data for URL path: \(url.path)", shouldLogContext: false)
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, error == nil {
                Logger.log(.success, "Successfully got remote data type '\(fileType)'", shouldLogContext: false)
                completion(data)
            } else {
                Logger.log(.error, "Cant get remote data type '\(fileType)'", shouldLogContext: false)
                completion(nil)
            }
        }.resume()
    }
}
