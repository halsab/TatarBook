//
//  TestContentView.swift
//  TatarBook
//
//  Created by halsab on 02.06.2022.
//

import SwiftUI

struct TestContentView: View {
    @Binding var tests: [Test]
    @Binding var selectedTests: Set<Test>
    var body: some View {
        VStack {
            ScrollView {
                ForEach(tests, id: \.id) { test in
                    TestSelectionRowView(selectedTests: $selectedTests, test: test)
                        .padding(.horizontal)
                        .padding(.top, 8)
                }
            }
            Spacer()
            if !selectedTests.isEmpty {
                NavigationLink {
                    TestGameView(tests: selectedTests)
                } label: {
                    Text(.init("Тестны башларга (\(selectedTests.count)/\(tests.count))"))
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
    }
}

struct TestContentView_Previews: PreviewProvider {
    @State private static var tests: [Test] = []
    @State private static var selectedTests: Set<Test> = []
    static var previews: some View {
        TestContentView(tests: $tests, selectedTests: $selectedTests)
    }
}
