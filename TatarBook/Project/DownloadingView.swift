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
                    .scaleEffect(2)
            } else {
                if appManager.isNeedLoad {
                    VStack {
                        Button {
                            isLoading = true
                            downloadAll()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48.0, height: 48.0)
                        }
                    }
                }
            }
        }
        .onAppear {
            downloadAll()
        }
    }
    
    private func downloadAll() {
        appManager.getAndSaveAll { isSuccess in
            isLoading = false
            if isSuccess {
                appManager.lastConfigUpdateDate = Date.now
                appManager.isFirstLoad = false
                appManager.isNeedLoad = false
            }
        }
    }
}

struct DownloadingView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingView()
    }
}
