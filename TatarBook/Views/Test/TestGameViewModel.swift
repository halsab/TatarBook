//
//  TestGameViewModel.swift
//  TatarBook
//
//  Created by halsab on 31.03.2022.
//

import SwiftUI
import Combine

class TestGameViewModel: ObservableObject {
    
    @Published var tests: [Test] = []
    @Published private var questions: [Question] = []
    @Published private var questionsCount: Int = 0
    
    @Published private var currntQuestionNumber: Int = 0
    @Published var status = ""
    @Published var question = ""
    @Published var answers: [String] = []
    @Published private var correctAnswer = ""
    @Published var selectedAnswer = ""
    @Published var progress: CGFloat = 0
    
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        $tests
            .sink { [unowned self] tests in
                questions = tests
                    .map { $0.questions }
                    .flatMap { $0 }
                questionsCount = questions.count
            }
            .store(in: &cancellabels)
        
        $currntQuestionNumber
            .sink { [unowned self] currntQuestionNumber in
                progress = CGFloat(currntQuestionNumber) / CGFloat(questionsCount)
                status = "\(currntQuestionNumber)/\(questionsCount)"
                if !questions.isEmpty {
                    setupGame(by: currntQuestionNumber)
                }
            }
            .store(in: &cancellabels)
    }
    
    func start() {
        currntQuestionNumber = 1
    }
    
    private func setupGame(by currntQuestionNumber: Int) {
        let currentQuestion = questions[currntQuestionNumber - 1]
        question = currentQuestion.text
        answers = currentQuestion.answers
        correctAnswer = currentQuestion.correctAnswer
    }
    
    func nextQuestion() {
        if currntQuestionNumber < questionsCount {
            currntQuestionNumber += 1
        }
    }
}
