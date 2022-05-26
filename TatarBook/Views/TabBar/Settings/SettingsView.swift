//
//  SettingsView.swift
//  TatarBook
//
//  Created by halsab on 26.05.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var appManager: AppManager
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isNeedUpdate = false
    @State private var lastUpdate = Date.now
    @State private var dateNow = Date.now
    
    var body: some View {
        VStack {
            Text("Last update: \(lastUpdate)")
                .font(.title2)
                .padding()
            Text("Now: \(dateNow)")
                .font(.title2)
                .padding()
            Text("Need update: \(isNeedUpdate ? "true" : "false")")
                .font(.title2)
                .padding()
            Text("Updated config: \(appManager.isUpdatedConfig ? "true" : "false")")
                .font(.title2)
                .padding()
            Text("Config")
                .font(.title2)
                .bold()
            ForEach(appManager.config.files, id: \.id) { file in
                HStack {
                    Text("file name: \(file.name)")
                    Spacer()
                    Text("version: \(file.version)")
                }
            }
            .padding()
            
            Button {
                appManager.updateConfig { isSuccess in
                    showingAlert = true
                    alertMessage = isSuccess ? "Config updated" : "Cant update config"
                }
            } label: {
                Text("Update")
                    .capsuleButtonStyle()
                    .padding()
            }
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("Ok", role: .cancel) { }
        }
        .onAppear {
            isNeedUpdate = appManager.isNeedUpdateConfig
            lastUpdate = appManager.lastConfigUpdateDate
            dateNow = Date.now
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
