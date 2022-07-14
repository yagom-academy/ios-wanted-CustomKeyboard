//
//  String+.swift
//  CustomKeyboard
//
//  Created by 효우 on 2022/07/14.
//

import Foundation

extension String {
    var stringToDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        guard let date = dateFormatter.date(from: self) else { return nil }
        return date
    }
}
