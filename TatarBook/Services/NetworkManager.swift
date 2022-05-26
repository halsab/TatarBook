//
//  NetworkManager.swift
//  TatarBook
//
//  Created by halsab on 25.05.2022.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func getFile<Model: Decodable>(type: FileType) -> AnyPublisher<Model, Error>
}

class NetworkManager: NetworkManagerProtocol {
    
    static let shared: NetworkManagerProtocol = NetworkManager()
    private init() {}
    
    private let endpoint = "https://raw.githubusercontent.com/halsab/Database/main/TatarBook/"

    func getFile<Model: Decodable>(type: FileType) -> AnyPublisher<Model, Error> {
        guard let url = URL(string: endpoint + type.rawValue + ".json") else {
            preconditionFailure("Cant create correct URL")
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Model.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
