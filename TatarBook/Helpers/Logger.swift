//
//  Logger.swift
//  TatarBook
//
//  Created by Ha Sab on 23.03.2022.
//

import Foundation

enum Logger: String {
    case debug = "//-🟣"
    case success = "//-🟢"
    case info = "//-⚪️"
    case warning = "//-🟡"
    case error = "//-🔴"
    
    static func log(
        _ level: Logger,
        _ object: Any,
        withContext: Bool = true,
        file: String = #file,
        function: String = #function
    ) {
		#if DEBUG
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSSS"
        let time = " [\(formatter.string(from: Date.now))] "
        let context = " ➜ " + "\((file as NSString).lastPathComponent): \(function)"
        let info = level.rawValue + time + "\(object)" + (withContext ? context : "")
        print(info)
        #endif
    }
}
