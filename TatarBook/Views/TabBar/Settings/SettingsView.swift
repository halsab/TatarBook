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
                    VStack(spacing: 8) {
                        Text("Бу кушымта «Иман» нәшрияте тарафыннан бастыралган «Иске татар имлясы буенча дәреслек» нигезендә ясалды.")
                        Text("Китапны төзүче: «Мөхәммәдия» мәдрәсәсе мөгаллиме, Апанай мәчетенең имамы, Әхмәт хәзрәт Сабыр.")
                        Text("Бастыру өчен җаваплы: тарих фәннәре кандидаты Нияз хәзрәт Сабиров.")
                    }
                    .font(.system(.callout, design: .serif))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                }
                Section {
                    HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Кушымта ")
                            ForEach(appManager.config.files) { file in
                                Text(appManager.config.getPrettyName(of: file) + " ")
                            }
                        }
                        VStack(alignment: .trailing) {
                            Text(appVersion)
                            ForEach(appManager.config.files) { file in
                                Text(file.version)
                            }
                        }
                        Spacer()
                    }
                    .font(.system(.footnote, design: .monospaced))
                    .foregroundColor(.secondary)
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
