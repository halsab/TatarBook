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
    
    var body: some View {
            NavigationView {
                MainContentView(
                    isLoading: $vm.isLoading,
                    showReloadButton: $vm.needData,
                    contentView: AnyView(
                        TestContentView(
                            tests: $vm.tests,
                            selectedTests: $vm.selectedTests
                        )
                    )
                ) {
                    updateIfNeed()
                }
                .navigationTitle(Text("Тест"))
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
            .onAppear {
                updateIfNeed()
            }
    }
    
    private func updateIfNeed() {
        appManager.updateFileIfNeed(.test, vm.currentVersion, isNoInfo: vm.needData) {
            vm.update()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
