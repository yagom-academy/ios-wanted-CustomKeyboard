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
            guard let final = lastChar.final else {
                print("Not Have Final")
                return ""
            }
            let combineCharValue = combineFinalToConsonant(lastChar: lastChar, consonant: inputhChar)
            if combineCharValue == 0 {
                let lastChar = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: final)
                return converter.convertCharFromUniCode(lastChar) + converter.convertCharFromUniCode(inputhChar)
            } else {
                return converter.convertCharFromUniCode(combineCharValue)
            }
        } else {
            return combineFinalToVowel(lastChar: lastChar, vowel: inputhChar)
        }
    }
    private func combineFinalToConsonant(lastChar: HangeulStruct, consonant: Int) -> Int {
        guard let final = lastChar.final else {
            print("Not Have Final")
            return 0
        }
        let initialValue = Initial.getConsonantToInitialValue(consonant)
        var lastCharUnicode = 0
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
            return 0
        }
        
        return lastCharUnicode
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
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄱ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㄱ.value, neutral: neutral, final: 0)
        case Final.ㄳ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄱ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅅ.value, neutral: neutral, final: 0)
        case Final.ㄵ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄴ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅈ.value, neutral: neutral, final: 0)
        case Final.ㄶ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄴ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅎ.value, neutral: neutral, final: 0)
        case Final.ㄺ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㄱ.value, neutral: neutral, final: 0)
        case Final.ㄻ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅁ.value, neutral: neutral, final: 0)
        case Final.ㄼ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅂ.value, neutral: neutral, final: 0)
        case Final.ㄽ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅅ.value, neutral: neutral, final: 0)
        case Final.ㄾ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅌ.value, neutral: neutral, final: 0)
        case Final.ㅀ.value :
            lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: Final.ㄹ.value)
            nextCharUnicode = converter.combineCharToUnicode(initial: Initial.ㅎ.value, neutral: neutral, final: 0)
        default:
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
            let combineCharUnicode = combineNoneFinalToVowel(lastChar: lastChar, inputChar: inputChar)
            if combineCharUnicode == 0 {
                let lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: lastChar.neutral, final: 0)
                return converter.convertCharFromUniCode(lastCharUnicode) + converter.convertCharFromUniCode(inputChar)
            } else {
                return converter.convertCharFromUniCode(combineCharUnicode)
            }
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
    
    private func combineNoneFinalToVowel(lastChar : HangeulStruct, inputChar : Int) -> Int{
        let neutralValue = Neutral.getVowelToNeutralValue(inputChar)
        var lastCharUnicode = 0
        switch lastChar.neutral {
        case Neutral.ㅏ.value :
            if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅐ.value, final: 0)
            }
        case Neutral.ㅑ.value :
            if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅒ.value, final: 0)
            }
        case Neutral.ㅓ.value :
            if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅔ.value, final: 0)
            }
        case Neutral.ㅕ.value :
            if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅖ.value, final: 0)
            }
        case Neutral.ㅗ.value :
            if neutralValue == Neutral.ㅏ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅘ.value, final: 0)
            } else if neutralValue == Neutral.ㅐ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅙ.value, final: 0)
            } else if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅚ.value, final: 0)
            }
        case Neutral.ㅜ.value :
            if neutralValue == Neutral.ㅓ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅝ.value, final: 0)
            } else if neutralValue == Neutral.ㅔ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅞ.value, final: 0)
            } else if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅟ.value, final: 0)
            }
        case Neutral.ㅡ.value :
            if neutralValue == Neutral.ㅣ.value {
                lastCharUnicode = converter.combineCharToUnicode(initial: lastChar.initial, neutral: Neutral.ㅢ.value, final: 0)
            }
        default :
            return 0
        }
        return lastCharUnicode
    }
    //MARK: - 자음만
    private func combineOnlyConsonant(consonant : Int, inputChar : Int) -> String {
        if inputChar <= CharUnicode.ㅎ.value {
            let combineCharUnicode = combineConsonantToConsonant(consonant: consonant, inputChar: inputChar)
            if combineCharUnicode == 0 {
                return converter.convertCharFromUniCode(consonant) + converter.convertCharFromUniCode(inputChar)
            } else {
                return converter.convertCharFromUniCode(combineCharUnicode)
            }
        } else {
            return combineConsonantToVowel(consonant : consonant, inputChar : inputChar)
        }
    }
    private func combineConsonantToConsonant(consonant : Int, inputChar : Int) -> Int {
        let inputinitial = Initial.getConsonantToInitialValue(inputChar)
        let lastinitial = Initial.getConsonantToInitialValue(consonant)
        var lastCharUnicode = 0
        switch lastinitial {
        case Initial.ㄱ.value :
            if inputinitial == Initial.ㄱ.value {
                lastCharUnicode = CharUnicode.ㄲ.value
            }
        case Initial.ㄷ.value :
            if inputinitial == Initial.ㄷ.value {
                lastCharUnicode = CharUnicode.ㄸ.value
            }
        case Initial.ㅂ.value :
            if inputinitial == Initial.ㅂ.value {
                lastCharUnicode = CharUnicode.ㅃ.value
            }
        case Initial.ㅅ.value :
            if inputinitial == Initial.ㅅ.value {
                lastCharUnicode = CharUnicode.ㅆ.value
            }
        case Initial.ㅈ.value :
            if inputinitial == Initial.ㅈ.value {
                lastCharUnicode = CharUnicode.ㅉ.value
            }
        default :
            return 0
        }
        return lastCharUnicode
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
            let combineCharUnicode = combineVowelToVowel(vowel: vowel, inputChar: inputChar)
            if combineCharUnicode == 0 {
                return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
            } else {
                return converter.convertCharFromUniCode(combineCharUnicode)
            }
        }
    }
    private func combineVowelToConsonant(vowel : Int, inputChar : Int) -> String {
        return converter.convertCharFromUniCode(vowel) + converter.convertCharFromUniCode(inputChar)
    }
    
    private func combineVowelToVowel(vowel : Int, inputChar : Int) -> Int {
        let inputNeutral = Neutral.getVowelToNeutralValue(inputChar)
        let lastNeutral = Neutral.getVowelToNeutralValue(vowel)
        var lastCharUnicode = 0
        switch lastNeutral {
        case Neutral.ㅏ.value :
            if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅐ.value
            }
        case Neutral.ㅑ.value :
            if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅒ.value
            }
        case Neutral.ㅓ.value :
            if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅔ.value
            }
        case Neutral.ㅕ.value :
            if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅖ.value
            }
        case Neutral.ㅗ.value :
            if inputNeutral == Neutral.ㅏ.value {
                lastCharUnicode = CharUnicode.ㅘ.value
            } else if inputNeutral == Neutral.ㅐ.value {
                lastCharUnicode = CharUnicode.ㅙ.value
            } else if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅚ.value
            }
        case Neutral.ㅜ.value :
            if inputNeutral == Neutral.ㅓ.value {
                lastCharUnicode = CharUnicode.ㅝ.value
            } else if inputNeutral == Neutral.ㅔ.value {
                lastCharUnicode = CharUnicode.ㅞ.value
            } else if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅟ.value
            }
        case Neutral.ㅡ.value :
            if inputNeutral == Neutral.ㅣ.value {
                lastCharUnicode = CharUnicode.ㅢ.value
            }
        default :
            return 0
        }
        return lastCharUnicode
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

