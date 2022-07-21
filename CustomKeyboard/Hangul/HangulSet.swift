//
//  HangulSet.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/13.
//

import Foundation

class HangulSet {
    
    static let chos = [
        "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    static let doubleChos = [
        "ㄲ", "ㄸ", "ㅃ", "ㅆ", "ㅉ"
    ]
    static let checkingDoubleChos = [
        ("ㄱ", "ㄱ"), ("ㄷ", "ㄷ"), ("ㅂ", "ㅂ"), ("ㅅ", "ㅅ"), ("ㅈ", "ㅈ")
    ]
    static let jungs = [
        "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"
    ]
    static let doubleJungs = [
        "ㅐ", "ㅒ", "ㅔ", "ㅖ", "ㅘ", "ㅙ", "ㅚ", "ㅝ", "ㅞ", "ㅟ", "ㅢ"
    ]
    static let checkingDoubleJungs = [
        ("ㅏ", "ㅣ"), ("ㅑ", "ㅣ"), ("ㅓ", "ㅣ"), ("ㅕ", "ㅣ"), ("ㅗ", "ㅏ"), ("ㅗ", "ㅐ"), ("ㅗ", "ㅣ"), ("ㅜ", "ㅓ"), ("ㅜ", "ㅔ"), ("ㅜ", "ㅣ"), ("ㅡ", "ㅣ")
    ]
    static let tripleJungs = [
        "ㅙ", "ㅞ"
    ]
    static let checkingTripleJungs = [
        ("ㅘ","ㅣ"), ("ㅝ", "ㅣ")
    ]
    static let jongs = [
        " ", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    static let singleJongs = [
        "ㄷ", "ㅁ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    static let doubleJongs = [
        "ㄲ", "ㄳ", "ㄵ", "ㄶ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅄ", "ㅆ"
    ]
    static let checkingJongs = [
        ("ㄱ", "ㄱ"), ("ㄱ", "ㅅ"), ("ㄴ", "ㅈ"), ("ㄴ", "ㅎ"), ("ㄹ", "ㄱ"), ("ㄹ", "ㅁ"), ("ㄹ", "ㅂ"), ("ㄹ", "ㅅ"), ("ㄹ" , "ㅌ"), ("ㄹ", "ㅍ"), ("ㄹ", "ㅎ"), ("ㅂ", "ㅅ"), ("ㅅ", "ㅅ")
    ]
}

class SpecialCharSet {
    
    static let delete = 9003
    static let enter = 9166
}

