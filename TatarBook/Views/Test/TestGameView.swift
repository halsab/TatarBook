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
        ScrollView {
            VStack() {
                ZStack {
                    ProgressBar(progress: $vm.progress, color: .accentColor)
                    Text(vm.status)
                        .padding(.vertical, 8)
                        .font(.system(.caption, design: .monospaced))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .padding(.top)
                
                Text(vm.question)
                    .font(.system(.headline, design: .serif))
                    .padding()
                
                VStack {
                    ForEach(vm.answers, id: \.self) { answer in
                        AnswerRowView(answer: answer, selectedAnswer: $vm.selectedAnswer)
                            .padding(.horizontal)
                    }
                }
                
                Button {
                    withAnimation {
                        vm.nextQuestion()
                    }
                } label: {
                    Text("Next Question")
                        .capsuleButtonStyle()
                        .padding()
                }
                
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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
