//
//  SettingsView.swift
//  TatarBook
//
//  Created by halsab on 26.05.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var appManager: AppManager
    
    @State private var showAlert = false
    @State private var alertText = ""
    @State private var alertTitle = ""
    
    var body: some View {
        VStack {
            Button {
                appManager.updateConfig { isSuccess in
                    alertTitle = isSuccess ? "Яңартуларны тикшерү уңышлы узды" : "Хата, яңартуларны тикшереп булмады"
                    alertText = isSuccess ? "" : ""
                    showAlert = true
                }
            } label: {
                Text("Яңартуларны тикшерергә")
                    .capsuleButtonStyle()
                    .padding()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertText), dismissButton: .default(Text("Ок")))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
