//
//  TestViewModel.swift
//  TatarBook
//
//  Created by halsab on 28.03.2022.
//

import SwiftUI

class TestViewModel: ObservableObject {
    
    @Published var tests: [Test] = []
    @Published var selectedTests: [Test] = []
    
    init() {
        if let testModel: TestModel = DataManager.shared.getLocalFile(type: .test) {
            tests = testModel.content
        }
    }
}
