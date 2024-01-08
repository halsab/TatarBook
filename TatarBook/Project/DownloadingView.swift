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
                ScaledProgressView()
            } else {
                LoadButton {
                    isLoading = true
                    download()
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
