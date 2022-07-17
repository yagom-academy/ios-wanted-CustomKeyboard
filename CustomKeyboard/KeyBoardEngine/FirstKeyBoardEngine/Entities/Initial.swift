//
//  Initial.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/16.
//

import Foundation

enum Initial:Int {
    case ㄱ,ㄲ,ㄴ,ㄷ,ㄸ,ㄹ,ㅁ,ㅂ,ㅃ,ㅅ,ㅆ,ㅇ,ㅈ,ㅉ,ㅊ,ㅋ,ㅌ,ㅍ,ㅎ
    var code: Int {
        return self.rawValue
    }
    static func parsingFromSupport(from support: Int) -> Int {
        switch support {
        case 1: return 0
        case 2: return 1
        case 4: return 2
        case 7: return 3
        case 8: return 5
        case 16: return 6
        case 17: return 7
        case 19: return 9
        case 20: return 10
        case 21: return 11
        case 22: return 12
        case 23: return 14
        case 24: return 15
        case 25: return 16
        case 26: return 17
        case 27: return 18
        default: return 0
        }
    }
    static func parsingFromConsonant(from consonant: Int) -> Int {
        let parsedConsonant = consonant - 12592
        switch parsedConsonant {
        case 1: return 0
        case 2: return 1
        case 4: return 2
        case 7: return 3
        case 8: return 4
        case 9: return 5
        case 17: return 6
        case 18: return 7
        case 19: return 8
        case 21: return 9
        case 22: return 10
        case 23: return 11
        case 24: return 12
        case 25: return 13
        case 26: return 14
        case 27: return 15
        case 28: return 16
        case 29: return 17
        case 30: return 18
        default: return 0
        }
    }
    static func parsingToConsonant(from initial: Int) -> Int {
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

