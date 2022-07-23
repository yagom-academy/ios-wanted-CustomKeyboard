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

// MARK: - Public

extension HangeulDictionary {
    
    func getIndex(of unicode: Int?, in position: HangeulCombinationPosition, type unicodeType: HangeulUnicodeType) -> Int? {
        guard let unicode = unicode else {
            return nil
        }
        
        let allCases = getAllCases(of: unicodeType, in: position)
        let index = allCases.firstIndex(of: unicode)
        return index
    }
    
    func getUnicode(at index: Int, in position: HangeulCombinationPosition, of unicodeType: HangeulUnicodeType) -> Int? {
        let allCases = getAllCases(of: unicodeType, in: position)

        if (0...allCases.count).contains(index) {
            return allCases[index]
        }
        return nil
    }

    func getDoubleUnicode(_ previousLetter: Hangeul?, _ currentLetter: Hangeul?) -> Int? {
        guard let previousLetter = previousLetter,
              let currentLetter = currentLetter,
              let previousLetterPosition = previousLetter.position.last else {
            return nil
        }
        
        if previousLetterPosition == .jungseong {
            return getDoubleJungseongUnicode(previousLetter.text, currentLetter.text)
        } else if previousLetter.position.last == .jongseong {
            return getDoubleJongseongUnicode(previousLetter.text, currentLetter.text)
        }
        return nil
    }
    
    func getTripleMidUnicode(_ previousLetterText: String? = nil, _ currentLetterText: String, _ nextLetterText: String) -> Int? {
        let dictionary = HangeulUnicodeType.Fixed.jungseong.self
        
        switch (currentLetterText, nextLetterText) {
        case ("ㅜ", "ㅔ"):
            return dictionary.ㅞ.rawValue
        case ("ㅗ", "ㅐ"):
            return dictionary.ㅙ.rawValue
        default:
            break
        }
        
        guard let previousLetterText = previousLetterText else {
            return nil
        }

        switch (previousLetterText, currentLetterText, nextLetterText) {
        case ("ㅜ", "ㅓ", "ㅣ"):
            return dictionary.ㅞ.rawValue
        case ("ㅗ", "ㅏ", "ㅣ"):
            return dictionary.ㅙ.rawValue
        default:
            return nil
        }
    }
}

// MARK: - Private

// MARK: - called in getDoubleUnicode

extension HangeulDictionary {
    
    private func getDoubleJungseongUnicode(_ previousLetterText: String, _ currentLetterText: String) -> Int? {
        let dictionary = HangeulUnicodeType.Fixed.jungseong.self
        
        switch (previousLetterText, currentLetterText) {
        case ("ㅏ", "ㅣ"):
            return dictionary.ㅐ.rawValue
        case ("ㅑ", "ㅣ"):
            return dictionary.ㅒ.rawValue
        case ("ㅓ", "ㅣ"):
            return dictionary.ㅔ.rawValue
        case ("ㅕ", "ㅣ"):
            return dictionary.ㅖ.rawValue
        case ("ㅗ", "ㅏ"):
            return dictionary.ㅘ.rawValue
        case ("ㅗ", "ㅐ"):
            return dictionary.ㅙ.rawValue
        case ("ㅗ", "ㅣ"):
            return dictionary.ㅚ.rawValue
        case ("ㅜ", "ㅓ"):
            return dictionary.ㅝ.rawValue
        case ("ㅜ", "ㅔ"):
            return dictionary.ㅞ.rawValue
        case ("ㅜ", "ㅣ"):
            return dictionary.ㅟ.rawValue
        case ("ㅡ", "ㅣ"):
            return dictionary.ㅢ.rawValue
        case ("ㅠ", "ㅣ"):
            return dictionary.ㅝ.rawValue
        default:
            return nil
        }
    }
    
    private func getDoubleJongseongUnicode(_ previousLetterText: String, _ currentLetterText: String) -> Int? {
        let dictionary = HangeulUnicodeType.Fixed.jongseong.self
        
        switch (previousLetterText, currentLetterText) {
        case ("ㄱ", "ㅅ"):
            return dictionary.ㄱㅅ.rawValue
        case ("ㄴ", "ㅈ"):
            return dictionary.ㄴㅈ.rawValue
        case ("ㄴ", "ㅎ"):
            return dictionary.ㄴㅎ.rawValue
        case ("ㄹ", "ㄱ"):
            return dictionary.ㄹㄱ.rawValue
        case ("ㄹ", "ㅁ"):
            return dictionary.ㄹㅁ.rawValue
        case ("ㄹ", "ㅂ"):
            return dictionary.ㄹㅂ.rawValue
        case ("ㄹ", "ㅅ"):
            return dictionary.ㄹㅅ.rawValue
        case ("ㄹ", "ㅌ"):
            return dictionary.ㄹㅌ.rawValue
        case ("ㄹ", "ㅍ"):
            return dictionary.ㄹㅍ.rawValue
        case ("ㄹ", "ㅎ"):
            return dictionary.ㄹㅎ.rawValue
        case ("ㅂ", "ㅅ"):
            return dictionary.ㅂㅅ.rawValue
        default:
            return nil
        }
    }
    
    func getAllCases(of unicodeType: HangeulUnicodeType, in position: HangeulCombinationPosition) -> Array<Int> {
        if unicodeType == .compatible {
            switch position {
            case .choseong:
                return HangeulUnicodeType.Compatible.choseong.allCases.map {$0.rawValue}
            case .jungseong:
                return HangeulUnicodeType.Compatible.jungseong.allCases.map {$0.rawValue}
            case .jongseong:
                return HangeulUnicodeType.Compatible.jongseong.allCases.map {$0.rawValue}
            }
        } else {
            switch position {
            case .choseong:
                return HangeulUnicodeType.Fixed.choseong.allCases.map {$0.rawValue}
            case .jungseong:
                return HangeulUnicodeType.Fixed.jungseong.allCases.map {$0.rawValue}
            case .jongseong:
                return HangeulUnicodeType.Fixed.jongseong.allCases.map {$0.rawValue}
            }
        }
    }
}


