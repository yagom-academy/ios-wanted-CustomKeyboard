//
//  Initial.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/20.
//

import Foundation

enum Initial: Int {
    case ㄱ,ㄲ,ㄴ,ㄷ,ㄸ,ㄹ,ㅁ,ㅂ,ㅃ,ㅅ,ㅆ,ㅇ,ㅈ,ㅉ,ㅊ,ㅋ,ㅌ,ㅍ,ㅎ
    
    var value: Int {
        return self.rawValue
    }
    
    static func getFinalValueToInitialValue(_ final: Int) -> Int {
        switch final {
        case 1:
            return 0
        case 2:
            return 1
        case 4:
            return 2
        case 7:
            return 3
        case 8:
            return 5
        case 16:
            return 6
        case 17:
            return 7
        case 19:
            return 9
        case 20:
            return 10
        case 21:
            return 11
        case 22:
            return 12
        case 23:
            return 14
        case 24:
            return 15
        case 25:
            return 16
        case 26:
            return 17
        case 27:
            return 18
        default:
            return 0
        }
    }
    
    static func getConsonantToInitialValue(_ consonant: Int) -> Int {
        let InitialValue = consonant - 12592
        switch InitialValue {
        case 1:
            return 0
        case 2:
            return 1
        case 4:
            return 2
        case 7:
            return 3
        case 8:
            return 4
        case 9:
            return 5
        case 17:
            return 6
        case 18:
            return 7
        case 19:
            return 8
        case 21:
            return 9
        case 22:
            return 10
        case 23:
            return 11
        case 24:
            return 12
        case 25:
            return 13
        case 26:
            return 14
        case 27:
            return 15
        case 28:
            return 16
        case 29:
            return 17
        case 30:
            return 18
        default:
            return 0
        
        }
    }
}
