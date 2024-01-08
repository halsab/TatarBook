//
//  AnswerRowView.swift
//  TatarBook
//
//  Created by halsab on 31.03.2022.
//

import SwiftUI

struct AnswerRowView: View {
    
    let answer: String
    let correctAnswer: String
    @Binding var selectedAnswer: String
    
    private var backgroundColor: Color {
        if isSelected {
            return (answer == correctAnswer ? Color.green : Color.red).opacity(0.3)
        }
        return .clear
    }
    private var isSelected: Bool {
        answer == selectedAnswer
    }
    
    var body: some View {
        Button {
            if selectedAnswer.isEmpty {
                selectedAnswer = answer
            }
        } label: {
            HStack(spacing: 0) {
                if isSelected {
                    Image(systemName: answer == correctAnswer ? "checkmark.circle" : "xmark.circle")
                        .foregroundColor(answer == correctAnswer ? Color.green : Color.red)
                        .padding()
                } else {
                    Image(systemName: "circle")
                        .padding()
                }
                
                Text(answer)
                    .font(.system(.body, design: .serif))
                    .foregroundColor(.primary)
                    .padding([.top, .bottom, .trailing])
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
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
