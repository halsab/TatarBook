//
//  Logger.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import Foundation

enum Logger {
    enum LogLevel {
        case debug, success, info, warning, error
        fileprivate var prefix: String {
            switch self {
            case .debug: return "🐞-🟣"
            case .success: return "🐞-🟢"
            case .info: return "🐞-⚪️"
            case .warning: return "🐞-🟡"
            case .error: return "🐞-🔴"
            }
        }
    }
    
    static func log(
        _ level: LogLevel,
        _ object: Any,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
		#if DEBUG
        let info = level.prefix + getLogInfo(object,
                                             shouldLogContext: shouldLogContext,
                                             file: file,
                                             function: function,
                                             line: line)
        print(info)
		#endif
    }
    
    private static func getLogInfo(
        _ object: Any,
        shouldLogContext: Bool,
        file: String,
        function: String,
        line: Int
    ) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        let time = " [\(formatter.string(from: date))] "
        let context = " ➜ " + "\((file as NSString).lastPathComponent):\(line) \(function)"
        return time + "\(object)" + (shouldLogContext ? context : "")
    }
}

