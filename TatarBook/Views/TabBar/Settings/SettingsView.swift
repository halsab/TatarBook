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
    
    var body: some View {
        VStack {
            Text("Config")
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
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
