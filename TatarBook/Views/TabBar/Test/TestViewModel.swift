//
//  TestViewModel.swift
//  TatarBook
//
//  Created by halsab on 28.03.2022.
//

import SwiftUI
import Combine

class TestViewModel: ObservableObject {
    
    @Published var model: TestModel = TestModel(version: "", content: [])
    @Published var tests: [Test] = []
    @Published var selectedTests: Set<Test> = []
    @Published var currentVersion: String = ""
    @Published var isLoading = false
    @Published var needData = false
    
    private var cancellabels: Set<AnyCancellable> = []
    
    init() {
        model = DataManager.shared.getLocalFile(type: .test) ?? TestModel(version: "", content: [])
        $model
            .sink { [unowned self] sinkModel in
                tests = sinkModel.content
                needData = tests.isEmpty
                currentVersion = sinkModel.version
            }
            .store(in: &cancellabels)
    }
    
    func update() {
        isLoading = true
        NetworkManager.shared.getModel(of: .test) { [weak self] (model: TestModel?) in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let model = model {
                    self?.model = model
                }
            }
        }
    }
}
