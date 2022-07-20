//
//  KeyboardData.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/19.
//

import Foundation

struct HangulKeyboardData {
    
    enum HangulState: Int {
        case empty = 0
        case cho = 1
        case doubleCho = 2
        case jung = 3
        case doubleJung = 4
        case jong = 5
        case doubleJong = 6
    }
    
    var hangul: String = ""
    var unicode: Int = 0
    var bornState: HangulState = .empty
    
    init(char: String, state: HangulState) {
        self.hangul = char
        self.unicode = convertStr2Unicode(char: char)
        self.bornState = state
    }
    
    init(uni: Int, state: HangulState) {
        self.unicode = uni
        self.hangul = convertUni2Str(uni: uni)
        self.bornState = state
    }
    
    init(char: String, uni: Int, state: HangulState) {
        self.hangul = char
        self.unicode = uni
        self.bornState = state
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
