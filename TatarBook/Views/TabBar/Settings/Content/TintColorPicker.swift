//
//  TintColorPicker.swift
//  TatarBook
//
//  Created by halsab on 02.06.2022.
//

import SwiftUI

struct TintColorPicker: View {
    @Binding var tintColor: Color
    var body: some View {
        Picker(selection: $tintColor) {
            ForEach(AppManager.TintColor.allCases) { tintColor in
                Text(tintColor.rawValue)
                    .foregroundColor(tintColor.color)
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .tag(tintColor.color)
            }
        } label: {
            Text("Кушымтаның төп төсе")
                .font(.system(.body, design: .rounded))
        }
    }
}

struct TintColorPicker_Previews: PreviewProvider {
    @State private static var tintColor: Color = .blue
    static var previews: some View {
        TintColorPicker(tintColor: $tintColor)
    }
}
