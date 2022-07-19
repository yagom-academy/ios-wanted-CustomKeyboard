//
//  String+.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/12.
//

import Foundation

extension String {
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "y-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter.date(from: self)
    }
    
    mutating func appendUnicode(_ code: UInt32?) {
        guard let code = code,
              let unicode = UnicodeScalar(code) else { return }
        self.append(String(unicode))
    }
}
