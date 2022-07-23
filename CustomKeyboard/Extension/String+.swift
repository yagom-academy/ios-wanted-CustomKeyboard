//
//  String+.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/22.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "ko")
        if let date = formatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
