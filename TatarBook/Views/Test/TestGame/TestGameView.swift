//
//  TestGameView.swift
//  TatarBook
//
//  Created by halsab on 31.03.2022.
//

import SwiftUI

struct TestGameView: View {
    
    @StateObject private var vm = TestGameViewModel()
    private let tests: [Test]
    
    init(tests: [Test]) {
        self.tests = tests
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Test status = \(vm.status)")
            Text(vm.question)
            VStack {
                ForEach(vm.answers, id: \.self) { answer in
                    Text(answer)
                }
            }
            Button {
                vm.nextQuestion()
            } label: {
                Text("Next Question")
                    .capsuleButtonStyle()
                    .padding(.horizontal)
            }

        }
        .onAppear {
            vm.tests = tests
            vm.start()
        }
    }
}

struct TestGameView_Previews: PreviewProvider {
    static var previews: some View {
        TestGameView(tests: [])
    }
}
