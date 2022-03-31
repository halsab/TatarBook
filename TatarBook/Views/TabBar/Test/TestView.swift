//
//  TestView.swift
//  TatarBook
//
//  Created by halsab on 28.03.2022.
//

import SwiftUI

struct TestView: View {
    
    @StateObject private var vm = TestViewModel()
    
    var body: some View {
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
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
