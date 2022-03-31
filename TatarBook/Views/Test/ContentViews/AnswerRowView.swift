//
//  AnswerRowView.swift
//  TatarBook
//
//  Created by halsab on 31.03.2022.
//

import SwiftUI

struct AnswerRowView: View {
    
    let answer: String
    @Binding var selectedAnswer: String
    
    private var backgroundColor: Color {
        isSelected ? Color.accentColor.opacity(0.3) : Color.clear
    }
    private var isSelected: Bool {
        answer == selectedAnswer
    }
    
    var body: some View {
        Button {
            selectedAnswer = answer
        } label: {
            Text(answer)
                .font(.system(.body, design: .serif))
                .foregroundColor(.primary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.secondary, lineWidth: 2)
                )
        }
        .background(backgroundColor)
        .animation(.easeIn(duration: 0.3), value: backgroundColor)
        .cornerRadius(8)
    }
}
