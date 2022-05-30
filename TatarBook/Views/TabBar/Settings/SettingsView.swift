//
//  SettingsView.swift
//  TatarBook
//
//  Created by halsab on 26.05.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var appManager: AppManager
    
    @State private var text1 = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack {
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
                    Text("Update")
                }
            }
            Text(text1)
                .padding()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
