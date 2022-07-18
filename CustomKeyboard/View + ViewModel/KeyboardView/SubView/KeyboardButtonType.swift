//
//  KeyboardButtonType.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/13.
//

import Foundation

enum KeyboardButtonType {
    case text
    case back
    case shift
    case space
}

enum Chosung: Int {
    case ㄱ = 0x1100
    case ㄲ = 0x1101
    case ㄴ = 0x1102
    case ㄷ = 0x1103
    case ㄸ = 0x1104
    case ㄹ = 0x1105
    case ㅁ = 0x1106
    case ㅂ = 0x1107
    case ㅃ = 0x1108
    case ㅅ = 0x1109
    case ㅆ = 0x110A
    case ㅇ = 0x110B
    case ㅈ = 0x110C
    case ㅉ = 0x110D
    case ㅊ = 0x110E
    case ㅋ = 0x110F
    case ㅌ = 0x1110
    case ㅍ = 0x1111
    case ㅎ = 0x1112
    
    var description: String {
        switch self {
        case .ㄱ: return "ㄱ"
        case .ㄲ: return "ㄲ"
        case .ㄴ: return "ㄴ"
        case .ㄷ: return "ㄷ"
        case .ㄸ: return "ㄸ"
        case .ㄹ: return "ㄹ"
        case .ㅁ: return "ㅁ"
        case .ㅂ: return "ㅂ"
        case .ㅃ: return "ㅃ"
        case .ㅅ: return "ㅅ"
        case .ㅆ: return "ㅆ"
        case .ㅇ: return "ㅇ"
        case .ㅈ: return "ㅈ"
        case .ㅉ: return "ㅉ"
        case .ㅊ: return "ㅊ"
        case .ㅋ: return "ㅋ"
        case .ㅌ: return "ㅌ"
        case .ㅍ: return "ㅍ"
        case .ㅎ: return "ㅎ"
        }
    }
    
    var jongsung: Jongsung? {
        switch self {
        case .ㄱ: return.ㄱ
        case .ㄲ: return.ㄲ
        case .ㄴ: return.ㄴ
        case .ㄷ: return.ㄷ
        case .ㄹ: return.ㄹ
        case .ㅁ: return.ㅁ
        case .ㅂ: return.ㅂ
        case .ㅅ: return.ㅅ
        case .ㅆ: return.ㅆ
        case .ㅇ: return.ㅇ
        case .ㅈ: return.ㅈ
        case .ㅊ: return.ㅊ
        case .ㅋ: return.ㅋ
        case .ㅌ: return.ㅌ
        case .ㅍ: return.ㅍ
        case .ㅎ: return.ㅎ
        default: return nil
        }
    }
}

enum Jungsung: Int {
    case ㅏ = 0x1161
    case ㅐ = 0x1162
    case ㅑ = 0x1163
    case ㅒ = 0x1164
    case ㅓ = 0x1165
    case ㅔ = 0x1166
    case ㅕ = 0x1167
    case ㅖ = 0x1168
    case ㅗ = 0x1169
    case ㅘ = 0x116A
    case ㅙ = 0x116B
    case ㅚ = 0x116C
    case ㅛ = 0x116D
    case ㅜ = 0x116E
    case ㅝ = 0x116F
    case ㅞ = 0x1170
    case ㅟ = 0x1171
    case ㅠ = 0x1172
    case ㅡ = 0x1173
    case ㅢ = 0x1174
    case ㅣ = 0x1175
    
    var description: String {
        switch self {
        case .ㅏ: return "ㅏ"
        case .ㅐ: return "ㅐ"
        case .ㅑ: return "ㅑ"
        case .ㅒ: return "ㅒ"
        case .ㅓ: return "ㅓ"
        case .ㅔ: return "ㅔ"
        case .ㅕ: return "ㅕ"
        case .ㅖ: return "ㅖ"
        case .ㅗ: return "ㅗ"
        case .ㅘ: return "ㅘ"
        case .ㅙ: return "ㅙ"
        case .ㅚ: return "ㅚ"
        case .ㅛ: return "ㅛ"
        case .ㅜ: return "ㅜ"
        case .ㅝ: return "ㅝ"
        case .ㅞ: return "ㅞ"
        case .ㅟ: return "ㅟ"
        case .ㅠ: return "ㅠ"
        case .ㅡ: return "ㅡ"
        case .ㅢ: return "ㅢ"
        case .ㅣ: return "ㅣ"
        }
    }
}

enum Jongsung: Int {
    case empty
    case ㄱ = 0x11A8
    case ㄲ = 0x11A9
    case ㄱㅅ = 0x11AA
    case ㄴ = 0x11AB
    case ㄴㅈ = 0x11AC
    case ㄴㅎ = 0x11AD
    case ㄷ = 0x11AE
    case ㄹ = 0x11AF
    case ㄹㄱ = 0x11B0
    case ㄹㅁ = 0x11B1
    case ㄹㅂ = 0x11B2
    case ㄹㅅ = 0x11B3
    case ㄹㅌ = 0x11B4
    case ㄹㅍ = 0x11B5
    case ㄹㅎ = 0x11B6
    case ㅁ = 0x11B7
    case ㅂ = 0x11B8
    case ㅂㅅ = 0x11B9
    case ㅅ = 0x11BA
    case ㅆ = 0x11BB
    case ㅇ = 0x11BC
    case ㅈ = 0x11BD
    case ㅊ = 0x11BE
    case ㅋ = 0x11BF
    case ㅌ = 0x11C0
    case ㅍ = 0x11C1
    case ㅎ = 0x11C2
    
    var chosung: Chosung? {
        switch self {
        case .ㄱ: return .ㄱ
        case .ㄲ: return .ㄲ
        case .ㄴ: return .ㄴ
        case .ㄷ: return .ㄷ
        case .ㄹ: return .ㄹ
        case .ㅁ: return .ㅁ
        case .ㅂ: return .ㅂ
        case .ㅅ: return .ㅅ
        case .ㅆ: return .ㅆ
        case .ㅇ: return .ㅇ
        case .ㅈ: return .ㅈ
        case .ㅊ: return .ㅊ
        case .ㅋ: return .ㅋ
        case .ㅌ: return .ㅌ
        case .ㅍ: return .ㅍ
        case .ㅎ: return .ㅎ
        default: return nil
        }
    }
}

