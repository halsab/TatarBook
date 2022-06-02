//
//  ColorSchemePicker.swift
//  TatarBook
//
//  Created by halsab on 02.06.2022.
//

import SwiftUI

struct ColorSchemePicker: View {
    @Binding var colorScheme: ColorScheme?
    var body: some View {
        Picker("", selection: $colorScheme) {
            ForEach(AppManager.AppColorScheme.allCases) { colorScheme in
                Text(colorScheme.rawValue)
                    .tag(colorScheme.mode)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct ColorSchemePicker_Previews: PreviewProvider {
    @State private static var colorScheme: ColorScheme? = .none
    static var previews: some View {
        ColorSchemePicker(colorScheme: $colorScheme)
    }
}
