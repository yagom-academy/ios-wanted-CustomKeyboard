//
//  CharUnicode.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/20.
//

import Foundation

enum CharUnicode : Int {
    case ㄱ = 12593
    case ㄲ,ㄳ,ㄴ,ㄵ,ㄶ,ㄷ,ㄸ,ㄹ,ㄺ,ㄻ,ㄼ,ㄽ,ㄾ,ㄿ,ㅀ,ㅁ,ㅂ,ㅃ,ㅄ,ㅅ,ㅆ,ㅇ,ㅈ,ㅉ,ㅊ,ㅋ,ㅌ,ㅍ,ㅎ,ㅏ,ㅐ,ㅑ,ㅒ,ㅓ,ㅔ,ㅕ,ㅖ,ㅗ,ㅘ,ㅙ,ㅚ,ㅛ,ㅜ,ㅝ,ㅞ,ㅟ,ㅠ,ㅡ,ㅢ,ㅣ
    
    var value: Int {
        return self.rawValue
    }
}
