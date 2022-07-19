//
//  KeyboardData.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/19.
//

import Foundation

struct HangulKeyboardData {
    
    var hangul: String = ""
    var unicode: Int = 0
    var bornState: KeyboardMaker.HangulState = .empty
    
    init(char: String, state: KeyboardMaker.HangulState) {
        self.hangul = char
        self.unicode = convertStr2Unicode(char: char)
        self.bornState = state
    }
    
    init(uni: Int, state: KeyboardMaker.HangulState) {
        self.unicode = uni
        self.hangul = convertUni2Str(uni: uni)
        self.bornState = state
    }
    
    init(char: String, uni: Int, lastState: KeyboardMaker.HangulState) {
        self.hangul = char
        self.unicode = uni
        self.bornState = lastState
    }
    
    private func convertUni2Str(uni: Int) -> String {
        if let unicodeScalar = UnicodeScalar(uni) {
            return String(unicodeScalar)
        }
        return ""
    }
    
    private func convertStr2Unicode(char: String) -> Int {
        if let unicodeScalar = UnicodeScalar(char) {
            return Int(unicodeScalar.value)
        }
        return 0
    }
    
}
