//
//  TestViewModel.swift
//  TatarBook
//
//  Created by halsab on 28.03.2022.
//

import SwiftUI
import Combine

class TestViewModel: ObservableObject {
    
    @Published var model: TestModel
    @Published var tests: [Test] = []
    @Published var selectedTests: [Test] = []
    @Published var currentVersion: String = ""
    
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        model = DataManager.shared.getLocalFile(type: .test) ?? TestModel(version: "", content: [])
        $model
            .sink { [unowned self] sinkModel in
                tests = sinkModel.content
                currentVersion = sinkModel.version
            }
            .store(in: &cancellabels)
    }
}
