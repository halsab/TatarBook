//
//  TestGameManager.swift
//  TatarBook
//
//  Created by halsab on 29.03.2022.
//

import SwiftUI
import Combine

class TestGameManager: ObservableObject {
    
    @Published private var currntQuestionNumber: Int = 0
    @Published var status = ""

    private var cancellabels: Set<AnyCancellable> = []

    private let questions: [Question]
    private let questionsCount: Int
    
    init(tests: [Test]) {
        questions = tests
            .map { $0.questions }
            .flatMap { $0 }
        questionsCount = questions.count
        
        $currntQuestionNumber
            .sink { [unowned self] currentNumber in
                self.status = "\(questionsCount)/\(currentNumber)"
            }
            .store(in: &cancellabels)
    }
}
