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
            Form {
                Section {
                    ColorSchemePicker(colorScheme: $appManager.colorScheme)
                } header: {
                    Text("Кушымтаның төс схемасы")
                        .font(.system(.footnote, design: .serif))
                }
                Section {
                    TintColorPicker(tintColor: $appManager.tintColor)
                }
                Section {
                    VStack {
                        VersionRowView(name: "Кушымта", version: appVersion)
                        ForEach(appManager.config.files) { file in
                            Divider()
                            VersionRowView(name: appManager.config.getPrettyName(of: file), version: file.version)
                        }
                    }
                    .padding(.vertical, 8)
                } header: {
                    Text("Версиялар")
                        .font(.system(.footnote, design: .serif))
                }
                Section {
                    VStack(spacing: 8) {
                        Text("Бу кушымта «Иман» нәшрияте тарафыннан бастыралган «Иске татар имлясы буенча дәреслек» нигезендә ясалды.")
                        Text("Китапны төзүче: «Мөхәммәдия» мәдрәсәсе мөгаллиме, Апанай мәчетенең имамы, Әхмәт хәзрәт Сабыр.")
                        Text("Бастыру өчен җаваплы: тарих фәннәре кандидаты Нияз хәзрәт Сабиров.")
                    }
                    .font(.system(.callout, design: .serif))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                }
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
