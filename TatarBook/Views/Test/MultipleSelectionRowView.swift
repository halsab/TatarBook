//
//  MultipleSelectionRowView.swift
//  TatarBook
//
//  Created by halsab on 28.03.2022.
//

import SwiftUI

struct MultipleSelectionRowView: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                    .font(.system(.headline, design: .serif))
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                        .padding(.horizontal, 8)
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}

struct MultipleSelectionRowView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSelectionRowView(title: "Row 1", isSelected: false) {}
    }
}
