//
//  ProgressBar.swift
//  TatarBook
//
//  Created by halsab on 31.03.2022.
//

import SwiftUI

struct ProgressBar: View {
    
    @Binding var progress: CGFloat
    private var barColor: Color
    private let cornerRadius: CGFloat = 8
    
    init(progress: Binding<CGFloat>, color: Color) {
        _progress = progress
        barColor = color.opacity(0.3)
    }
    
    var body: some View {
        GeometryReader { geo in
            Rectangle()
                .fill(barColor)
                .cornerRadius(cornerRadius)
                .frame(width: min(geo.size.width, geo.size.width * progress))
                .animation(.linear, value: true)
        }
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(barColor, lineWidth: 2)
        )
    }
}
