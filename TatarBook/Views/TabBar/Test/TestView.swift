//
//  TestView.swift
//  TatarBook
//
//  Created by halsab on 28.03.2022.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var appManager: AppManager
    @StateObject private var vm = TestViewModel()
    @State private var isLoading = false
    
    var body: some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(1.5)
        } else {
            NavigationView {
                VStack {
                    ScrollView {
                        ForEach(vm.tests, id: \.id) { test in
                            TestSelectionRowView(selectedTests: $vm.selectedTests, test: test)
                                .padding(.horizontal)
                                .padding(.top, 8)
                        }
                    }
                    Spacer()
                    if !vm.selectedTests.isEmpty {
                        NavigationLink {
                            TestGameView(tests: vm.selectedTests)
                        } label: {
                            Text(.init("Тестны башларга (\(vm.selectedTests.count)/\(vm.tests.count))"))
                                .font(.system(.title3, design: .serif))
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding(8)
                        }
                        .buttonStyle(BorderedButtonStyle())
                        .padding([.horizontal, .bottom])
                        .padding(.top, 8)
                    }
                }
                .navigationTitle(Text("Тест"))
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
            .onAppear {
                updateIfNeed()
            }
        }
    }
    
    private func updateIfNeed() {
        let configFileVersion = appManager.config.files
            .first(where: { $0.name == FileType.test.rawValue })?.version ?? ""
        if vm.currentVersion < configFileVersion {
            isLoading = true
            NetworkManager.shared.getModel(of: .test) { (model: TestModel?) in
                if let model = model {
                    DispatchQueue.main.async {
                        vm.model = model
                        isLoading = false
                    }
                } else {
                    isLoading = false
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
