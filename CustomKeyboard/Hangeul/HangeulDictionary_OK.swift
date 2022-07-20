//
//  HangeulDictionary.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

// MARK: - Constant

struct HangeulDictionary {
    let jungseongTotalCount = 21
    let jongseongTotalCount = 28
    let baseCode = 44032
    
}

// MARK: - Compatible Unicode List

extension HangeulDictionary {
    
    struct compatible {
        
        enum choseong: Int, CaseIterable{
            
            case ㄱ = 0x3131
            case ㄲ = 0x3132
            case ㄴ = 0x3134
            case ㄷ = 0x3137
            case ㄸ = 0x3138
            case ㄹ = 0x3139
            case ㅁ = 0x3141
            case ㅂ = 0x3142
            case ㅃ = 0x3143
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
        }
        
        enum jungseong: Int, CaseIterable {
        
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
        }
        
        enum doubleJungseong: Int, CaseIterable {
            case ㅐ = 0x3150
            case ㅒ = 0x3152
            case ㅔ = 0x3154
            case ㅖ = 0x3156
            case ㅘ = 0x3158
            case ㅙ = 0x3159
            case ㅚ = 0x315A
            case ㅝ = 0x315D
            case ㅞ = 0x315E
            case ㅟ = 0x315F
            case ㅢ = 0x3162
        }
            
        enum jongseong: Int, CaseIterable {
            
            case blank = 0x3130
            case ㄱ = 0x3131
            case ㄲ = 0x3132
            case ㄱㅅ = 0x3133
            case ㄴ = 0x3134
            case ㄴㅈ = 0x3135
            case ㄴㅎ = 0x3136
            case ㄷ = 0x3137
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
            case ㅂㅅ = 0x3144
            case ㅅ = 0x3145
            case ㅆ = 0x3146
            case ㅇ = 0x3147
            case ㅈ = 0x3148
            case ㅊ = 0x314A
            case ㅋ = 0x314B
            case ㅌ = 0x314C
            case ㅍ = 0x314D
            case ㅎ = 0x314E
        }
    }
}

// MARK: - Fixed Unicode List

extension HangeulDictionary {
    
    struct fixed {
        
        enum choseong: Int, CaseIterable{
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
        }
        
        enum jungseong: Int, CaseIterable {
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
        }
        
        enum doubleMid: Int, CaseIterable {
            case ㅐ = 0x1162
            case ㅒ = 0x1164
            case ㅔ = 0x1166
            case ㅖ = 0x1168
            case ㅘ = 0x116A
            case ㅙ = 0x116B
            case ㅚ = 0x116C
            case ㅝ = 0x116F
            case ㅞ = 0x1170
            case ㅟ = 0x1171
            case ㅢ = 0x1174
        }
        
        
        enum jongseong: Int, CaseIterable {
            case blank = 0x11A7
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
        }
    }
}

// MARK: - Public Method

extension HangeulDictionary {
    
    func getIndex(of unicode: Int?, in position: HangeulCombinationPosition, type unicodeType: HangeulUnicodeType) -> Int? {
        guard let unicode = unicode else {
            return nil
        }
        
        if unicodeType == .fixed {
            return getIndexOfFixed(unicode, in: position)
        }
        
        return getIndexOfCompatible(unicode, in: position)
    }
    
    func getUnicode(at index: Int, in position: HangeulCombinationPosition, of unicodeType: HangeulUnicodeType) -> Int? {
        if unicodeType == .fixed {
            return getUnicodeOfFixed(index, in: position)
        }
        return getUnicodeOfCompatible(index, in: position)
    }

    func getDoubleUnicode(_ previousCharacter: Hangeul, _ currentCharacter: Hangeul) -> Int? {
        guard let previousCharacterPosition = previousCharacter.position.last else {
            return nil
        }
        
        if previousCharacterPosition == .jungseong {
            return getDoubleJungseongUnicode(previousCharacter.text, currentCharacter.text)
        } else if previousCharacter.position.last! == .jongseong {
            return getDoubleJongseongUnicode(previousCharacter.text, currentCharacter.text)
        }
        
        return nil
    }
    
    func getTripleMidUnicode(_ previousCharacter: Hangeul, _ currentCharacter: Hangeul, _ nextCharacter: Hangeul) -> Int? {
        if previousCharacter.text == "ㅜ" && currentCharacter.text == "ㅓ" && nextCharacter.text == "ㅣ" {
            return HangeulDictionary.fixed.jungseong.ㅞ.rawValue
        } else if previousCharacter.text == "ㅗ" && currentCharacter.text == "ㅏ" && nextCharacter.text == "ㅣ" {
            return HangeulDictionary.fixed.jungseong.ㅙ.rawValue
        }
        return nil
    }
}

// MARK: - Private Method

// MARK: - called in getIndex

extension HangeulDictionary {
    
    private func getIndexOfCompatible(_ compatibleUnicode: Int, in position: HangeulCombinationPosition) -> Int? {
        var index = 0
        
        switch position {
        case .choseong:
            for hangeul in HangeulDictionary.compatible.choseong.allCases {
                if hangeul.rawValue == compatibleUnicode {
                    return index
                }
                index += 1
            }
        case .jungseong:
            for hangeul in HangeulDictionary.compatible.jungseong.allCases {
                if hangeul.rawValue == compatibleUnicode {
                    return index
                }
                index += 1
            }
        case .jongseong:
            for hangeul in HangeulDictionary.compatible.jongseong.allCases {
                if hangeul.rawValue == compatibleUnicode {
                    return index
                }
                index += 1
            }
        }
        return nil
    }
    
    private func getIndexOfFixed(_ fixedUnicode: Int, in position: HangeulCombinationPosition) -> Int? {
        var index = 0
        
        switch position {
        case .choseong:
            for hangeul in HangeulDictionary.fixed.choseong.allCases {
                if hangeul.rawValue == fixedUnicode {
                    return index
                }
                index += 1
            }
        case .jungseong:
            for hangeul in HangeulDictionary.fixed.jungseong.allCases {
                if hangeul.rawValue == fixedUnicode {
                    return index
                }
                index += 1
            }
        case .jongseong:
            for hangeul in HangeulDictionary.fixed.jongseong.allCases {
                if hangeul.rawValue == fixedUnicode {
                    return index
                }
                index += 1
            }
        }
        return nil
    }
}


// MARK: - called in getUnicode

extension HangeulDictionary {
    
    private func getUnicodeOfCompatible(_ compatibleIndex: Int, in position: HangeulCombinationPosition) -> Int? {
        var count = 0
        
        switch position {
        case .choseong:
            for hangeul in HangeulDictionary.compatible.choseong.allCases {
                if count == compatibleIndex {
                    return hangeul.rawValue
                }
                count += 1
            }
        case .jungseong:
            for hangeul in HangeulDictionary.compatible.jungseong.allCases {
                if count == compatibleIndex {
                    return hangeul.rawValue
                }
                count += 1
            }
        case .jongseong:
            for hangeul in HangeulDictionary.compatible.jongseong.allCases {
                if count == compatibleIndex {
                    return hangeul.rawValue
                }
                count += 1
            }
        }
        return nil
    }
    
    private func getUnicodeOfFixed(_ fixedIndex: Int, in position: HangeulCombinationPosition) -> Int? {
        var count = 0
        
        switch position {
        case .choseong:
            for hangeul in HangeulDictionary.fixed.choseong.allCases {
                if count == fixedIndex {
                    return hangeul.rawValue
                }
                count += 1
            }
        case .jungseong:
            for hangeul in HangeulDictionary.fixed.jungseong.allCases {
                if count == fixedIndex {
                    return hangeul.rawValue
                }
                count += 1
            }
        case .jongseong:
            for hangeul in HangeulDictionary.fixed.jongseong.allCases {
                if count == fixedIndex {
                    return hangeul.rawValue
                }
                count += 1
            }
        }
        return nil
    }
}

// MARK: - called in getDoubleUnicode

extension HangeulDictionary {
    
    private func getDoubleJungseongUnicode(_ previousCharacterText: String, _ currentCharacterText: String) -> Int? {
        switch (previousCharacterText, currentCharacterText) {
        case ("ㅏ", "ㅣ"):
            return HangeulDictionary.fixed.jungseong.ㅐ.rawValue
        case ("ㅑ", "ㅣ"):
            return HangeulDictionary.fixed.jungseong.ㅒ.rawValue
        case ("ㅓ", "ㅣ"):
            return HangeulDictionary.fixed.jungseong.ㅔ.rawValue
        case ("ㅕ", "ㅣ"):
            return HangeulDictionary.fixed.jungseong.ㅖ.rawValue
        case ("ㅗ", "ㅏ"):
            return HangeulDictionary.fixed.jungseong.ㅘ.rawValue
        case ("ㅗ", "ㅐ"):
            return HangeulDictionary.fixed.jungseong.ㅙ.rawValue
        case ("ㅗ", "ㅣ"):
            return HangeulDictionary.fixed.jungseong.ㅚ.rawValue
        case ("ㅜ", "ㅓ"):
            return HangeulDictionary.fixed.jungseong.ㅝ.rawValue
        case ("ㅜ", "ㅔ"):
            return HangeulDictionary.fixed.jungseong.ㅞ.rawValue
        case ("ㅜ", "ㅣ"):
            return HangeulDictionary.fixed.jungseong.ㅟ.rawValue
        case ("ㅡ", "ㅣ"):
            return HangeulDictionary.fixed.jungseong.ㅢ.rawValue
        case ("ㅠ", "ㅣ"):
            return HangeulDictionary.fixed.jungseong.ㅝ.rawValue
        default:
            return nil
        }
    }
    
    private func getDoubleJongseongUnicode(_ previousCharacterText: String, _ currentCharacterText: String) -> Int? {
        switch (previousCharacterText, currentCharacterText) {
        case ("ㄱ", "ㅅ"):
            return HangeulDictionary.fixed.jongseong.ㄱㅅ.rawValue
        case ("ㄴ", "ㅈ"):
            return HangeulDictionary.fixed.jongseong.ㄴㅈ.rawValue
        case ("ㄴ", "ㅎ"):
            return HangeulDictionary.fixed.jongseong.ㄴㅎ.rawValue
        case ("ㄹ", "ㄱ"):
            return HangeulDictionary.fixed.jongseong.ㄹㄱ.rawValue
        case ("ㄹ", "ㅁ"):
            return HangeulDictionary.fixed.jongseong.ㄹㅁ.rawValue
        case ("ㄹ", "ㅂ"):
            return HangeulDictionary.fixed.jongseong.ㄹㅂ.rawValue
        case ("ㄹ", "ㅅ"):
            return HangeulDictionary.fixed.jongseong.ㄹㅅ.rawValue
        case ("ㄹ", "ㅌ"):
            return HangeulDictionary.fixed.jongseong.ㄹㅌ.rawValue
        case ("ㄹ", "ㅍ"):
            return HangeulDictionary.fixed.jongseong.ㄹㅍ.rawValue
        case ("ㄹ", "ㅎ"):
            return HangeulDictionary.fixed.jongseong.ㄹㅎ.rawValue
        default:
            return nil
        }
    }
}
