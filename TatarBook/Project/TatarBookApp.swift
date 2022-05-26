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
        AppManager.shared.updateConfig()
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
