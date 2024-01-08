//
//  MainContentView.swift
//  TatarBook
//
//  Created by halsab on 02.06.2022.
//

import SwiftUI

struct MainContentView: View {
    @Binding var isLoading: Bool
    @Binding var showReloadButton: Bool
    var contentView: AnyView
    var handleReloadButton: () -> Void
    var body: some View {
        if isLoading {
            ScaledProgressView()
        } else if showReloadButton {
            LoadButton {
                handleReloadButton()
            }
        } else {
            contentView
        }
    }
}
