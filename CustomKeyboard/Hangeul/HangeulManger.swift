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
        case .includingFinalChar(let initial,let neutral,let final) :
            let hangeulStruct = HangeulStruct(initial: initial, neutral: neutral, final: final)
            return combineIncludingFinalChar(lastChar: hangeulStruct, inputhChar: inputChar)
        case .noneFinalChar(let initial,let neutral) :
            let hangeulStruct = HangeulStruct(initial: initial, neutral: neutral, final: nil)
            return combineNoneFinalChar(lastChar: hangeulStruct, inputChar: inputChar)
        case .onlyConsonant:
            return combineOnlyConsonant(consonant: unicode, inputChar: inputChar)
        case .onlyVowel:
            return combineOnlyVowel(vowel: unicode, inputChar: inputChar)
        }
    }
    
    func removeChar(_ unicode : Int) -> String {
        let lastCodeState = converter.lastCharState(unicode)
        
        switch lastCodeState {
        case .includingFinalChar(let initial,let neutral,let final) :
            let hangeulStruct = HangeulStruct(initial: initial, neutral: neutral, final: final)
            return removeIncludingFinalChar(lastChar: hangeulStruct)
        case .noneFinalChar(let initial,let neutral) :
            let hangeulStruct = HangeulStruct(initial: initial, neutral: neutral, final: nil)
            return removeNoneFinalChar(lastChar: hangeulStruct)
        case .onlyConsonant:
            return removeOnlyConsonant(consonant: unicode)
        case .onlyVowel:
            return removeOnlyVowel(vowel: unicode)
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
        let initialValue = Initial.getConsonantToInitialValue(consonant)
        var lastCharUnicode = 0
        let nextCharUnicode = consonant
        switch final {
        case Final.ㄱ.value :
            if initialValue == Initial.ㄱ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄲ.value)
            } else if initialValue == Initial.ㅅ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄳ.value)
            } else {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: final)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(nextCharUnicode)
            }
        case Final.ㄴ.value :
            if initialValue == Initial.ㅈ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄵ.value)
            } else if initialValue == Initial.ㅎ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄶ.value)
            } else {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: final)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(nextCharUnicode)
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
            } else {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: final)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(nextCharUnicode)
            }
        case Final.ㅂ.value :
            if initialValue == Initial.ㅅ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㅄ.value)
            } else {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: final)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(nextCharUnicode)
            }
        case Final.ㅅ.value :
            if initialValue == Initial.ㅅ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㅆ.value)
            } else {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: final)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(nextCharUnicode)
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
        let neutral = Neutral.getVowelToNeutralValue(vowel)
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
            let paringValue = Initial.getFinalValueToInitialValue(final)
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
            nextCharUnicode = converter.combineCharToUnicode(initial: paringValue, neutral: neutral, final: 0)
        }
        
        return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(nextCharUnicode)
    }
//MARK: - 받침 없음
    private func combineNoneFinalChar(lastChar: HangeulStruct, inputChar : Int) -> String {
        if inputChar <= CharUnicode.ㅎ.value {
            return combineNoneFinalToConsonant(lastChar: lastChar, inputChar: inputChar)
        } else {
            return combineNoneFinalToVowel(lastChar: lastChar, inputChar: inputChar)
        }
    }
    
    private func combineNoneFinalToConsonant(lastChar : HangeulStruct, inputChar : Int) -> String {
        var lastCharUnicode = 0
        switch inputChar {
        case CharUnicode.ㅃ.value, CharUnicode.ㄸ.value, CharUnicode.ㅉ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
            return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(inputChar)
        default :
            let final = Final.getConsonantToFianlValue(inputChar)
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: final)
            return converter.convertCharFromUniCode(lastCharUnicode)
        }
    }
    
    private func combineNoneFinalToVowel(lastChar : HangeulStruct, inputChar : Int) -> String{
        let neutralValue = Neutral.getVowelToNeutralValue(inputChar)
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
    private func combineOnlyConsonant(consonant : Int, inputChar : Int) -> String {
        if inputChar <= CharUnicode.ㅎ.value {
            return combineConsonantToConsonant(consonant: consonant, inputChar: inputChar)
        } else {
            return combineConsonantToVowel(consonant : consonant, inputChar : inputChar)
        }
    }
    private func combineConsonantToConsonant(consonant : Int, inputChar : Int) -> String {
        let initial = Initial.getConsonantToInitialValue(inputChar)
        let initialValue = Initial.getConsonantToInitialValue(consonant)
        var lastCharUnicode = 0
        switch initialValue {
        case Initial.ㄱ.value :
            if initial == Initial.ㄱ.value {
                lastCharUnicode = CharUnicode.ㄲ.value
            } else {
                return converter.convertCharFromUniCode(consonant) + converter.convertCharFromUniCode(inputChar)
            }
        case Initial.ㄷ.value :
            if initial == Initial.ㄷ.value {
                lastCharUnicode = CharUnicode.ㄸ.value
            } else {
                return converter.convertCharFromUniCode(consonant) + converter.convertCharFromUniCode(inputChar)
            }
        case Initial.ㅂ.value :
            if initial == Initial.ㅂ.value {
                lastCharUnicode = CharUnicode.ㅃ.value
            } else {
                return converter.convertCharFromUniCode(consonant) + converter.convertCharFromUniCode(inputChar)
            }
        case Initial.ㅅ.value :
            if initial == Initial.ㅅ.value {
                lastCharUnicode = CharUnicode.ㅆ.value
            } else {
                return converter.convertCharFromUniCode(consonant) + converter.convertCharFromUniCode(inputChar)
            }
        case Initial.ㅈ.value :
            if initial == Initial.ㅈ.value {
                lastCharUnicode = CharUnicode.ㅉ.value
            } else {
                return converter.convertCharFromUniCode(consonant) + converter.convertCharFromUniCode(inputChar)
            }
        default :
            return converter.convertCharFromUniCode(consonant) + converter.convertCharFromUniCode(inputChar)
        }
        return converter.convertCharFromUniCode(lastCharUnicode)
    }
    
    private func combineConsonantToVowel(consonant : Int, inputChar : Int) -> String {
        let neutralValue = Neutral.getVowelToNeutralValue(inputChar)
        let initialValue = Initial.getConsonantToInitialValue(consonant)
        let lastCharUnicode = converter.combineCharToUnicode(initial: initialValue, neutral: neutralValue, final: 0)
        return converter.convertCharFromUniCode(lastCharUnicode)
    }
//MARK: - 모음만
    private func combineOnlyVowel(vowel : Int, inputChar : Int) -> String {
        if inputChar <= CharUnicode.ㅎ.value {
            return combineVowelToConsonant(vowel: vowel, inputChar: inputChar)
        } else {
            return combineVowelToVowel(vowel: vowel, inputChar: inputChar)
        }
    }
    private func combineVowelToConsonant(vowel : Int, inputChar : Int) -> String {
        return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
    }
    
    private func combineVowelToVowel(vowel : Int, inputChar : Int) -> String {
        let inputNeutral = Neutral.getVowelToNeutralValue(inputChar)
        let lastNeutral = Neutral.getVowelToNeutralValue(vowel)
        var lastCharUnicode = 0
        switch lastNeutral {
        case Neutral.ㅏ.value :
            if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅐ.value
            } else {
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅑ.value :
            if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅒ.value
            } else {
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅓ.value :
            if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅔ.value
            } else {
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅕ.value :
            if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅖ.value
            } else {
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅗ.value :
            if inputNeutral == Neutral.ㅏ.value {
                lastCharUnicode = CharUnicode.ㅘ.value
            } else if inputNeutral == Neutral.ㅐ.value {
                lastCharUnicode = CharUnicode.ㅙ.value
            } else if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅚ.value
            } else {
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅜ.value :
            if inputNeutral == Neutral.ㅓ.value {
                lastCharUnicode = CharUnicode.ㅝ.value
            } else if inputNeutral == Neutral.ㅔ.value {
                lastCharUnicode = CharUnicode.ㅞ.value
            } else if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅟ.value
            } else {
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        case Neutral.ㅡ.value :
            if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅢ.value
            } else {
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            }
        default :
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
            return converter.convertCharFromUniCode(CharUnicode.getInitialValueToUnicode(lastChar.initial))
        }
        return converter.convertCharFromUniCode(lastCharUnicode)
    }
    //MARK: - Remove 자음만
    func removeOnlyConsonant(consonant : Int) -> String {
        switch consonant {
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
    private func removeOnlyVowel(vowel : Int) -> String {
        switch vowel {
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

