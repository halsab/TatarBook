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
//                appManager.updateConfig()
                appManager.config = Config(files: [Config.File(name: "new file", version: "1.1.2")])
            } label: {
                Text("Update")
                    .capsuleButtonStyle()
                    .padding()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
