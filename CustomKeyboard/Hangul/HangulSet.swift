//
//  HangulSet.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/13.
//

import Foundation

class HangulSet {
    
    //    static let chos = [0x3131, 0x3132, 0x3134, 0x3137, 0x3138, 0x3139, 0x3141, 0x3142, 0x3143, 0x3145, 0x3146, 0x3147, 0x3148, 0x3149, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e]
    //    static let doubleChos = [0x3132, 0x3138, 0x3143, 0x3146, 0x3149]
    //    static let jungs = [0x314f, 0x3150, 0x3151, 0x3152, 0x3153, 0x3154, 0x3155, 0x3156, 0x3157, 0x3158, 0x3159, 0x315a, 0x315b, 0x315c, 0x315d, 0x315e, 0x315f, 0x3160, 0x3161, 0x3162, 0x3163]
    //    static let doubleJungs = [0x3150, 0x3152, 0x3154, 0x3156, 0x3158, 0x3159, 0x315a, 0x315d, 0x315e, 0x315f, 0x3162]
    //    static let checkingDoubleJungs = [(0x3151, 0x3163), (0x3155, 0x3163), (0x3157, 0x314f), ()]
    //    static let jongs = [0x0000, 0x3131, 0x3132, 0x3133, 0x3134, 0x3135, 0x3136, 0x3137, 0x3139, 0x313a, 0x313b, 0x313c, 0x313d, 0x313e, 0x313f, 0x3140, 0x3141, 0x3142, 0x3144, 0x3145, 0x3146, 0x3147, 0x3148, 0x314a, 0x314b, 0x314c, 0x314d, 0x314e]
    
    static let chos = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    static let doubleChos = ["ㄲ", "ㄸ", "ㅃ", "ㅆ", "ㅉ"]
    static let checkingDoubleChos = [("ㄱ", "ㄱ"), ("ㄷ", "ㄷ"), ("ㅂ", "ㅂ"), ("ㅅ", "ㅅ"), ("ㅈ", "ㅈ")]
    
    static let jungs = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]
    static let doubleJungs = ["ㅐ", "ㅒ", "ㅔ", "ㅖ", "ㅘ", "ㅙ", "ㅚ", "ㅝ", "ㅞ", "ㅟ", "ㅢ"]
    static let checkingDoubleJungs = [("ㅏ", "ㅣ"), ("ㅑ", "ㅣ"), ("ㅓ", "ㅣ"), ("ㅕ", "ㅣ"), ("ㅗ", "ㅏ"), ("ㅗ", "ㅐ"), ("ㅗ", "ㅣ"), ("ㅜ", "ㅓ"), ("ㅜ", "ㅔ"), ("ㅜ", "ㅣ"), ("ㅡ", "ㅣ")]
    static let tripleJungs = ["ㅙ", "ㅞ"]
    static let checkingTripleJungs = [("ㅘ","ㅣ"), ("ㅝ", "ㅣ")]
    
    static let jongs = [" ", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    static let singleJongs = ["ㄷ", "ㅁ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    static let doubleJongs = ["ㄲ", "ㄳ", "ㄵ", "ㄶ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅄ", "ㅆ"]
    static let checkingJongs = [("ㄱ", "ㄱ"), ("ㄱ", "ㅅ"), ("ㄴ", "ㅈ"), ("ㄴ", "ㅎ"), ("ㄹ", "ㄱ"), ("ㄹ", "ㅁ"), ("ㄹ", "ㅂ"), ("ㄹ", "ㅅ"), ("ㄹ" , "ㅌ"), ("ㄹ", "ㅍ"), ("ㄹ", "ㅎ"), ("ㅂ", "ㅅ"), ("ㅅ", "ㅅ")]
    
}

class SpecialCharSet {
    static let delete = 9003
    static let enter = 9166
    
}

