//
//  DownloadingView.swift
//  TatarBook
//
//  Created by halsab on 26.05.2022.
//

import SwiftUI

struct DownloadingView: View {
    
    @EnvironmentObject var appManager: AppManager
    @State private var isLoading = true
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                    .scaleEffect(1.5)
            } else {
                Button {
                    isLoading = true
                    download()
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                }
            }
        }
        .onAppear {
            download()
        }
    }
    
    private func download() {
        appManager.loadAndSaveAllFiles { isSuccess in
            isLoading = false
            if isSuccess {
                appManager.lastConfigUpdateDate = Date.now
                appManager.isFirstLoad = false
                appManager.isNeedLoad = false
                Logger.log(.success, "Loaded and saved all data")
            } else {
                Logger.log(.error, "Can't load and save all data")
            }
        }
    }
}
