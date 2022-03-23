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
    
    static func console(
        _ level: LogLevel,
        _ object: Any,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
		#if DEBUG
        let time = " [\(currentTime())] "
        let context = " ➜ \(Context(file: file, function: function, line: line).description)"
        print(level.prefix + time + "\(object)" + (shouldLogContext ? context : ""))
		#endif
    }
    
    private struct Context {
        let file: String
        let function: String
        let line: Int
        var description: String {
            return "\((file as NSString).lastPathComponent):\(line) \(function)"
        }
    }
    
    private static func currentTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        return formatter.string(from: date)
    }
}

