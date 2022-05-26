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
    
    init() {
        config = Config(files: [])
    }
    
    func isNeedUpdateConfig() -> Bool {
        Date.now < lastConfigUpdateDate.addingTimeInterval(86400)
    }
    
    func getLocalConfig() {
        if let config: Config = DataManager.shared.getLocalFile(type: .config) {
            self.config = config
        }
    }
    
    func updateConfig() {
        NetworkManager.shared.getFile(type: .config)
            .receive(on: RunLoop.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    Logger.log(.error, "Cant update config: \(error.localizedDescription)")
                }
            } receiveValue: { [unowned self] (config: Config) in
                Logger.log(.success, "Config updated", withContext: false)
                self.config = config
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
