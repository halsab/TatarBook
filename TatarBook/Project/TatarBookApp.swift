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
            if appManager.isFirstLoad {
                DownloadingView()
                    .onAppear {
                        appManager.updateConfig() { isSuccess in
                            appManager.isFirstLoad = !isSuccess
                        }
                    }
            } else {
                TabBarView()
                    .onAppear {
                        if appManager.isNeedUpdateConfig {
                            appManager.updateConfig() { _ in }
                        }
                    }
                    .environmentObject(appManager)
            }
        }
    }
}
