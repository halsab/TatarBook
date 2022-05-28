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
    
    @State private var text1 = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack {
//            Button {
//                appManager.updateConfig { isSuccess in
//                    alertTitle = isSuccess ? "Яңартуларны тикшерү уңышлы узды" : "Хата, яңартуларны тикшереп булмады"
//                    alertText = isSuccess ? "" : ""
//                    showAlert = true
//                }
//            } label: {
//                Text("Яңартуларны тикшерергә")
//                    .capsuleButtonStyle()
//                    .padding()
//            }
            Button {
                isLoading = true
                appManager.loadAndSaveAllFiles { isSuccess in
                    isLoading = false
                    text1 = isSuccess ? "Success" : "Error"
                }
            } label: {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    Text("TEST")
                        .padding()
                        .foregroundColor(.white)
                        .background(.indigo)
                        .clipShape(Capsule())
                }
            }
            Text(text1)
                .padding()
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
