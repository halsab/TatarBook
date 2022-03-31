//
//  TestGameView.swift
//  TatarBook
//
//  Created by halsab on 31.03.2022.
//

import SwiftUI

struct TestGameView: View {
    
    @Environment(\.presentationMode) var presentationMode
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
                .padding([.horizontal, .top])
                
                Text(vm.question)
                    .font(.system(.headline, design: .serif))
                    .multilineTextAlignment(.center)
                    .padding()
                
                VStack {
                    ForEach(vm.answers, id: \.self) { answer in
                        AnswerRowView(
                            answer: answer,
                            correctAnswer: vm.correctAnswer,
                            selectedAnswer: $vm.selectedAnswer
                        )
                        .padding(.horizontal)
                    }
                }
                
                if !vm.selectedAnswer.isEmpty {
                    Button {
                        withAnimation {
                            vm.nextQuestion()
                        }
                    } label: {
                        Text(vm.mainButtonTitle)
                            .capsuleButtonStyle()
                            .padding()
                    }
                }
                
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.tests = tests
            vm.start()
        }
        .alert("Тест тәмам!", isPresented: $vm.gameOver, actions: {
            Button("Яхшы", role: .cancel) {
                presentationMode.wrappedValue.dismiss()
            }
        }, message: {
            Text("Дөрес җаваплар: \(vm.score)\nБарлыгы сораулар: \(vm.questionsCount)")
        })
    }
}

struct TestGameView_Previews: PreviewProvider {
    static var previews: some View {
        TestGameView(tests: [])
    }
}
