//
//  TestGameViewModel.swift
//  TatarBook
//
//  Created by halsab on 31.03.2022.
//

import SwiftUI
import Combine

class TestGameViewModel: ObservableObject {
    
    @Published var tests: Set<Test> = []
    @Published private var questions: [Question] = []
    @Published var questionsCount: Int = 0
    
    @Published private var currntQuestionNumber: Int = 0
    @Published var status = ""
    @Published var question = ""
    @Published var answers: [String] = []
    @Published var correctAnswer = ""
    
    @Published var score = 0
    @Published var gameOver = false
    
    @Published var selectedAnswer = ""
    @Published var progress: CGFloat = 0
    
    @Published var mainButtonTitle = ""

    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        $tests
            .sink { [unowned self] tests in
                questions = tests
                    .map { $0.questions }
                    .flatMap { $0 }
                    .shuffled()
                questionsCount = questions.count
            }
            .store(in: &cancellabels)
        
        $currntQuestionNumber
            .sink { [unowned self] currntQuestionNumber in
                progress = CGFloat(currntQuestionNumber) / CGFloat(questionsCount)
                status = "\(currntQuestionNumber)/\(questionsCount)"
                if !questions.isEmpty {
                    setupQuestion(by: currntQuestionNumber)
                }
                mainButtonTitle = currntQuestionNumber == questionsCount ? "Тәмамларга" : "Киләсе сорау"
            }
            .store(in: &cancellabels)
    }
    
    func start() {
        currntQuestionNumber = 1
    }
    
    private func setupQuestion(by currntQuestionNumber: Int) {
        let currentQuestion = questions[currntQuestionNumber - 1]
        question = currentQuestion.text
        answers = currentQuestion.answers
        correctAnswer = currentQuestion.correctAnswer
        selectedAnswer = ""
    }
    
    func nextQuestion() {
        if selectedAnswer == correctAnswer {
            score += 1
        }
        if currntQuestionNumber < questionsCount {
            currntQuestionNumber += 1
        } else {
            gameOver = true
        }
        
    }
}
