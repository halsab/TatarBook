//
//  SettingsView.swift
//  TatarBook
//
//  Created by halsab on 26.05.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var appManager: AppManager
    
    var body: some View {
        VStack(spacing: 16) {
            Button {
                appManager.loadAndSaveAllFiles { isSuccess in
                    Logger.log(.success, "Load all data: \(isSuccess ? "true" : "false")")
                }
            } label: {
                Text("Update all data")
            }
            Button {
                appManager.updateConfig()
            } label: {
                Text("Update config")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
