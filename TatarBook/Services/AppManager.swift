//
//  AppManager.swift
//  TatarBook
//
//  Created by halsab on 25.05.2022.
//

import Foundation

class AppManager: ObservableObject {
    
    @Published var config: Config
    @Published var isNeedLoad = true
    
    private let UD = UserDefaults.standard
    private let configUpdateTimeInterval: TimeInterval = 86400 // 24 hours in seconds
    
    var isNeedUpdateConfig: Bool {
        Date.now > lastConfigUpdateDate.addingTimeInterval(configUpdateTimeInterval)
    }
    
    init() {
        config = DataManager.shared.getLocalFile(type: .config) ?? Config(files: [])
        isNeedLoad = isFirstLoad
    }
}

// MARK: - User Defaults

extension AppManager {
    enum UDKey: String {
        case lastConfigUpdateDate
        case isFirstLoad
    }
    
    var lastConfigUpdateDate: Date {
        get {
            return (UD.object(forKey: UDKey.lastConfigUpdateDate.rawValue) as? Date) ?? Date.now
        }
        set {
            UD.set(newValue, forKey: UDKey.lastConfigUpdateDate.rawValue)
        }
    }
    
    var isFirstLoad: Bool {
        get {
            return (UD.object(forKey: UDKey.isFirstLoad.rawValue) as? Bool) ?? true
        }
        set {
            UD.set(newValue, forKey: UDKey.isFirstLoad.rawValue)
        }
    }
}

// MARK: - Networking

extension AppManager {
    func loadAndSaveAllFiles(completion: @escaping (Bool) -> Void) {
        let dispatchGroup = DispatchGroup()
        var answers: [Bool] = []
        for fileType in FileType.allCases {
            dispatchGroup.enter()
            switch fileType {
            case .config:
                NetworkManager.shared.getModel(of: fileType) { (model: Config?) in
                    answers.append(model != nil)
                    dispatchGroup.leave()
                }
            case .book:
                NetworkManager.shared.getModel(of: fileType) { (model: BookModel?) in
                    answers.append(model != nil)
                    dispatchGroup.leave()
                }
            case .test:
                NetworkManager.shared.getModel(of: fileType) { (model: TestModel?) in
                    answers.append(model != nil)
                    dispatchGroup.leave()
                }
            case .dictionary:
                NetworkManager.shared.getModel(of: fileType) { (model: DictionaryModel?) in
                    answers.append(model != nil)
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(answers.allSatisfy { $0 })
        }
    }
    
    func updateConfig() {
        NetworkManager.shared.getData(of: .config) { [unowned self] data in
            guard let data = data,
                  let config: Config = DataManager.shared.getObject(from: data) else { return }
            if DataManager.shared.saveObject(data: data, to: .config) {
                self.lastConfigUpdateDate = Date.now
                DispatchQueue.main.async {
                    self.config = config
                    Logger.log(.success, "Config updated")
                }
            } else {
                Logger.log(.error, "Can't update config")
            }
        }
    }
    
    func updateFileIfNeed<T: Decodable>(
        type fileType: FileType,
        version currentVersion: String,
        completion: @escaping (T?) -> Void
    ) {
        let configFileVersion = config.files.first(where: { $0.name == fileType.rawValue })?.version ?? ""
        if currentVersion < configFileVersion {
            Logger.log(.info, "Update '\(fileType)'")
            NetworkManager.shared.getModel(of: fileType) { (model: T?) in
                if let model = model {
                    Logger.log(.success, "'\(fileType)' updated")
                    completion(model)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
