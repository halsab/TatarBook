//
//  VersionRowView.swift
//  TatarBook
//
//  Created by halsab on 02.06.2022.
//

import SwiftUI

struct VersionRowView: View {
    var name: String
    var version: String
    var body: some View {
        HStack {
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(.accentColor)
            Text(name)
                .font(.system(.callout, design: .serif))
            Spacer()
            Text(version)
                .font(.system(.callout, design: .monospaced))
        }
        .foregroundColor(.secondary)
    }
}

struct VersionRowView_Previews: PreviewProvider {
    static var previews: some View {
        VersionRowView(name: "name", version: "version")
    }
}
