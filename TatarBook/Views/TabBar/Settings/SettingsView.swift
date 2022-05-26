//
//  SettingsView.swift
//  TatarBook
//
//  Created by halsab on 26.05.2022.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Config")
                .bold()
            ForEach(appManager.config.files, id: \.id) { file in
                Text("file name: \(file.name); version: \(file.version)")
            }
            Button {
                appManager.updateConfig()
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
