//
//  FirstKeyBoardEngine.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/14.
//

import Foundation

struct FirstKeyBoardEngine: KeyBoardEngine {
    
    enum SeparatedUnicode {
        case perfect(initial:Int, neutral:Int, support:Int)
        case perfectNoSupport(initial:Int, neutral:Int)
        case onlyConsonant(value:Int)
        case onlyVowel(value:Int)
    }
    
    func addWord(inputUniCode:Int, lastUniCode:Int) -> String {
        let parsedLastUnicode: SeparatedUnicode = parsingUniCode(unicode: lastUniCode)
        print(parsedLastUnicode)
        switch parsedLastUnicode {
        case .perfect(let initial, let neutral, let support):
            return combineToPerfactChar(initial:initial, neutral: neutral, support: support, inputLetter: inputUniCode)
        case .perfectNoSupport(let initial, let neutral):
            return combineToPerfactCharNoSupport(lastUnicode: lastUniCode, initial: initial, neutral: neutral, inputLetter: inputUniCode)
        case .onlyConsonant(let value):
            return combineToOnlyInitialChar(lastUnicode: lastUniCode, consonant: value, inputLetter: inputUniCode)
        case .onlyVowel(let value):
            return combineToOnlyVowelChar(lastUnicode: lastUniCode, vowel: value, inputLetter: inputUniCode)
        }
    }
    
    func removeWord(lastUniCode:Int) -> String {
        return ""
    }
}

//MARK: - 기본Tool 메서드: 1.유니코드를 분리, 2.결합, 3.Int->String, 4.String->Int 메서드
extension FirstKeyBoardEngine {
    private func parsingUniCode(unicode:Int) -> SeparatedUnicode {
        if (unicode >= 44032) {
            let value:Int = unicode - 44032
            let initial:Int = Int(floor(Double(value / (21*28))))
            let neutral:Int = (value % (21*28)) / 28
            let support:Int = value % 28
            if (support == 0) {
                return .perfectNoSupport(initial: initial, neutral: neutral)
            } else {
                return .perfect(initial: initial, neutral: neutral, support: support)
            }
        } else if (unicode <= 12622) {
            return .onlyConsonant(value: unicode)
        } else {
            return .onlyVowel(value: unicode)
        }
    }
    
    private func makeWord(initial:Int, neutral:Int, support:Int) -> Int {
        return 44032 + (initial*21*28) + (neutral*28) + support
    }
    
    private func makeCharFromUnicode(_ unicode:Int) -> String {
        guard let unicodeScalar = UnicodeScalar(unicode) else {
            print("fail parsing to String!, input: ", unicode)
            return ""
        }
        return String(unicodeScalar)
    }
    
    private func makeUnicodeFromChar(_ char:String) -> Int {
        guard let unicodeScalar = UnicodeScalar(char) else {
            print("fail parsing to String!, input: ", char)
            return 0
        }
        return Int(unicodeScalar.value)
    }
}

//MARK: - 받침 + 입력값(글자)
extension FirstKeyBoardEngine {
    typealias CombinedToPerfactCharOutput = (support:Int, secondCharUnicode:Int)
    private func combineToPerfactChar(initial:Int, neutral:Int, support:Int, inputLetter:Int) -> String {
        var combinedData: CombinedToPerfactCharOutput
        if (inputLetter <= 12622) {
            combinedData = combineSupportWithConsonant(support: support, consonant: inputLetter)
        } else {
            combinedData = combineSupportWithVowel(support: support, vowel: inputLetter)
        }
        let firstCharUnicode = makeWord(initial: initial, neutral: neutral, support: combinedData.support)
        let firstChar = makeCharFromUnicode(firstCharUnicode)
        let secondChar = makeCharFromUnicode(combinedData.secondCharUnicode)
        return firstChar + secondChar
    }
    
    private func combineSupportWithConsonant(support:Int, consonant:Int) -> CombinedToPerfactCharOutput {
        switch support {
        case Support.ㄱ.code:
            return consonant == 12613 ? (Support.ㄳ.code,0) : (support,0)
        case Support.ㄴ.code:
            if consonant == 12616 {
                return (Support.ㄵ.code,0)
            } else if consonant == 12622 {
                return (Support.ㄶ.code,0)
            }
            break
        case Support.ㄹ.code:
            switch consonant {
            case 12593:
                return (Support.ㄺ.code,0)
            case 12609:
                return (Support.ㄻ.code,0)
            case 12610:
                return (Support.ㄼ.code,0)
            case 12613:
                return (Support.ㄽ.code,0)
            case 12620:
                return (Support.ㄾ.code,0)
            case 12621:
                return (Support.ㄿ.code,0)
            case 12622:
                return (Support.ㅀ.code,0)
            default:
                break
            }
        case Support.ㅂ.code:
            if consonant == 12613 {
                return (Support.ㅄ.code,0)
            }
        default:
            break
        }
        return (support, consonant)
    }
    
    private func combineSupportWithVowel(support:Int, vowel:Int) -> CombinedToPerfactCharOutput {
        let parsedVowel = vowel - 12623
        switch support {
        case Support.ㄳ.code:
            return (Support.ㄱ.code, makeWord(initial: Initial.ㅅ.code, neutral: parsedVowel, support: 0))
        case Support.ㄵ.code:
            return (Support.ㄴ.code, makeWord(initial: Initial.ㅈ.code, neutral: parsedVowel, support: 0))
        case Support.ㄶ.code:
            return (Support.ㄴ.code, makeWord(initial: Initial.ㅎ.code, neutral: parsedVowel, support: 0))
        case Support.ㄺ.code:
            return (Support.ㄹ.code, makeWord(initial: Initial.ㄱ.code, neutral: parsedVowel, support: 0))
        case Support.ㄻ.code:
            return (Support.ㄹ.code, makeWord(initial: Initial.ㅁ.code, neutral: parsedVowel, support: 0))
        case Support.ㄼ.code:
            return (Support.ㄹ.code, makeWord(initial: Initial.ㅂ.code, neutral: parsedVowel, support: 0))
        case Support.ㄽ.code:
            return (Support.ㄹ.code, makeWord(initial: Initial.ㅅ.code, neutral: parsedVowel, support: 0))
        case Support.ㄾ.code:
            return (Support.ㄹ.code, makeWord(initial: Initial.ㅌ.code, neutral: parsedVowel, support: 0))
        case Support.ㄿ.code:
            return (Support.ㄹ.code, makeWord(initial: Initial.ㅍ.code, neutral: parsedVowel, support: 0))
        case Support.ㅀ.code:
            return (Support.ㄹ.code, makeWord(initial: Initial.ㅎ.code, neutral: parsedVowel, support: 0))
        case Support.ㅄ.code:
            return (Support.ㅂ.code, makeWord(initial: Initial.ㅅ.code, neutral: parsedVowel, support: 0))
        default:
            return (0, makeWord(initial: Initial.parsingFromSupport(from: support), neutral: parsedVowel, support: 0))
        }
    }
}

//MARK: - 받침X + 입력값(글자)
extension FirstKeyBoardEngine {
    private func combineToPerfactCharNoSupport(lastUnicode:Int , initial:Int, neutral:Int, inputLetter:Int) -> String {
        if (inputLetter <= 12622 || [12600, 12611, 12617].contains(inputLetter)) {
            let resultUnicode = makeWord(initial: initial, neutral: neutral, support: Support.parsingFromConsonant(from: inputLetter))
            return makeCharFromUnicode(resultUnicode)
        } else {
            let parsedIntput = inputLetter - 12623
            switch (neutral, parsedIntput) {
            case (Neutral.ㅏ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makeWord(initial: initial, neutral: Neutral.ㅐ.code, support: 0))
            case (Neutral.ㅑ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makeWord(initial: initial, neutral: Neutral.ㅒ.code, support: 0))
            case (Neutral.ㅓ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makeWord(initial: initial, neutral: Neutral.ㅔ.code, support: 0))
            case (Neutral.ㅕ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makeWord(initial: initial, neutral: Neutral.ㅖ.code, support: 0))
            case (Neutral.ㅗ.code, Neutral.ㅏ.code):
                return makeCharFromUnicode(makeWord(initial: initial, neutral: Neutral.ㅘ.code, support: 0))
            case (Neutral.ㅗ.code, Neutral.ㅐ.code):
                return makeCharFromUnicode(makeWord(initial: initial, neutral: Neutral.ㅙ.code, support: 0))
            case (Neutral.ㅗ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makeWord(initial: initial, neutral: Neutral.ㅚ.code, support: 0))
            case (Neutral.ㅜ.code, Neutral.ㅓ.code):
                return makeCharFromUnicode(makeWord(initial: initial, neutral: Neutral.ㅝ.code, support: 0))
            case (Neutral.ㅜ.code, Neutral.ㅔ.code):
                return makeCharFromUnicode(makeWord(initial: initial, neutral: Neutral.ㅞ.code, support: 0))
            case (Neutral.ㅜ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makeWord(initial: initial, neutral: Neutral.ㅟ.code, support: 0))
            case (Neutral.ㅡ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makeWord(initial: initial, neutral: Neutral.ㅢ.code, support: 0))
            default:
                break
            }
            return makeCharFromUnicode(lastUnicode) + makeCharFromUnicode(inputLetter)
        }
    }
}

//MARK: - 자음 + 입력값(글자)
extension FirstKeyBoardEngine {
    private func combineToOnlyInitialChar(lastUnicode:Int, consonant:Int, inputLetter:Int) -> String {
        if (inputLetter <= 12622) {
            return makeCharFromUnicode(lastUnicode) + makeCharFromUnicode(inputLetter)
        } else {
            return makeCharFromUnicode(makeWord(initial: consonant, neutral: inputLetter, support: 0))
        }
    }
}

//MARK: - 모음 + 입력값(글자)
extension FirstKeyBoardEngine {
    private func combineToOnlyVowelChar(lastUnicode:Int, vowel:Int, inputLetter:Int) -> String {
        if (inputLetter > 12622) {
            let parsedIntput = inputLetter - 12623
            print(vowel, parsedIntput)
            switch (vowel, parsedIntput) {
            case (Neutral.ㅏ.code, Neutral.ㅣ.code):
                return "ㅐ"
            case (Neutral.ㅑ.code, Neutral.ㅣ.code):
                return "ㅒ"
            case (Neutral.ㅓ.code, Neutral.ㅣ.code):
                return "ㅔ"
            case (Neutral.ㅕ.code, Neutral.ㅣ.code):
                return "ㅖ"
            case (Neutral.ㅗ.code, Neutral.ㅏ.code):
                return "ㅘ"
            case (Neutral.ㅗ.code, Neutral.ㅐ.code):
                return "ㅙ"
            case (Neutral.ㅗ.code, Neutral.ㅣ.code):
                return "ㅚ"
            case (Neutral.ㅜ.code, Neutral.ㅓ.code):
                return "ㅝ"
            case (Neutral.ㅜ.code, Neutral.ㅔ.code):
                return "ㅞ"
            case (Neutral.ㅜ.code, Neutral.ㅣ.code):
                return "ㅟ"
            case (Neutral.ㅡ.code, Neutral.ㅣ.code):
                return "ㅢ"
            default:
                break
            }
        }
        return makeCharFromUnicode(lastUnicode) + makeCharFromUnicode(inputLetter)
    }
}
