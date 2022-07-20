//
//  KoreanCharacter.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/17.
//

import Foundation

struct KoreanCharacter {
    
    enum koreanConsonant : String {
        case ㄱ ,ㄴ ,ㄷ, ㄹ, ㅁ, ㅂ, ㅅ, ㅇ,ㅈ, ㅊ, ㅌ, ㅋ, ㅎ, ㄲ, ㄸ, ㅃ, ㅆ, ㅉ
        
        var doubleConsonant : String {
            switch self {
            case .ㄱ :
                return "ㄲ"
            case .ㄷ :
                return "ㄸ"
            case .ㅂ :
                return "ㅃ"
            case .ㅅ :
                return "ㅆ"
            case .ㅈ :
                return "ㅉ"
            default :
                return self.rawValue
            }
        }
        
        var reverceDoubleConsonant : String {
            switch self {
            case .ㄲ :
                return "ㄱ"
            case .ㄸ :
                return "ㄷ"
            case .ㅃ :
                return "ㅂ"
            case .ㅆ :
                return "ㅅ"
            case .ㅉ :
                return "ㅈ"
            default :
                return self.rawValue
            }
        }
    }
    
    enum koreanVowel : String {
        case ㅏ, ㅑ, ㅓ, ㅕ, ㅗ, ㅛ, ㅜ, ㅠ, ㅡ ,ㅣ, ㅐ, ㅔ, ㅒ, ㅖ
        
        var diphthong : String{
            switch self {
            case .ㅐ :
                return "ㅒ"
            case .ㅔ :
                return "ㅖ"
            default :
                return self.rawValue
            }
        }
        
        var reverceDiphthong : String{
            switch self {
            case .ㅒ:
                return "ㅐ"
            case .ㅖ :
                return "ㅔ"
            default :
                return self.rawValue
            }
        }
    }
    
    let consonant : koreanConsonant?
    let vowel : koreanVowel?
}
