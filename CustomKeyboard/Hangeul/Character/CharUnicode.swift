//
//  CharUnicode.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/20.
//

import Foundation

enum CharUnicode: Int {
    case ㄱ = 12593
    case ㄲ,ㄳ,ㄴ,ㄵ,ㄶ,ㄷ,ㄸ,ㄹ,ㄺ,ㄻ,ㄼ,ㄽ,ㄾ,ㄿ,ㅀ,ㅁ,ㅂ,ㅃ,ㅄ,ㅅ,ㅆ,ㅇ,ㅈ,ㅉ,ㅊ,ㅋ,ㅌ,ㅍ,ㅎ,ㅏ,ㅐ,ㅑ,ㅒ,ㅓ,ㅔ,ㅕ,ㅖ,ㅗ,ㅘ,ㅙ,ㅚ,ㅛ,ㅜ,ㅝ,ㅞ,ㅟ,ㅠ,ㅡ,ㅢ,ㅣ
    
    var value: Int {
        return self.rawValue
    }
    
    static func getInitialValueToUnicode(_ InitialValue: Int) -> Int {
        switch InitialValue {
        case 0 :
            return CharUnicode.ㄱ.value
        case 1 :
            return CharUnicode.ㄲ.value
        case 2 :
            return CharUnicode.ㄴ.value
        case 3 :
            return CharUnicode.ㄷ.value
        case 4 :
            return CharUnicode.ㄸ.value
        case 5 :
            return CharUnicode.ㄹ.value
        case 6 :
            return CharUnicode.ㅁ.value
        case 7 :
            return CharUnicode.ㅂ.value
        case 8 :
            return CharUnicode.ㅃ.value
        case 9 :
            return CharUnicode.ㅅ.value
        case 10 :
            return CharUnicode.ㅆ.value
        case 11 :
            return CharUnicode.ㅇ.value
        case 12 :
            return CharUnicode.ㅈ.value
        case 13 :
            return CharUnicode.ㅉ.value
        case 14 :
            return CharUnicode.ㅊ.value
        case 15 :
            return CharUnicode.ㅋ.value
        case 16 :
            return CharUnicode.ㅌ.value
        case 17 :
            return CharUnicode.ㅍ.value
        case 18 :
            return CharUnicode.ㅎ.value
        default :
            return 0
        }
    }
}
