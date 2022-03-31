//
//  Extensions+Text.swift
//  TatarBook
//
//  Created by halsab on 28.03.2022.
//

import SwiftUI

// MARK: - Button Style Modifier

struct CapsuleButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.primary)
            .background(Color.accentColor.opacity(0.3))
            .clipShape(Capsule())
    }
}

extension View {
    func capsuleButtonStyle() -> some View {
        modifier(CapsuleButtonStyle())
    }
}
