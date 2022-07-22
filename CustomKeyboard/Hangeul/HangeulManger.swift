//
//  HangeulManger.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/20.
//

import Foundation

class HangeulManger : UnicodeManger {

    var converter : UnicodeConverter
    
    init(_ converter : UnicodeConverter) {
        self.converter = converter
    }
    func addChar(_ unitcode: Int, _ inputChar: Int) -> String {
        
        let lastCodeState = converter.lastCharState(unitcode)
        
        switch lastCodeState {
        case .includingFinalChar :
            print("includingFinalChar")
            guard let initial = converter.getInitalValue(unitcode),
                  let neutral = converter.getNeutralValue(unitcode),
                  let final = converter.getFinalValue(unitcode) else {
                print("Not includingFinalChar")
                return ""
            }
            let hangeulStruct = HangeulStruct(initial: initial, neutral: neutral, final: final)
            return combineIncludingFinalChar(lastChar: hangeulStruct, inputhChar: inputChar)
        case .noneFinalChar :
            print("noneFinalChar")
            guard let initial = converter.getInitalValue(unitcode),
                  let neutral = converter.getNeutralValue(unitcode) else {
                print("Not noneFinalChar")
                return ""
            }
            let hangeulStruct = HangeulStruct(initial: initial, neutral: neutral, final: nil)
        case .onlyConsonant :
            print("onlyConsonant")
        case .onlyVowel :
            print("onlyVowel")
        }
        
        return "각"
    }
    
    func removeChar() {
        print("Test")
    }
    
//MARK: - 유니코드 -> 모음, 자음값으로 변경
    private func getVowelToNeutralValue(_ unicode: Int) -> Int {
        return unicode - 12623
    }
    
    private func finalValueToInitialValue(_ final: Int) -> Int {
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
    
    private func consonantToInitialValue(_ consonant: Int) -> Int {
        
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
//MARK: - 받침 있음
    private func combineIncludingFinalChar(lastChar: HangeulStruct, inputhChar : Int) -> String{
        
        if inputhChar <= CharUnicode.ㅎ.value {
            return combineFinalToConsonant(lastChar: lastChar, consonant: inputhChar)
        } else
        {
            return combineFinalToVowel(lastChar: lastChar, vowel: inputhChar)
        }
    }
    private func combineFinalToConsonant(lastChar: HangeulStruct, consonant: Int) -> String {
        guard let final = lastChar.final else {
            print("Not Have Final")
            return ""
        }
        let initialValue = consonantToInitialValue(consonant)
        var lastCharUnicode = 0
        let nextCharUnicode = consonant
        switch final {
        case Final.ㄱ.value :
            if initialValue == Initial.ㄱ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄲ.value)
            } else if initialValue == Initial.ㅅ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄳ.value)
            }
        case Final.ㄴ.value :
            if initialValue == Initial.ㅈ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄵ.value)
            } else if initialValue == Initial.ㅎ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄶ.value)
            }
        case Final.ㄹ.value :
            if initialValue == Initial.ㄱ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄺ.value)
            } else if initialValue == Initial.ㅁ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄻ.value)
            } else if initialValue == Initial.ㅂ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄼ.value)
            } else if initialValue == Initial.ㅅ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄽ.value)
            } else if initialValue == Initial.ㅌ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄾ.value)
            }else if initialValue == Initial.ㅍ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄿ.value)
            }else if initialValue == Initial.ㅎ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㅀ.value)
            }
        case Final.ㅂ.value :
            if initialValue == Initial.ㅅ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㅄ.value)
            }
        default:
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: final)
            return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(nextCharUnicode)
        }
        
        return converter.convertCharFromUniCode(lastCharUnicode)
    }
    private func combineFinalToVowel(lastChar: HangeulStruct,vowel: Int) -> String {
        guard let final = lastChar.final else {
            print("Not Have Final")
            return ""
        }
        let neutral = getVowelToNeutralValue(vowel)
        var lastCharUnicode = 0
        var nextCharUnicode = 0
        switch final {
        case Final.ㄲ.value :
            print("ㄲ")
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄱ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㄱ.value, neutral: neutral, final: 0)
        case Final.ㄳ.value :
            print("ㄳ")
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄱ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅅ.value, neutral: neutral, final: 0)
        case Final.ㄵ.value :
            print("ㄵ")
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄴ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅈ.value, neutral: neutral, final: 0)
        case Final.ㄶ.value :
            print("ㄶ")
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄴ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅎ.value, neutral: neutral, final: 0)
        case Final.ㄺ.value :
            print("ㄺ")
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㄱ.value, neutral: neutral, final: 0)
        case Final.ㄻ.value :
            print("ㄻ")
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅁ.value, neutral: neutral, final: 0)
        case Final.ㄼ.value :
            print("ㄼ")
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅂ.value, neutral: neutral, final: 0)
        case Final.ㄽ.value :
            print("ㄽ")
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅅ.value, neutral: neutral, final: 0)
        case Final.ㄾ.value :
            print("ㄾ")
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅌ.value, neutral: neutral, final: 0)
        default:
            print("default")
            let paringValue = finalValueToInitialValue(final)
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
            nextCharUnicode = converter.combineCharToUnicode(initial: paringValue, neutral: neutral, final: 0)
        }
        
        return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(nextCharUnicode)
    }
//MARK: - 받침 없음
    func combineNoneFinalChar(lastChar: HangeulStruct, inputhChar : Int) {
        if inputhChar <= CharUnicode.ㅎ.value {
            return combineNoneFinalToConsonant()
        } else
        {
            return combineNoneFinalToVowel()
        }
    }
    
    func combineNoneFinalToConsonant() {
    }
    
    func combineNoneFinalToVowel() {
    }
//MARK: - 자음만
    func combineOnlyConsonant() {
        
    }
    func combineConsonantToConsonant() {
    }
    
    func combineConsonantToVowel() {
    }
//MARK: - 모음만
    func combineOnlyVowel() {
        
    }
    func combineVowelToConsonant() {
    }
    
    func combineVowelToVowel() {
    }
}

