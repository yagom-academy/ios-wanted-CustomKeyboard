//
//  HangeulDictionary.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

struct HangeulDictionary {
    
    let midCount = 21
    let endCount = 28
    let baseCode = 44032
    
    func getIndex(of character: Hangeul) -> Int {
        var index = 0
        
        guard character.value != "none" else {
            return 0
        }
        
        if character.unicodeType == .fixed {
            switch character.position.last! {
            case .top:
                for hangeul in HangeulDictionary.fixed.top.allCases {
                    if hangeul.rawValue == character.unicode {
                        break
                    }
                    index += 1
                }
            case .mid1, .mid2:
                for hangeul in HangeulDictionary.fixed.mid.allCases {
                    if hangeul.rawValue == character.unicode {
                        break
                    }
                    index += 1
                }
            case .end1, .end2:
                for hangeul in HangeulDictionary.fixed.end.allCases {
                    if hangeul.rawValue == character.unicode {
                        break
                    }
                    index += 1
                }
            default:
                break
            }
        } else {
            switch character.position.last! {
            case .top:
                for hangeul in HangeulDictionary.compatible.top.allCases {
                    if hangeul.rawValue == character.unicode {
                        break
                    }
                    index += 1
                }
            case .mid1, .mid2:
                for hangeul in HangeulDictionary.compatible.mid.allCases {
                    if hangeul.rawValue == character.unicode {
                        break
                    }
                    index += 1
                }
            case .end1, .end2:
                for hangeul in HangeulDictionary.compatible.end.allCases {
                    if hangeul.rawValue == character.unicode {
                        break
                    }
                    index += 1
                }
            default:
                break
            }
        }
        return index
    }
    
    func getUnicode(index: Int, in position: HangeulCombinationPosition, unicodeType: HangeulUnicodeType) -> Int {
        var i = 0
        var unicode = 0
        
        if unicodeType == .fixed {
            switch position {
            case .top:
                for hangeul in HangeulDictionary.fixed.top.allCases {
                    if i == index {
                        unicode = hangeul.rawValue
                        break
                    }
                    i += 1
                }
            case .mid1, .mid2:
                for hangeul in HangeulDictionary.fixed.mid.allCases {
                    if i == index {
                        unicode = hangeul.rawValue
                        break
                    }
                    i += 1
                }
            case .end1, .end2:
                for hangeul in HangeulDictionary.fixed.end.allCases {
                    if i == index {
                        unicode = hangeul.rawValue
                        break
                    }
                    i += 1
                }
            default:
                break
            }
        } else {
            switch position {
            case .top:
                for hangeul in HangeulDictionary.compatible.top.allCases {
                    if i == index {
                        unicode = hangeul.rawValue
                        break
                    }
                    i += 1
                }
            case .mid1, .mid2:
                for hangeul in HangeulDictionary.compatible.mid.allCases {
                    if i == index {
                        unicode = hangeul.rawValue
                        break
                    }
                    i += 1
                }
            case .end1, .end2:
                for hangeul in HangeulDictionary.compatible.end.allCases {
                    if i == index {
                        unicode = hangeul.rawValue
                        break
                    }
                    i += 1
                }
            default:
                break
            }
        }
        return unicode
    }
    
    func getDoubleUnicode(_ prev: Hangeul, _ curr: Hangeul) -> Int {
        if prev.position.last! == .mid1 {
            if prev.value == "ㅏ" && curr.value == "ㅣ" {
                return HangeulDictionary.fixed.mid.ㅐ.rawValue
            } else if prev.value == "ㅑ" && curr.value == "ㅣ" {
                return HangeulDictionary.fixed.mid.ㅒ.rawValue
            } else if prev.value == "ㅓ" && curr.value == "ㅣ" {
                return HangeulDictionary.fixed.mid.ㅔ.rawValue
            } else if prev.value == "ㅕ" && curr.value == "ㅣ" {
                return HangeulDictionary.fixed.mid.ㅖ.rawValue
            } else if prev.value == "ㅗ" && curr.value == "ㅏ" {
                return HangeulDictionary.fixed.mid.ㅘ.rawValue
            } else if prev.value == "ㅗ" && curr.value == "ㅐ" {
                return HangeulDictionary.fixed.mid.ㅙ.rawValue
            } else if prev.value == "ㅗ" && curr.value == "ㅣ" {
                return HangeulDictionary.fixed.mid.ㅚ.rawValue
            } else if prev.value == "ㅜ" && curr.value == "ㅓ" {
                return HangeulDictionary.fixed.mid.ㅝ.rawValue
            } else if prev.value == "ㅜ" && curr.value == "ㅔ" {
                return HangeulDictionary.fixed.mid.ㅞ.rawValue
            } else if prev.value == "ㅜ" && curr.value == "ㅣ" {
                return HangeulDictionary.fixed.mid.ㅟ.rawValue
            } else if prev.value == "ㅡ" && curr.value == "ㅣ" {
                return HangeulDictionary.fixed.mid.ㅢ.rawValue
            } else if prev.value == "ㅠ" && curr.value == "ㅣ" {
                return HangeulDictionary.fixed.mid.ㅝ.rawValue
            }
        } else if prev.position.last! == .end1 {
            if prev.value == "ㄱ" && curr.value == "ㅅ" {
                return HangeulDictionary.fixed.end.ㄱㅅ.rawValue
            } else if prev.value == "ㄴ" && curr.value == "ㅈ" {
                return HangeulDictionary.fixed.end.ㄴㅈ.rawValue
            } else if prev.value == "ㄴ" && curr.value == "ㅎ" {
                return HangeulDictionary.fixed.end.ㄴㅎ.rawValue
            } else if prev.value == "ㄹ" && curr.value == "ㄱ" {
                return HangeulDictionary.fixed.end.ㄹㄱ.rawValue
            } else if prev.value == "ㄹ" && curr.value == "ㅁ" {
                return HangeulDictionary.fixed.end.ㄹㅁ.rawValue
            } else if prev.value == "ㄹ" && curr.value == "ㅂ" {
                return HangeulDictionary.fixed.end.ㄹㅂ.rawValue
            } else if prev.value == "ㄹ" && curr.value == "ㅅ" {
                return HangeulDictionary.fixed.end.ㄹㅅ.rawValue
            } else if prev.value == "ㄹ" && curr.value == "ㅌ" {
                return HangeulDictionary.fixed.end.ㄹㅌ.rawValue
            } else if prev.value == "ㄹ" && curr.value == "ㅍ" {
                return HangeulDictionary.fixed.end.ㄹㅍ.rawValue
            } else if prev.value == "ㄹ" && curr.value == "ㅎ" {
                return HangeulDictionary.fixed.end.ㄹㅎ.rawValue
            }
        }
        return -1
    }
    
    struct compatible {
        
        enum top: Int, CaseIterable{
            
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
        
        enum mid: Int, CaseIterable {
        
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
        
        enum doubleMid: Int, CaseIterable {
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
            
        enum end: Int, CaseIterable {
            
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

    
    
    struct fixed {
        
        enum top: Int, CaseIterable{
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
        
        enum mid: Int, CaseIterable {
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
        
        
            
        enum end: Int, CaseIterable {
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
        
//
//            static let double: [Int: [Int: Int]] = [a: [i: ae], eo: [i: e], yeo: [i: ye] , ya: [i: yae],o: [a: wa, ae: wae, i: oe], u: [eo: wo, e: we, i: wi], eu: [i: eui]]
//            static let split: [Int: [Int]] = [wa: [o, a], wae: [o, ae], oe: [o, i], wo: [u, eo], we: [u, e], wi: [u, i], eui: [eu, i], ae: [a, i], e: [eo, i], ye: [yeo, i], yae: [ya, i]]

            /*
                                 double                split
             - ㅏ + ㅣ → ㅐ     a -> i -> ae         ae: [a, i]
             - ㅓ + ㅣ → ㅔ     eo -> i -> e         e: [eo, i]
             - ㅕ + ㅣ → ㅖ     yeo -> i -> ye       ye: [yeo, i]
             - ㅑ + ㅣ → ㅒ     ya -> i -> yae       yae: [ya, i]
             
             - `ㅠ + ㅣ → ㅝ`
             
             */
            
        

       
//
//            static let list: [Int] = [blank, kiyeok, sssangKiyeok, kiyeokSios, nieun, nieunJieuj, nieunHieuh, digeud, rieul, rieulKiyeok, rieulMieum, rieulBieub, rieulSios, rieulTieut, rieulPieup, rieulHieuh, mieum, bieub, bieubSios, sios, ssangSios, ieung, jieuj, chieuch, kieuk, tieut, pieup, hieuh]
//            static let double: [Int: [Int: Int]] = [kiyeok: [sios: kiyeokSios], nieun: [jieuj: nieunJieuj, hieuh: nieunHieuh], rieul: [kiyeok: rieulKiyeok, mieum: rieulMieum, bieub: rieulBieub, sios: rieulSios, tieut: rieulTieut, pieup: rieulPieup, hieuh: rieulHieuh]]
//            static let split: [Int: [Int]] = [kiyeokSios: [kiyeok, sios], nieunJieuj: [nieun, jieuj], nieunHieuh: [nieun, hieuh], rieulKiyeok: [rieul, kiyeok], rieulMieum: [rieul, mieum], rieulBieub: [rieul, bieub], rieulSios: [rieul, sios], rieulTieut: [rieul, tieut], rieulPieup: [rieul, pieup], rieulHieuh: [rieul, hieuh]]
//
//        }
//    }
//
//
//}
