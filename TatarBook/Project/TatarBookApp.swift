//
//  TatarBookApp.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

@main
struct TatarBookApp: App {
    
    @StateObject var appManager = AppManager()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .onAppear {
                    appManager.getLocalConfig()
                    if appManager.isNeedUpdateConfig() {
                        appManager.updateConfig()
                    } else {
                        Logger.log(.info, "There is no need to update config", withContext: false)
                    }
                }
                .environmentObject(appManager)
        }
    }
}
