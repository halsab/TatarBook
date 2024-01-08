//
//  LoadButton.swift
//  TatarBook
//
//  Created by halsab on 02.06.2022.
//

import SwiftUI

struct LoadButton: View {
    var handle: () -> Void
    var body: some View {
        Button {
            handle()
        } label: {
            Image(systemName: "arrow.triangle.2.circlepath")
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
        }
    }
}

struct LoadButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadButton {}
    }
}
