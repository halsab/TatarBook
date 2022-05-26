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
    
    init() {
        config = Config(files: [])
    }
    
    func isNeedUpdateConfig() -> Bool {
        Date.now < lastConfigUpdateDate.addingTimeInterval(86400)
    }
    
    func getLocalConfig() {
        if let config: Config = DataManager.shared.getLocalObject(for: .config) {
            Logger.log(.success, "Config exist and accepted")
            self.config = config
        } else {
            Logger.log(.warning, "There is no config file locally saved")
        }
    }
    
    func updateConfig() {
        Logger.log(.info, "Update config", withContext: false)
        NetworkManager.shared.getData(for: .config) { [unowned self] data in
            guard let data = data else { return }
            if let config: Config = DataManager.shared.getObject(from: data) {
                Logger.log(.success, "Config updated", withContext: false)
                self.config = config
                lastConfigUpdateDate = Date.now
            } else {
                Logger.log(.error, "Cant update config", withContext: false)
            }
        }
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
