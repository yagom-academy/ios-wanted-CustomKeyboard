//
//  KeyboardButtonType.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/13.
//

import Foundation

enum Compatibility: UInt32, CaseIterable {
    case ㄱ = 0x3131
    case ㄲ = 0x3132
    case ㄱㅅ = 0x3133
    case ㄴ = 0x3134
    case ㄴㅈ = 0x3135
    case ㄴㅎ = 0x3136
    case ㄷ = 0x3137
    case ㄸ = 0x3138
    case ㄹ = 0x3139
    case ㄹㄱ = 0x313A
    case ㄹㅁ = 0x313B
    case ㄹㅂ = 0x313C
    case ㄹㅅ = 0x313D
    case ㄹㅌ = 0x313E
    case ㄹㅍ = 0x313F
    case ㄹㅎ = 0x3140
    case ㅁ = 0x3141
    case ㅂ = 0x3142
    case ㅃ = 0x3143
    case ㅂㅅ = 0x3144
    case ㅅ = 0x3145
    case ㅆ = 0x3146
    case ㅇ = 0x3147
    case ㅈ = 0x3148
    case ㅉ = 0x3149
    case ㅊ = 0x314A
    case ㅋ = 0x314B
    case ㅌ = 0x314C
    case ㅍ = 0x314D
    case ㅎ = 0x314E
    case ㅏ = 0x314F
    case ㅐ = 0x3150
    case ㅑ = 0x3151
    case ㅒ = 0x3152
    case ㅓ = 0x3153
    case ㅔ = 0x3154
    case ㅕ = 0x3155
    case ㅖ = 0x3156
    case ㅗ = 0x3157
    case ㅘ = 0x3158
    case ㅙ = 0x3159
    case ㅚ = 0x315A
    case ㅛ = 0x315B
    case ㅜ = 0x315C
    case ㅝ = 0x315D
    case ㅞ = 0x315E
    case ㅟ = 0x315F
    case ㅠ = 0x3160
    case ㅡ = 0x3161
    case ㅢ = 0x3162
    case ㅣ = 0x3163
    
    var text: String? {
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
        default: return nil
        }
    }
    
    var chosung: Chosung? {
        switch self {
        case .ㄱ: return .ㄱ
        case .ㄲ: return .ㄲ
        case .ㄴ: return .ㄴ
        case .ㄷ: return .ㄷ
        case .ㄸ: return .ㄸ
        case .ㄹ: return .ㄹ
        case .ㅁ: return .ㅁ
        case .ㅂ: return .ㅂ
        case .ㅃ: return .ㅃ
        case .ㅅ: return .ㅅ
        case .ㅆ: return .ㅆ
        case .ㅇ: return .ㅇ
        case .ㅈ: return .ㅈ
        case .ㅉ: return .ㅉ
        case .ㅊ: return .ㅊ
        case .ㅋ: return .ㅋ
        case .ㅌ: return .ㅌ
        case .ㅍ: return .ㅍ
        case .ㅎ: return .ㅎ
        default: return nil
        }
    }
    
    var jungsung: Jungsung? {
        switch self {
        case .ㅏ: return .ㅏ
        case .ㅐ: return .ㅐ
        case .ㅑ: return .ㅑ
        case .ㅒ: return .ㅒ
        case .ㅓ: return .ㅓ
        case .ㅔ: return .ㅔ
        case .ㅕ: return .ㅕ
        case .ㅖ: return .ㅖ
        case .ㅗ: return .ㅗ
        case .ㅘ: return .ㅘ
        case .ㅙ: return .ㅙ
        case .ㅚ: return .ㅚ
        case .ㅛ: return .ㅛ
        case .ㅜ: return .ㅜ
        case .ㅝ: return .ㅝ
        case .ㅞ: return .ㅞ
        case .ㅟ: return .ㅟ
        case .ㅠ: return .ㅠ
        case .ㅡ: return .ㅡ
        case .ㅢ: return .ㅢ
        case .ㅣ: return .ㅣ
        default: return nil
        }
    }
    
    var jongsung: Jongsung? {
        switch self {
        case .ㄱ: return .ㄱ
        case .ㄲ: return .ㄲ
        case .ㄱㅅ: return .ㄱㅅ
        case .ㄴ: return .ㄴ
        case .ㄴㅈ: return .ㄴㅈ
        case .ㄴㅎ: return .ㄴㅎ
        case .ㄷ: return .ㄷ
        case .ㄹ: return .ㄹ
        case .ㄹㄱ: return .ㄹㄱ
        case .ㄹㅁ: return .ㄹㅁ
        case .ㄹㅂ: return .ㄹㅂ
        case .ㄹㅅ: return .ㄹㅅ
        case .ㄹㅌ: return .ㄹㅌ
        case .ㄹㅍ: return .ㄹㅍ
        case .ㄹㅎ: return .ㄹㅎ
        case .ㅁ: return .ㅁ
        case .ㅂ: return .ㅂ
        case .ㅂㅅ: return .ㅂㅅ
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

enum Chosung: UInt32 {
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
    
    var compatibility: Compatibility {
        switch self {
        case .ㄱ: return .ㄱ
        case .ㄲ: return .ㄲ
        case .ㄴ: return .ㄴ
        case .ㄷ: return .ㄷ
        case .ㄸ: return .ㄸ
        case .ㄹ: return .ㄹ
        case .ㅁ: return .ㅁ
        case .ㅂ: return .ㅂ
        case .ㅃ: return .ㅃ
        case .ㅅ: return .ㅅ
        case .ㅆ: return .ㅆ
        case .ㅇ: return .ㅇ
        case .ㅈ: return .ㅈ
        case .ㅉ: return .ㅉ
        case .ㅊ: return .ㅊ
        case .ㅋ: return .ㅋ
        case .ㅌ: return .ㅌ
        case .ㅍ: return .ㅍ
        case .ㅎ: return .ㅎ
        }
    }
}

enum Jungsung: UInt32 {
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
    
    var compatibility: Compatibility {
        switch self {
        case .ㅏ: return .ㅏ
        case .ㅐ: return .ㅐ
        case .ㅑ: return .ㅑ
        case .ㅒ: return .ㅒ
        case .ㅓ: return .ㅓ
        case .ㅔ: return .ㅔ
        case .ㅕ: return .ㅕ
        case .ㅖ: return .ㅖ
        case .ㅗ: return .ㅗ
        case .ㅘ: return .ㅘ
        case .ㅙ: return .ㅙ
        case .ㅚ: return .ㅚ
        case .ㅛ: return .ㅛ
        case .ㅜ: return .ㅜ
        case .ㅝ: return .ㅝ
        case .ㅞ: return .ㅞ
        case .ㅟ: return .ㅟ
        case .ㅠ: return .ㅠ
        case .ㅡ: return .ㅡ
        case .ㅢ: return .ㅢ
        case .ㅣ: return .ㅣ
        }
    }
}

enum Jongsung: UInt32 {
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

