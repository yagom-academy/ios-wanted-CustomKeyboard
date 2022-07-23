//
//  DateFormatter_Extension.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/11.
//

import Foundation

extension DateFormatter {
    func toDate(from timeString: String, _ format: String) -> Date {
        self.dateFormat = format
        self.timeZone = TimeZone(abbreviation: "KST")
        return date(from: timeString) ?? Date()
    }
    
    func toString(from timeDate: Date, _ format: String) -> String {
        self.dateFormat = format
        return string(from: timeDate)
    }
}
