//
//  AutomataKits.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/19.
//

import Foundation

class AutomataKits {
    func convertStr2Unicode(char: String) -> Int {
        if let unicodeScalar = UnicodeScalar(char) {
            return Int(unicodeScalar.value)
        }
        return 0
    }
    
    func convertUni2Str(uni: Int) -> String {
        if let unicodeScalar = UnicodeScalar(uni) {
            return String(unicodeScalar)
        }
        return ""
    }
}
