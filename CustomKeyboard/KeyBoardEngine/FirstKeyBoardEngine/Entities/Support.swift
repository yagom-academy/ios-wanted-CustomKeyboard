//
//  Support.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/16.
//

import Foundation

enum Support:Int {
    case no,ㄱ,ㄲ,ㄳ,ㄴ,ㄵ,ㄶ,ㄷ,ㄹ,ㄺ,ㄻ,ㄼ,ㄽ,ㄾ,ㄿ,ㅀ,ㅁ,ㅂ,ㅄ,ㅅ,ㅆ,ㅇ,ㅈ,ㅊ,ㅋ,ㅌ,ㅍ,ㅎ
    var code: Int {
        return self.rawValue
    }
    static func parsingtoInitialCode(by support: Int) -> Int {
        switch support {
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
}
