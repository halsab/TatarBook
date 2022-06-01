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
            if appManager.isNeedLoad {
                DownloadingView()
                    .accentColor(appManager.tintColor)
                    .environmentObject(appManager)
            } else {
                TabBarView()
                    .accentColor(appManager.tintColor)
                    .environmentObject(appManager)
            }
        }
    }
}
