//
//  Date+.swift
//  CustomKeyboard
//
//  Created by 효우 on 2022/07/14.
//

import Foundation

extension Date {
    var dateToRelativeTimeString: String {
        let formatter = RelativeDateTimeFormatter()
        let relativeFormatter = formatter.localizedString(for: self, relativeTo: Date())
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateTimeStyle = .named
        return relativeFormatter
    }
    
    var dateToOverTimeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY.MM.dd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        return formatter.string(from: self)
    }
}
