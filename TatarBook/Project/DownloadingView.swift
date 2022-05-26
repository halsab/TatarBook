//
//  DownloadingView.swift
//  TatarBook
//
//  Created by halsab on 26.05.2022.
//

import SwiftUI

struct DownloadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .tint(.accentColor)
            .scaleEffect(2, anchor: .center)
    }
}

struct DownloadingView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingView()
    }
}
