//
//  DownloadingView.swift
//  TatarBook
//
//  Created by halsab on 26.05.2022.
//

import SwiftUI

struct DownloadingView: View {
    
    @EnvironmentObject var appManager: AppManager
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .tint(.accentColor)
            .scaleEffect(2, anchor: .center)
            .onAppear {
                appManager.getAndSaveAll { isSuccess in
                    appManager.isFirstLoad = !isSuccess
                    appManager.isNeedLoad = !isSuccess
                }
            }
    }
}

struct DownloadingView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingView()
    }
}
