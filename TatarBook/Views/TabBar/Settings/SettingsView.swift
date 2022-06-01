//
//  SettingsView.swift
//  TatarBook
//
//  Created by halsab on 26.05.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var appManager: AppManager

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $appManager.tintColor) {
                        ForEach(AppManager.TintColor.allCases) { tintColor in
                            Text(tintColor.rawValue)
                                .foregroundColor(tintColor.color)
                                .font(.system(.body, design: .serif))
                                .bold()
                                .tag(tintColor.color)
                        }
                    } label: {
                        Text("Кушымтаның төп төсе")
                            .font(.system(.body, design: .serif))
                    }
                }
            }
            .navigationTitle(Text("Көйләнеш"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
