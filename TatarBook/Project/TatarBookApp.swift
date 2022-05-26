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
                    .environmentObject(appManager)
            } else {
                TabBarView()
                    .environmentObject(appManager)
            }
        }
    }
}
