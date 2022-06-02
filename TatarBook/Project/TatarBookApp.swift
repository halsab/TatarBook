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
            Group {
                if appManager.isNeedLoad {
                    DownloadingView()
                } else {
                    TabBarView()
                }
            }
            .preferredColorScheme(appManager.colorScheme)
            .accentColor(appManager.tintColor)
            .environmentObject(appManager)
        }
    }
}
