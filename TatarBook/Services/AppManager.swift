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
    
    var isNeedUpdateConfig: Bool {
        Date.now > lastConfigUpdateDate.addingTimeInterval(86400)
    }
    
    init() {
        config = DataManager.shared.getLocalFile(type: .config) ?? Config(files: [])
        isNeedLoad = isFirstLoad
    }
    
    func loadAndSaveAllFiles(completion: @escaping (Bool) -> Void) {
        let dispatchGroup = DispatchGroup()
        var answers: [Bool] = []
        for fileType in FileType.allCases {
            dispatchGroup.enter()
            loadAndSave(fileType: fileType) { isSuccess in
                answers.append(isSuccess)
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(answers.allSatisfy({ $0 }))
        }
        
        func loadAndSave(fileType: FileType, completion: @escaping (Bool) -> Void) {
            NetworkManager.shared.getData(of: fileType) { data in
                guard let data = data,
                      isDecodable(fileType: fileType, data: data)
                else {
                    completion(false)
                    return
                }
                completion(DataManager.shared.saveObject(data: data, to: fileType))
            }
            
            func isDecodable(fileType: FileType, data: Data) -> Bool {
                switch fileType {
                case .config:
                    if let _: Config = DataManager.shared.getObject(from: data) { return true }
                case .book:
                    if let _: BookModel = DataManager.shared.getObject(from: data) { return true }
                case .test:
                    if let _: TestModel = DataManager.shared.getObject(from: data) { return true }
                case .dictionary:
                    if let _: DictionaryModel = DataManager.shared.getObject(from: data) { return true }
                }
                return false
            }
        }
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
            return (UserDefaults.standard.object(forKey: UDKey.lastConfigUpdateDate.rawValue) as? Date) ?? Date.now
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UDKey.lastConfigUpdateDate.rawValue)
        }
    }
    
    var isFirstLoad: Bool {
        get {
            return (UserDefaults.standard.object(forKey: UDKey.isFirstLoad.rawValue) as? Bool) ?? true
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UDKey.isFirstLoad.rawValue)
        }
    }
}
