//
//  TestViewModel.swift
//  TatarBook
//
//  Created by halsab on 28.03.2022.
//

import SwiftUI

class TestViewModel: ObservableObject {
    
    @Published var tests: [Test]
    @Published var selectedTests: [Test] = []
    
    init() {
        let file = FileName(name: "test", type: "json")
        let testModel: TestModel = JSONSerializer.shared.getModel(of: file)
        tests = testModel.content
    }
}
