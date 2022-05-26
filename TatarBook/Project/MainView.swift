//
//  MainView.swift
//  TatarBook
//
//  Created by halsab on 26.05.2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var appManager: AppManager
    
    var body: some View {
        VStack {
            if appManager.isFirstLoad {
                DownloadingView()
            } else {
                TabBarView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
