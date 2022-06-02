//
//  TabBarView.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var appManager: AppManager
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        TabView {
            BookView()
                .tabItem {
                    Label("Китап", systemImage: "books.vertical")
                }
            TestView()
                .tabItem {
                    Label("Тест", systemImage: "list.number")
                }
            DictionaryView()
                .tabItem {
                    Label("Сүзлек", systemImage: "textformat")
                }
            SettingsView()
                .tabItem {
                    Label("Көйләнеш", systemImage: "gear")
                }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active, appManager.isNeedUpdateConfig {
                appManager.updateConfig()
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
