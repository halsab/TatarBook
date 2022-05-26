//
//  AppManager.swift
//  TatarBook
//
//  Created by halsab on 25.05.2022.
//

import Foundation
import Combine

class AppManager: ObservableObject {
    
    @Published var config: Config
    
    private var cancellables: Set<AnyCancellable> = []
    
    var isNeedUpdateConfig: Bool {
        Date.now < lastConfigUpdateDate.addingTimeInterval(86400)
    }
    
    init() {
        config = DataManager.shared.getLocalFile(type: .config) ?? Config(files: [])
    }
    
    func updateConfig(completion: @escaping (Bool) -> Void) {
        NetworkManager.shared.getFile(type: .config)
            .receive(on: RunLoop.main)
            .sink { handler in
                if case .failure(let error) = handler {
                    Logger.log(.error, "Cant update config: \(error.localizedDescription)")
                    completion(false)
                }
            } receiveValue: { [unowned self] (config: Config) in
                Logger.log(.success, "Config updated", withContext: false)
                self.config = config
                self.lastConfigUpdateDate = Date.now
                completion(true)
            }
            .store(in: &cancellables)
    }
}

// MARK: - User Defaults

extension AppManager {
    enum UDKey: String {
        case lastConfigUpdateDate
    }
    
    var lastConfigUpdateDate: Date {
        get {
            return (UserDefaults.standard.object(forKey: UDKey.lastConfigUpdateDate.rawValue) as? Date) ?? Date.now
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UDKey.lastConfigUpdateDate.rawValue)
        }
    }
}
