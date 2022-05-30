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
                    List {
                        ForEach(vm.tests) { test in
                            SelectionRowView(title: test.name, isSelected: vm.selectedTests.contains(test)) {
                                if vm.selectedTests.contains(test) {
                                    vm.selectedTests.removeAll(where: { $0 == test })
                                } else {
                                    vm.selectedTests.append(test)
                                }
                            }
                        }
                    }
                    
                    NavigationLink {
                        TestGameView(tests: vm.selectedTests)
                    } label: {
                        Text("Тестны башларга")
                            .capsuleButtonStyle()
                            .padding()
                    }
                    .disabled(vm.selectedTests.isEmpty)
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
        let configFileVersion = appManager.config.files.first(where: { $0.name == FileType.test.rawValue })?.version ?? ""
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
