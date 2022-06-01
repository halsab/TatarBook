//
//  DictViewModel.swift
//  TatarBook
//
//  Created by halsab on 01.06.2022.
//

import SwiftUI
import Combine

struct TestObjext {
    let id = UUID()
    let char: String
    let number: String
    
    var searchString: String {
        (char + number).lowercased()
    }
}

class DictViewModel: ObservableObject {
    
    @Published var filteredObjects: [TestObjext] = []
    @Published var searchQuery = ""
    
    private var anyCancellables: Set<AnyCancellable> = []
    
    var allObjects: [TestObjext] {
//        let chars = "qwertyuiopasdfghjklzxcvbnm".sorted()
//        var allObjects: [TestObjext] = []
//        for (i, char) in chars.enumerated() {
//            allObjects.append(TestObjext(char: String(char), number: String(i)))
//        }
//        return allObjects
        let chars = "qwertyuiopasdfghjklzxcvbnm"
        let numbers = (0..<50000).map({ "\($0)" })
        return numbers.map {
            TestObjext(char: String(chars.shuffled().first!), number: $0)
        }
    }
    
    init() {
//        filteredObjects = allObjects
        $searchQuery
            .sink(receiveValue: { [unowned self] searchQueryValue in
                if searchQueryValue.isEmpty {
                    filteredObjects = allObjects
                } else {
                    filteredObjects = allObjects
                        .filter { $0.searchString.contains(searchQueryValue.lowercased()) }
                }
            })
            .store(in: &anyCancellables)
    }
}
