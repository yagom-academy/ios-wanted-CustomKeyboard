//
//  Neutral.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/16.
//

import Foundation

enum Neutral:Int {
    case ㅏ,ㅐ,ㅑ,ㅒ,ㅓ,ㅔ,ㅕ,ㅖ,ㅗ,ㅘ,ㅙ,ㅚ,ㅛ,ㅜ,ㅝ,ㅞ,ㅟ,ㅠ,ㅡ,ㅢ,ㅣ
    var code: Int {
        return self.rawValue
    }
    static func parsingFromVowel(from vowel: Int) -> Int {
        return vowel - 12623
    }
    static func parsingToVowel(from neutral: Int) -> Int {
        return neutral + 12623
    }
}
