//
//  SettingsView.swift
//  TatarBook
//
//  Created by halsab on 26.05.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var appManager: AppManager
    
    private var appVersion: String {
        (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        ColorSchemePicker(colorScheme: $appManager.colorScheme)
                    } header: {
                        Text("Кушымтаның төс схемасы")
                            .font(.system(.footnote, design: .rounded))
                    }
                    Section {
                        TintColorPicker(tintColor: $appManager.tintColor)
                    }
                    Section {
                        VStack(spacing: 8) {
                            Text("Бу кушымта «Иман» нәшрияте тарафыннан бастыралган «Иске татар имлясы буенча дәреслек» нигезендә ясалды.")
                            Text("Китапны төзүче: «Мөхәммәдия» мәдрәсәсе мөгаллиме, Апанай мәчетенең имамы, Әхмәт хәзрәт Сабыр.")
                            Text("Бастыру өчен җаваплы: тарих фәннәре кандидаты Нияз хәзрәт Сабиров.")
                        }
                        .font(.system(.callout, design: .rounded))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    }
                }
                // Versions of app and docs
                Text(
                """
                A(\(appVersion)) \
                B(\(appManager.config.files.first(where: { $0.name == FileType.book.rawValue })?.version ?? "")) \
                T(\(appManager.config.files.first(where: { $0.name == FileType.test.rawValue })?.version ?? "")) \
                D(\(appManager.config.files.first(where: { $0.name == FileType.dictionary.rawValue })?.version ?? ""))
                """
                )
                .font(.system(.footnote, design: .monospaced))
                .foregroundColor(.secondary)
                .padding([.horizontal, .bottom])
            }
            .navigationTitle(Text("Көйләнеш"))
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .onAppear {
            appManager.updateConfig()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
