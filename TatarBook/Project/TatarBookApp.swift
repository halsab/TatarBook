//
//  TatarBookApp.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

@main
struct TatarBookApp: App {
    
    init() {
        if AppManager.shared.isNeedUpdateConfig {
            AppManager.shared.updateConfig()
        } else {
            Logger.log(.info, "There is no need to update config", withContext: false)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
