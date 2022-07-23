//
//  Final.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/20.
//

import Foundation

enum Final: Int {
    case none,ㄱ,ㄲ,ㄳ,ㄴ,ㄵ,ㄶ,ㄷ,ㄹ,ㄺ,ㄻ,ㄼ,ㄽ,ㄾ,ㄿ,ㅀ,ㅁ,ㅂ,ㅄ,ㅅ,ㅆ,ㅇ,ㅈ,ㅊ,ㅋ,ㅌ,ㅍ,ㅎ
    
    var value: Int {
        return self.rawValue
    }
    
    static func getConsonantToFianlValue(_ consonant: Int) -> Int {
        let InitialValue = consonant - 12592
        
        switch InitialValue {
        case 1:
            return 1
        case 2:
            return 2
        case 4:
            return 4
        case 7:
            return 7
        case 9:
            return 8
        case 17:
            return 16
        case 18:
            return 17
        case 21:
            return 19
        case 22:
            return 20
        case 23:
            return 21
        case 24:
            return 22
        case 26:
            return 23
        case 27:
            return 24
        case 28:
            return 25
        case 29:
            return 26
        case 30:
            return 27
        default:
            return 0
        }
    }
}
