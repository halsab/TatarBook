//
//  NetworkManager.swift
//  TatarBook
//
//  Created by halsab on 25.05.2022.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func getData(of type: FileType) -> AnyPublisher<Data, Error>
    func getFile<Model: Decodable>(type: FileType) -> AnyPublisher<Model, Error>
    func getAndSaveAll(completion: @escaping (Bool) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
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
    
    private var cancellables: Set<AnyCancellable> = []
    
    func getData(of type: FileType) -> AnyPublisher<Data, Error> {
        let url = URL(string: endpoint + type.rawValue + ".json")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    func getFile<Model: Decodable>(type: FileType) -> AnyPublisher<Model, Error> {
        let url = URL(string: endpoint + type.rawValue + ".json")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Model.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getAndSaveAll(completion: @escaping (Bool) -> Void) {
        let group = DispatchGroup()
        var answers: [Bool] = []
        for fileType in FileType.allCases {
            group.enter()
            getData(of: fileType).sink { handler in
                if case .failure(let error) = handler {
                    Logger.log(.error, "Cant load '\(fileType)' file: \(error.localizedDescription)")
                    group.leave()
                }
            } receiveValue: { data in
                Logger.log(.success, "Received \(fileType)")
                answers.append(DataManager.shared.saveObject(data: data, to: fileType))
                group.leave()
            }
            .store(in: &cancellables)
        }
        group.notify(queue: .main) {
            completion(answers.allSatisfy { $0 })
        }
    }
}

// MARK: - Server State

extension NetworkManager {
    enum ServerState {
        case prod, dev
    }
}
