//
//  KeyBoardEngine.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/14.
//

import Foundation
import UIKit

struct KeyBoardEngine: KeyBoardEngineProtocol {
    
    enum SeparatedUnicode {
        case perfect(initial:Int, neutral:Int, support:Int)
        case perfectNoSupport(initial:Int, neutral:Int)
        case onlyConsonant(consonant:Int)
        case onlyVowel(vowel:Int)
    }
    
    func addWord(inputUniCode:Int, lastUniCode:Int) -> String {
        
        let parsedLastUnicode: SeparatedUnicode = SeparatingUnicode(unicode: lastUniCode)
        
        switch parsedLastUnicode {
        case .perfect(let initial, let neutral, let support):
            return combineToPerfactChar(initial:initial, neutral: neutral, support: support, inputLetter: inputUniCode)
        case .perfectNoSupport(let initial, let neutral):
            return combineToPerfactCharNoSupport(lastUnicode: lastUniCode, initial: initial, neutral: neutral, inputLetter: inputUniCode)
        case .onlyConsonant(let consonant):
            return combineToOnlyConsonantChar(lastUnicode: lastUniCode, consonant: consonant, inputLetter: inputUniCode)
        case .onlyVowel(let vowel):
            return combineToOnlyVowelChar(lastUnicode: lastUniCode, vowel: vowel, inputLetter: inputUniCode)
        }
    }
    
    func removeWord(lastUniCode:Int) -> String {
        
        let parsedLastUnicode: SeparatedUnicode = SeparatingUnicode(unicode: lastUniCode)
        
        switch parsedLastUnicode {
        case .perfect(let initial, let neutral, let support):
            return removeFromPerfactChar(initial: initial, neutral: neutral, support: support)
        case .perfectNoSupport(let initial, let neutral):
            return removeFromPerfactCharNoSupport(initial: initial, neutral: neutral)
        case .onlyConsonant(let consonant):
            return removeFromOnlyConsonantChar(consonant: consonant)
        case .onlyVowel(let vowel):
            return removeFromOnlyVowelChar(vowel: vowel)
        }
    }
}

//MARK: - 기본Tool 메서드: 1.유니코드를 분리, 2.결합, 3.Int->String, 4.String->Int 메서드
extension KeyBoardEngine {
    private func SeparatingUnicode(unicode:Int) -> SeparatedUnicode {
        
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
        } else if (unicode <= CharUnicode.ㅎ.code) {
            return .onlyConsonant(consonant: Initial.parsingFromConsonant(from: unicode))
        } else {
            return .onlyVowel(vowel: Neutral.parsingFromVowel(from: unicode))
        }
    }
    
    private func makePerfectCharUnicode(initial:Int, neutral:Int, support:Int) -> Int {
        
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

//MARK: - Add: 받침o + 입력값(글자)
extension KeyBoardEngine {
    typealias CombinedToPerfactCharOutput = (support:Int, secondCharUnicode:Int)
    
    private func combineToPerfactChar(initial:Int, neutral:Int, support:Int, inputLetter:Int) -> String {
        
        var combinedData: CombinedToPerfactCharOutput
        
        if (inputLetter <= CharUnicode.ㅎ.code) {
            combinedData = combineSupportWithConsonant(support: support, consonant: inputLetter)
        } else {
            combinedData = combineSupportWithVowel(support: support, vowel: inputLetter)
        }
        
        let firstChar = makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: neutral, support: combinedData.support))
        let secondChar = combinedData.secondCharUnicode == 0 ? "" : makeCharFromUnicode(combinedData.secondCharUnicode)
        return firstChar + secondChar
    }
    
    private func combineSupportWithConsonant(support:Int, consonant:Int) -> CombinedToPerfactCharOutput {
        
        switch support {
        case Support.ㄱ.code:
            if consonant == CharUnicode.ㅅ.code {
                return (Support.ㄳ.code,0)
            }
        case Support.ㄴ.code:
            if consonant == CharUnicode.ㅈ.code {
                return (Support.ㄵ.code,0)
            } else if consonant == CharUnicode.ㅎ.code {
                return (Support.ㄶ.code,0)
            }
            break
        case Support.ㄹ.code:
            switch consonant {
            case CharUnicode.ㄱ.code:
                return (Support.ㄺ.code,0)
            case CharUnicode.ㅁ.code:
                return (Support.ㄻ.code,0)
            case CharUnicode.ㅂ.code:
                return (Support.ㄼ.code,0)
            case CharUnicode.ㅅ.code:
                return (Support.ㄽ.code,0)
            case CharUnicode.ㅌ.code:
                return (Support.ㄾ.code,0)
            case CharUnicode.ㅍ.code:
                return (Support.ㄿ.code,0)
            case CharUnicode.ㅎ.code:
                return (Support.ㅀ.code,0)
            default:
                break
            }
        case Support.ㅂ.code:
            if consonant == CharUnicode.ㅅ.code {
                return (Support.ㅄ.code,0)
            }
        default:
            break
        }
        return (support, consonant)
    }
    
    private func combineSupportWithVowel(support:Int, vowel:Int) -> CombinedToPerfactCharOutput {
        
        let parsedVowel = Neutral.parsingFromVowel(from: vowel)
        
        switch support {
        case Support.ㄳ.code:
            return (Support.ㄱ.code, makePerfectCharUnicode(initial: Initial.ㅅ.code, neutral: parsedVowel, support: 0))
        case Support.ㄵ.code:
            return (Support.ㄴ.code, makePerfectCharUnicode(initial: Initial.ㅈ.code, neutral: parsedVowel, support: 0))
        case Support.ㄶ.code:
            return (Support.ㄴ.code, makePerfectCharUnicode(initial: Initial.ㅎ.code, neutral: parsedVowel, support: 0))
        case Support.ㄺ.code:
            return (Support.ㄹ.code, makePerfectCharUnicode(initial: Initial.ㄱ.code, neutral: parsedVowel, support: 0))
        case Support.ㄻ.code:
            return (Support.ㄹ.code, makePerfectCharUnicode(initial: Initial.ㅁ.code, neutral: parsedVowel, support: 0))
        case Support.ㄼ.code:
            return (Support.ㄹ.code, makePerfectCharUnicode(initial: Initial.ㅂ.code, neutral: parsedVowel, support: 0))
        case Support.ㄽ.code:
            return (Support.ㄹ.code, makePerfectCharUnicode(initial: Initial.ㅅ.code, neutral: parsedVowel, support: 0))
        case Support.ㄾ.code:
            return (Support.ㄹ.code, makePerfectCharUnicode(initial: Initial.ㅌ.code, neutral: parsedVowel, support: 0))
        case Support.ㄿ.code:
            return (Support.ㄹ.code, makePerfectCharUnicode(initial: Initial.ㅍ.code, neutral: parsedVowel, support: 0))
        case Support.ㅀ.code:
            return (Support.ㄹ.code, makePerfectCharUnicode(initial: Initial.ㅎ.code, neutral: parsedVowel, support: 0))
        case Support.ㅄ.code:
            return (Support.ㅂ.code, makePerfectCharUnicode(initial: Initial.ㅅ.code, neutral: parsedVowel, support: 0))
        default:
            return (0, makePerfectCharUnicode(initial: Initial.parsingFromSupport(from: support), neutral: parsedVowel, support: 0))
        }
    }
}

//MARK: - Add: 받침x + 입력값(글자)
extension KeyBoardEngine {
    private func combineToPerfactCharNoSupport(lastUnicode:Int , initial:Int, neutral:Int, inputLetter:Int) -> String {
        
        if (inputLetter <= CharUnicode.ㅎ.code) {
            if ([CharUnicode.ㄸ.code, CharUnicode.ㅃ.code, CharUnicode.ㅉ.code].contains(inputLetter)) {
                return makeCharFromUnicode(lastUnicode) + makeCharFromUnicode(inputLetter)
            }
            
            let resultUnicode = makePerfectCharUnicode(initial: initial, neutral: neutral, support: Support.parsingFromConsonant(from: inputLetter))
            return makeCharFromUnicode(resultUnicode)
        } else {
            let parsedIntput = Neutral.parsingFromVowel(from: inputLetter)
            switch (neutral, parsedIntput) {
            case (Neutral.ㅏ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅐ.code, support: 0))
            case (Neutral.ㅑ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅒ.code, support: 0))
            case (Neutral.ㅓ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅔ.code, support: 0))
            case (Neutral.ㅕ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅖ.code, support: 0))
            case (Neutral.ㅗ.code, Neutral.ㅏ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅘ.code, support: 0))
            case (Neutral.ㅗ.code, Neutral.ㅐ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅙ.code, support: 0))
            case (Neutral.ㅗ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅚ.code, support: 0))
            case (Neutral.ㅜ.code, Neutral.ㅓ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅝ.code, support: 0))
            case (Neutral.ㅜ.code, Neutral.ㅔ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅞ.code, support: 0))
            case (Neutral.ㅜ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅟ.code, support: 0))
            case (Neutral.ㅡ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅢ.code, support: 0))
            case (Neutral.ㅝ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅞ.code, support: 0))
            case (Neutral.ㅘ.code, Neutral.ㅣ.code):
                return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅙ.code, support: 0))
            default:
                break
            }
            return makeCharFromUnicode(lastUnicode) + makeCharFromUnicode(inputLetter)
        }
    }
}

//MARK: - Add: only자음 + 입력값(글자)
extension KeyBoardEngine {
    private func combineToOnlyConsonantChar(lastUnicode:Int, consonant:Int, inputLetter:Int) -> String {
        
        if (inputLetter <= CharUnicode.ㅎ.code) {
            let parsedInputLetter = Initial.parsingFromConsonant(from: inputLetter)
            
            switch (consonant, parsedInputLetter) {
            case (Initial.ㅂ.code,Initial.ㅂ.code):
                return "ㅃ"
            case (Initial.ㅈ.code,Initial.ㅈ.code):
                return "ㅉ"
            case (Initial.ㄷ.code,Initial.ㄷ.code):
                return "ㄸ"
            case (Initial.ㄱ.code,Initial.ㄱ.code):
                return "ㄲ"
            case (Initial.ㅅ.code,Initial.ㅅ.code):
                return "ㅆ"
            default:
                break
            }
            return makeCharFromUnicode(lastUnicode) + makeCharFromUnicode(inputLetter)
        } else {
            return makeCharFromUnicode(makePerfectCharUnicode(initial: consonant, neutral: Neutral.parsingFromVowel(from: inputLetter), support: 0))
        }
    }
}

//MARK: - Add: only모음 + 입력값(글자)
extension KeyBoardEngine {
    private func combineToOnlyVowelChar(lastUnicode:Int, vowel:Int, inputLetter:Int) -> String {
        
        if (inputLetter > CharUnicode.ㅎ.code) {
            let parsedIntput = Neutral.parsingFromVowel(from: inputLetter)
            
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
            case (Neutral.ㅝ.code, Neutral.ㅣ.code):
                return "ㅞ"
            case (Neutral.ㅘ.code, Neutral.ㅣ.code):
                return "ㅙ"
            default:
                break
            }
        }
        return makeCharFromUnicode(lastUnicode) + makeCharFromUnicode(inputLetter)
    }
}

//MARK: - Remove: 받침o
extension KeyBoardEngine {
    private func removeFromPerfactChar(initial:Int, neutral:Int, support:Int) -> String {
        
        var parsedSupport:Int
        
        switch support {
        case Support.ㄳ.code:
            parsedSupport = Support.ㄱ.code
        case Support.ㄵ.code, Support.ㄶ.code:
            parsedSupport = Support.ㄴ.code
        case Support.ㄺ.code, Support.ㄻ.code, Support.ㄼ.code, Support.ㄽ.code, Support.ㄾ.code, Support.ㄿ.code, Support.ㅀ.code:
            parsedSupport = Support.ㄹ.code
        case Support.ㅄ.code:
            parsedSupport = Support.ㅂ.code
        default:
            parsedSupport = 0
        }
        return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: neutral, support: parsedSupport))
    }
}

//MARK: - Remove: 받침x
extension KeyBoardEngine {
    private func removeFromPerfactCharNoSupport(initial:Int, neutral:Int) -> String {

        switch neutral {
        case Neutral.ㅘ.code, Neutral.ㅙ.code, Neutral.ㅚ.code:
            return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅗ.code, support: 0))
        case Neutral.ㅝ.code, Neutral.ㅞ.code, Neutral.ㅟ.code:
            return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅜ.code, support: 0))
        case Neutral.ㅢ.code:
            return makeCharFromUnicode(makePerfectCharUnicode(initial: initial, neutral: Neutral.ㅡ.code, support: 0))
        default:
            return makeCharFromUnicode(CharUnicode.parsingFromInitial(from: initial))
        }
    }
}

//MARK: - Remove: only자음
extension KeyBoardEngine {
    private func removeFromOnlyConsonantChar(consonant:Int) -> String {
        
        return ""
    }
}

//MARK: - Remove: only모음
extension KeyBoardEngine {
    private func removeFromOnlyVowelChar(vowel:Int) -> String {
        
        switch vowel {
        case Neutral.ㅘ.code, Neutral.ㅙ.code, Neutral.ㅚ.code:
            return makeCharFromUnicode(CharUnicode.parsingFromNeutral(from: Neutral.ㅗ.code))
        case Neutral.ㅝ.code, Neutral.ㅞ.code, Neutral.ㅟ.code:
            return makeCharFromUnicode(CharUnicode.parsingFromNeutral(from: Neutral.ㅜ.code))
        case Neutral.ㅢ.code:
            return makeCharFromUnicode(CharUnicode.parsingFromNeutral(from: Neutral.ㅡ.code))
        default:
            return ""
        }
    }
}
