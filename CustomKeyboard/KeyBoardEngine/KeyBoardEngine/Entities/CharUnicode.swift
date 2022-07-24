//
//  CharUnicode.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/17.
//

import Foundation

enum CharUnicode:Int {
    case ㄱ = 12593
    case ㄲ,ㄳ,ㄴ,ㄵ,ㄶ,ㄷ,ㄸ,ㄹ,ㄺ,ㄻ,ㄼ,ㄽ,ㄾ,ㄿ,ㅀ,ㅁ,ㅂ,ㅃ,ㅄ,ㅅ,ㅆ,ㅇ,ㅈ,ㅉ,ㅊ,ㅋ,ㅌ,ㅍ,ㅎ,ㅏ,ㅐ,ㅑ,ㅒ,ㅓ,ㅔ,ㅕ,ㅖ,ㅗ,ㅘ,ㅙ,ㅚ,ㅛ,ㅜ,ㅝ,ㅞ,ㅟ,ㅠ,ㅡ,ㅢ,ㅣ
    
    var code: Int {
        return self.rawValue
    }
    
    static func parsingFromNeutral(from neutral: Int) -> Int {
        
        return neutral + 12623
    }
    
    static func parsingFromInitial(from initial: Int) -> Int {
        
        var consonant:Int
        
        switch initial {
        case 0: consonant = 1
        case 1: consonant = 2
        case 2: consonant = 4
        case 3: consonant = 7
        case 4: consonant = 8
        case 5: consonant = 9
        case 6: consonant = 17
        case 7: consonant = 18
        case 8: consonant = 19
        case 9: consonant = 21
        case 10: consonant = 22
        case 11: consonant = 23
        case 12: consonant = 24
        case 13: consonant = 25
        case 14: consonant = 26
        case 15: consonant = 27
        case 16: consonant = 28
        case 17: consonant = 29
        case 18: consonant = 30
        default: consonant = 0
        }
        return consonant + 12592
    }
}
