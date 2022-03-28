//
//  MultipleSelectionRow.swift
//  TatarBook
//
//  Created by halsab on 28.03.2022.
//

import SwiftUI

struct MultipleSelectionRow: View {
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
                        .padding(.leading)
                }
            }
        }
    }
}

struct MultipleSelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSelectionRow(title: "Row 1", isSelected: false) {}
    }
}
