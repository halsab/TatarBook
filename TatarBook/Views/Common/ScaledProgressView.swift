//
//  ScaledProgressView.swift
//  TatarBook
//
//  Created by halsab on 02.06.2022.
//

import SwiftUI

struct ScaledProgressView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.accentColor)
            .scaleEffect(1.5)
    }
}

struct ScaledProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ScaledProgressView()
    }
}
