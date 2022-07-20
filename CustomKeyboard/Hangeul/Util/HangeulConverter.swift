//
//  HangeulHelper.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/20.
//

import Foundation

class HangeulConverter : UnicodeConverter {
    
    func convertCharFromUniCode(_ unicode: Int) -> String {
        guard let unicodeScalar = UnicodeScalar(unicode) else {
            print("fail parsing to Int")
            return ""
        }
        return unicodeScalar.description
    }
    
    func convertUniCodeFromChar(_ char: String) -> Int {
        guard let unicodeScalar = UnicodeScalar(char) else {
            print("fail parsing to String")
            return 0
        }
        return Int(unicodeScalar.value)
    }
    
    func combineCharToUnicode(initial: Int, neutral: Int, final: Int) -> Int {
        return 44032 + (initial * 588) + (neutral * 28) + final
    }
    
    func lastCharState(_ unicode: Int) -> CharState {
        if (unicode >= 44032) {
            let value:Int = unicode - 44032
            let final:Int = value % 28
            if (final == 0) {
                return .noneFinalChar
            } else {
                return .includingFinalChar
            }
        } else if (unicode <= CharUnicode.ㅎ.value) {
            return .onlyConsonant
        } else {
            return .onlyVowel
        }
    }
    
}
