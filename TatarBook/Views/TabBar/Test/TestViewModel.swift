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
        tests = JSONSerializer.shared.getModel(of: file)
    }
}
