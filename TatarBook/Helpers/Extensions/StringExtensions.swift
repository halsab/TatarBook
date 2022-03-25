//
//  StringExtensions.swift
//  TatarBook
//
//  Created by Ha Sab on 25.03.2022.
//

import Foundation
import NaturalLanguage

extension String {
    var isArabic: Bool {
        let arabicCodes: Set<String> = ["ar", "ur"]
        let languageRecognizer = NLLanguageRecognizer()
        languageRecognizer.processString(self)
        if let code = languageRecognizer.dominantLanguage?.rawValue {
            return arabicCodes.contains(code)
        } else {
            return false
        }
    }
}
