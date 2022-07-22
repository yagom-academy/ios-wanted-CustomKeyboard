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
    func addChar(_ unicode: Int, _ inputChar: Int) -> String {
        
        let lastCodeState = converter.lastCharState(unicode)
        
        switch lastCodeState {
        case .includingFinalChar :
            print("includingFinalChar")
            guard let initial = converter.getInitalValue(unicode),
                  let neutral = converter.getNeutralValue(unicode),
                  let final = converter.getFinalValue(unicode) else {
                print("Not includingFinalChar")
                return ""
            }
            let hangeulStruct = HangeulStruct(initial: initial, neutral: neutral, final: final)
            return combineIncludingFinalChar(lastChar: hangeulStruct, inputhChar: inputChar)
        case .noneFinalChar :
            print("noneFinalChar")
            guard let initial = converter.getInitalValue(unicode),
                  let neutral = converter.getNeutralValue(unicode) else {
                print("Not noneFinalChar")
                return ""
            }
            let hangeulStruct = HangeulStruct(initial: initial, neutral: neutral, final: nil)
            return combineNoneFinalChar(lastChar: hangeulStruct, inputChar: inputChar)
        case .onlyConsonant :
            print("onlyConsonant")
            return combineOnlyConsonant(unicode: unicode, inputChar: inputChar)
        case .onlyVowel:
            print("onlyVowel")
            let neutralValue = getVowelToNeutralValue(unicode)
            return combineOnlyVowel(neutralValue: neutralValue, inputChar: inputChar)
        }
    }
    
    func removeChar(_ unicode : Int) -> String {
        let lastCodeState = converter.lastCharState(unicode)
        
        switch lastCodeState {
        case .includingFinalChar:
            guard let initial = converter.getInitalValue(unicode),
                  let neutral = converter.getNeutralValue(unicode),
                  let final = converter.getFinalValue(unicode) else {
                print("Not includingFinalChar")
                return ""
            }
            let hangeulStruct = HangeulStruct(initial: initial, neutral: neutral, final: final)
            return removeIncludingFinalChar(lastChar: hangeulStruct)
        case .noneFinalChar:
            guard let initial = converter.getInitalValue(unicode),
                  let neutral = converter.getNeutralValue(unicode) else {
                print("Not noneFinalChar")
                return ""
            }
            let hangeulStruct = HangeulStruct(initial: initial, neutral: neutral, final: nil)
            return removeNoneFinalChar(lastChar: hangeulStruct)
        case .onlyConsonant:
            return removeOnlyConsonant(unicode: unicode)
        case .onlyVowel:
            return removeOnlyVowel(unicode: unicode)
        }
    }
    
//MARK: - 유니코드 -> 모음, 자음값으로 변경
    private func getVowelToNeutralValue(_ unicode: Int) -> Int {
        return unicode - 12623
    }

    private func getNeutralValueToVowel(_ NeutralValue: Int) -> Int {
        return NeutralValue + 12623
    }
    
    private func getInitialValueToUnicode(_ InitialValue : Int) -> Int {
        switch InitialValue {
        case 0 :
            return CharUnicode.ㄱ.value
        case 1 :
            return CharUnicode.ㄲ.value
        case 2 :
            return CharUnicode.ㄴ.value
        case 3 :
            return CharUnicode.ㄷ.value
        case 4 :
            return CharUnicode.ㄸ.value
        case 5 :
            return CharUnicode.ㄹ.value
        case 6 :
            return CharUnicode.ㅁ.value
        case 7 :
            return CharUnicode.ㅂ.value
        case 8 :
            return CharUnicode.ㅃ.value
        case 9 :
            return CharUnicode.ㅅ.value
        case 10 :
            return CharUnicode.ㅆ.value
        case 11 :
            return CharUnicode.ㅇ.value
        case 12 :
            return CharUnicode.ㅈ.value
        case 13 :
            return CharUnicode.ㅉ.value
        case 14 :
            return CharUnicode.ㅊ.value
        case 15 :
            return CharUnicode.ㅋ.value
        case 16 :
            return CharUnicode.ㅌ.value
        case 17 :
            return CharUnicode.ㅍ.value
        case 18 :
            return CharUnicode.ㅎ.value
        default :
            return 0
        }
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
    
    private func getConsonantToInitialValue(_ consonant: Int) -> Int {
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
    
    private func consonantToFianlValue(_ consonant: Int) -> Int {
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
//MARK: - 받침 있음
    private func combineIncludingFinalChar(lastChar: HangeulStruct, inputhChar : Int) -> String{
        
        if inputhChar <= CharUnicode.ㅎ.value {
            return combineFinalToConsonant(lastChar: lastChar, consonant: inputhChar)
        } else {
            return combineFinalToVowel(lastChar: lastChar, vowel: inputhChar)
        }
    }
    private func combineFinalToConsonant(lastChar: HangeulStruct, consonant: Int) -> String {
        guard let final = lastChar.final else {
            print("Not Have Final")
            return ""
        }
        let initialValue = getConsonantToInitialValue(consonant)
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
        case Final.ㅅ.value :
            if initialValue == Initial.ㅅ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㅆ.value)
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
        case Final.ㅀ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅎ.value, neutral: neutral, final: 0)
        default:
            print("default")
            let paringValue = finalValueToInitialValue(final)
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
            nextCharUnicode = converter.combineCharToUnicode(initial: paringValue, neutral: neutral, final: 0)
        }
        
        return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(nextCharUnicode)
    }
//MARK: - 받침 없음
    func combineNoneFinalChar(lastChar: HangeulStruct, inputChar : Int) -> String {
        if inputChar <= CharUnicode.ㅎ.value {
            return combineNoneFinalToConsonant(lastChar: lastChar, inputChar: inputChar)
        } else {
            return combineNoneFinalToVowel(lastChar: lastChar, inputChar: inputChar)
        }
    }
    
    func combineNoneFinalToConsonant(lastChar : HangeulStruct, inputChar : Int) -> String {
        var lastCharUnicode = 0
        switch inputChar {
        case CharUnicode.ㅃ.value, CharUnicode.ㄸ.value, CharUnicode.ㅉ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
            return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(inputChar)
        default :
            let final = consonantToFianlValue(inputChar)
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: final)
            return converter.convertCharFromUniCode(lastCharUnicode)
        }
    }
    
    func combineNoneFinalToVowel(lastChar : HangeulStruct, inputChar : Int) -> String{
        let neutralValue = getVowelToNeutralValue(inputChar)
        var lastCharUnicode = 0
        switch lastChar.neutral {
        case Neutral.ㅏ.value :
            if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅐ.value, final: 0)
            } else {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅑ.value :
            if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅒ.value, final: 0)
            } else {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅓ.value :
            if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅔ.value, final: 0)
            } else {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅕ.value :
            if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅖ.value, final: 0)
            } else {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅗ.value :
            if neutralValue == Neutral.ㅏ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅘ.value, final: 0)
            } else if neutralValue == Neutral.ㅐ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅙ.value, final: 0)
            } else if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅚ.value, final: 0)
            } else {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅜ.value :
            if neutralValue == Neutral.ㅓ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅝ.value, final: 0)
            } else if neutralValue == Neutral.ㅔ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅞ.value, final: 0)
            } else if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅟ.value, final: 0)
            } else {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅡ.value :
            if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅢ.value, final: 0)
            } else {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(inputChar)
            }
        default :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
            return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(inputChar)
        }
        return converter.convertCharFromUniCode(lastCharUnicode)
    }
//MARK: - 자음만
    func combineOnlyConsonant(unicode : Int, inputChar : Int) -> String {
        if inputChar <= CharUnicode.ㅎ.value {
            return combineConsonantToConsonant(unicode: unicode, inputChar: inputChar)
        } else {
            return combineConsonantToVowel(unicode : unicode, inputChar : inputChar)
        }
    }
    func combineConsonantToConsonant(unicode : Int, inputChar : Int) -> String {
        let initial = getConsonantToInitialValue(inputChar)
        let initialValue = getConsonantToInitialValue(unicode)
        var lastCharUnicode = 0
        switch initialValue {
        case Initial.ㄱ.value :
            if initial == Initial.ㄱ.value {
                lastCharUnicode = CharUnicode.ㄲ.value
            } else {
                return converter.convertCharFromUniCode(unicode) + converter.convertCharFromUniCode(inputChar)
            }
        case Initial.ㄷ.value :
            if initial == Initial.ㄷ.value {
                lastCharUnicode = CharUnicode.ㄸ.value
            } else {
                return converter.convertCharFromUniCode(unicode) + converter.convertCharFromUniCode(inputChar)
            }
        case Initial.ㅂ.value :
            if initial == Initial.ㅂ.value {
                lastCharUnicode = CharUnicode.ㅃ.value
            } else {
                return converter.convertCharFromUniCode(unicode) + converter.convertCharFromUniCode(inputChar)
            }
        case Initial.ㅅ.value :
            if initial == Initial.ㅅ.value {
                lastCharUnicode = CharUnicode.ㅆ.value
            } else {
                return converter.convertCharFromUniCode(unicode) + converter.convertCharFromUniCode(inputChar)
            }
        case Initial.ㅈ.value :
            if initial == Initial.ㅈ.value {
                lastCharUnicode = CharUnicode.ㅉ.value
            } else {
                return converter.convertCharFromUniCode(unicode) + converter.convertCharFromUniCode(inputChar)
            }
        default :
            return converter.convertCharFromUniCode(unicode) + converter.convertCharFromUniCode(inputChar)
        }
        return converter.convertCharFromUniCode(lastCharUnicode)
    }
    
    func combineConsonantToVowel(unicode : Int, inputChar : Int) -> String {
        let neutralValue = getVowelToNeutralValue(inputChar)
        let initialValue = getConsonantToInitialValue(unicode)
        let lastCharUnicode = converter.combineCharToUnicode(initial: initialValue, neutral: neutralValue, final: 0)
        return converter.convertCharFromUniCode(lastCharUnicode)
    }
//MARK: - 모음만
    func combineOnlyVowel(neutralValue : Int, inputChar : Int) -> String {
        if inputChar <= CharUnicode.ㅎ.value {
            return combineVowelToConsonant(neutralValue: neutralValue, inputChar: inputChar)
        } else {
            return combineVowelToVowel(neutralValue: neutralValue, inputChar: inputChar)
        }
    }
    func combineVowelToConsonant(neutralValue : Int, inputChar : Int) -> String {
        let vowel = getNeutralValueToVowel(neutralValue)
        return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
    }
    
    func combineVowelToVowel(neutralValue : Int, inputChar : Int) -> String {
        let neutral = getVowelToNeutralValue(inputChar)
        var lastCharUnicode = 0
        switch neutralValue {
        case Neutral.ㅏ.value :
            if neutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅐ.value
            } else {
                let vowel = getNeutralValueToVowel(neutralValue)
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅑ.value :
            if neutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅒ.value
            } else {
                let vowel = getNeutralValueToVowel(neutralValue)
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅓ.value :
            if neutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅔ.value
            } else {
                let vowel = getNeutralValueToVowel(neutralValue)
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅕ.value :
            if neutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅖ.value
            } else {
                let vowel = getNeutralValueToVowel(neutralValue)
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅗ.value :
            if neutral == Neutral.ㅏ.value {
                lastCharUnicode = CharUnicode.ㅘ.value
            } else if neutral == Neutral.ㅐ.value {
                lastCharUnicode = CharUnicode.ㅙ.value
            } else if neutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅚ.value
            } else {
                let vowel = getNeutralValueToVowel(neutralValue)
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅜ.value :
            if neutral == Neutral.ㅓ.value {
                lastCharUnicode = CharUnicode.ㅝ.value
            } else if neutral == Neutral.ㅔ.value {
                lastCharUnicode = CharUnicode.ㅞ.value
            } else if neutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅟ.value
            } else {
                let vowel = getNeutralValueToVowel(neutralValue)
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅡ.value :
            if neutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅢ.value
            } else {
                let vowel = getNeutralValueToVowel(neutralValue)
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        default :
            let vowel = getNeutralValueToVowel(neutralValue)
            return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
        }
        return converter.convertCharFromUniCode(lastCharUnicode)
    }
    //MARK: - Remove 받침 있음
    private func removeIncludingFinalChar(lastChar: HangeulStruct) -> String{
        guard let final = lastChar.final else {
            print("Not IncludingFinalChar")
            return ""
        }
        var lastCharUnicode = 0
        switch final {
        case Final.ㄲ.value, Final.ㄳ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄱ.value)
        case Final.ㄵ.value, Final.ㄶ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄴ.value)
        case Final.ㄺ.value, Final.ㄻ.value, Final.ㄼ.value, Final.ㄽ.value, Final.ㄾ.value, Final.ㄿ.value, Final.ㅀ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
        case Final.ㅄ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㅂ.value)
        case Final.ㅆ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㅅ.value)
        default :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
        }
        
        return converter.convertCharFromUniCode(lastCharUnicode)
    }
    //MARK: - Remove 받침 없음
    func removeNoneFinalChar(lastChar: HangeulStruct) -> String {
        var lastCharUnicode = 0
        switch lastChar.neutral {
        case Neutral.ㅐ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅏ.value, final: 0)
        case Neutral.ㅒ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅑ.value, final: 0)
        case Neutral.ㅔ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅓ.value, final: 0)
        case Neutral.ㅖ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅕ.value, final: 0)
        case Neutral.ㅘ.value, Neutral.ㅙ.value, Neutral.ㅚ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅗ.value, final: 0)
        case Neutral.ㅝ.value, Neutral.ㅞ.value, Neutral.ㅟ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅜ.value, final: 0)
        case Neutral.ㅢ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅡ.value, final: 0)
        default :
            return converter.convertCharFromUniCode(getInitialValueToUnicode(lastChar.initial))
        }
        return converter.convertCharFromUniCode(lastCharUnicode)
    }
    //MARK: - Remove 자음만
    func removeOnlyConsonant(unicode : Int) -> String {
    //case ㄱ,ㄲ,ㄴ,ㄷ,ㄸ,ㄹ,ㅁ,ㅂ,ㅃ,ㅅ,ㅆ,ㅇ,ㅈ,ㅉ,ㅊ,ㅋ,ㅌ,ㅍ,ㅎ
        switch unicode {
        case CharUnicode.ㄲ.value :
            return converter.convertCharFromUniCode(CharUnicode.ㄱ.value)
        case CharUnicode.ㄸ.value :
            return converter.convertCharFromUniCode(CharUnicode.ㄷ.value)
        case CharUnicode.ㅃ.value :
            return converter.convertCharFromUniCode(CharUnicode.ㅂ.value)
        case CharUnicode.ㅆ.value :
            return converter.convertCharFromUniCode(CharUnicode.ㅅ.value)
        case CharUnicode.ㅉ.value :
            return converter.convertCharFromUniCode(CharUnicode.ㅈ.value)
        default:
            return ""
        }
    }
    //MARK: - Remove 모음만
    func removeOnlyVowel(unicode : Int) -> String {
        switch unicode {
        case CharUnicode.ㅐ.value :
            return converter.convertCharFromUniCode(CharUnicode.ㅏ.value)
        case CharUnicode.ㅒ.value :
            return converter.convertCharFromUniCode(CharUnicode.ㅑ.value)
        case CharUnicode.ㅔ.value :
            return converter.convertCharFromUniCode(CharUnicode.ㅓ.value)
        case CharUnicode.ㅖ.value :
            return converter.convertCharFromUniCode(CharUnicode.ㅕ.value)
        case CharUnicode.ㅘ.value, CharUnicode.ㅙ.value, CharUnicode.ㅚ.value :
            return converter.convertCharFromUniCode(CharUnicode.ㅗ.value)
        case CharUnicode.ㅝ.value, CharUnicode.ㅞ.value, CharUnicode.ㅟ.value :
            return converter.convertCharFromUniCode(CharUnicode.ㅜ.value)
        case CharUnicode.ㅢ.value :
            return converter.convertCharFromUniCode(CharUnicode.ㅡ.value)
        default :
            return ""
        }
        
    }


    
}

