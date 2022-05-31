//
//  TestSelectionRowView.swift
//  TatarBook
//
//  Created by halsab on 01.06.2022.
//

import SwiftUI

struct TestSelectionRowView: View {
    
    @Binding var selectedTests: Set<Test>
    let test: Test
    
    private var backgroundColor: Color {
        isSelected ? Color.accentColor.opacity(0.3) : Color.gray.opacity(0.3)
    }
    private var isSelected: Bool {
        selectedTests.contains(test)
    }
    
    var body: some View {
        Button {
            if selectedTests.contains(test) {
                selectedTests.remove(test)
            } else {
                selectedTests.insert(test)
            }
        } label: {
            HStack(spacing: 0) {
                Image(systemName: isSelected ? "checkmark.circle" : "circle")
                    .padding()
                Text(.init(test.name))
                    .font(.system(.body, design: .serif))
                    .foregroundColor(.primary)
                    .padding([.top, .bottom, .trailing])
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
        }
        .background(backgroundColor)
        .cornerRadius(12)
    }
}
