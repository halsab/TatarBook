//
//  Question.swift
//  TatarBook
//
//  Created by halsab on 28.03.2022.
//

import Foundation

struct Question: Serializable {
    let text: String
    let wrongAnswers: [String]
    let correctAnswer: String
}
