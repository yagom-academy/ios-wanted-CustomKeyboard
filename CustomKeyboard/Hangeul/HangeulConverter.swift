//
//  HangeulConverter.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

final class HangeulConverter {
    
    func toUnicode(from string: String) -> Int? {
        guard let unicodeScalar = UnicodeScalar(string) else {
            return nil
        }
        return Int(unicodeScalar.value)
    }
    
    func toString(from unicode: Int?) -> String? {
        guard let unicode = unicode,
              let unicodeScalar = UnicodeScalar(unicode) else {
            return nil
        }
        return String(unicodeScalar)
    }
}
