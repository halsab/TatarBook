//
//  AppManager.swift
//  TatarBook
//
//  Created by halsab on 25.05.2022.
//

import SwiftUI
import Combine

class AppManager: ObservableObject {
    
    @Published var config: Config
    @Published var isNeedLoad = true
    @Published var tintColor: Color = .blue
    
    private var cancellabels: Set<AnyCancellable> = []
    
    private let UD = UserDefaults.standard
    private let configUpdateTimeInterval: TimeInterval = 86400 // 24 hours in seconds
    
    var isNeedUpdateConfig: Bool {
        Date.now > lastConfigUpdateDate.addingTimeInterval(configUpdateTimeInterval)
    }
    
    init() {
        config = DataManager.shared.getLocalFile(type: .config) ?? Config(files: [])
        tintColor = storedTintColor.color
        $tintColor
            .sink(receiveValue: { [unowned self] sinkTintColor in
                for storedTintColor in TintColor.allCases {
                    if storedTintColor.color == sinkTintColor {
                        self.storedTintColor = storedTintColor
                    }
                }
            })
            .store(in: &cancellabels)
        isNeedLoad = isFirstLoad
    }
}

// MARK: - User Defaults

extension AppManager {
    enum UDKey: String {
        case lastConfigUpdateDate
        case isFirstLoad
        case storedTintColor
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
    
    var storedTintColor: TintColor {
        get {
            if let data = UD.data(forKey: UDKey.storedTintColor.rawValue),
               let tintColor = try? JSONDecoder().decode(TintColor.self, from: data) {
             	return tintColor
            } else {
                return .blue
            }
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UD.set(data, forKey: UDKey.storedTintColor.rawValue)
            }
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
        NetworkManager.shared.getModel(of: .config) { [unowned self] (config: Config?) in
            guard let config = config else { return }
            lastConfigUpdateDate = Date.now
            DispatchQueue.main.async {
                self.config = config
            }
        }
    }
}

// MARK: Tint Color

extension AppManager {
    enum TintColor: String, CaseIterable, Identifiable, Codable {
        case cyan = "Күк зәңгәр"
        case blue = "Зәңгәр"
        case indigo = "Шәмәхә"
        case red = "Кызыл"
        case monochrome = "Монохром"
        
        var id: Self { self }
        
        var color: Color {
            switch self {
            case .cyan:
                return .cyan
            case .blue:
                return .blue
            case .indigo:
                return .indigo
            case .red:
                return .red
            case .monochrome:
                return .primary
            }
        }
    }
}
