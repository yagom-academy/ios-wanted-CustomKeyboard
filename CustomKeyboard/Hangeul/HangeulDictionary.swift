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
        
        if unicodeType == .fixed {
            return getIndexOfFixed(unicode, in: position)
        }
        return getIndexOfCompatible(unicode, in: position)
    }
    
    func getUnicode(at index: Int, in position: HangeulCombinationPosition, of unicodeType: HangeulUnicodeType) -> Int? {
        if unicodeType == .fixed {
            return getUnicodeOfFixed(index, in: position)
        }
        return getUnicodeOfCompatible(index, in: position)
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

// MARK: - called in getIndex

extension HangeulDictionary {
    
    private func getIndexOfCompatible(_ compatibleUnicode: Int, in position: HangeulCombinationPosition) -> Int? {
        var index = 0
        
        switch position {
        case .choseong:
            for hangeul in HangeulUnicodeType.Compatible.choseong.allCases {
                if hangeul.rawValue == compatibleUnicode {
                    return index
                }
                index += 1
            }
        case .jungseong:
            for hangeul in HangeulUnicodeType.Compatible.jungseong.allCases {
                if hangeul.rawValue == compatibleUnicode {
                    return index
                }
                index += 1
            }
        case .jongseong:
            for hangeul in HangeulUnicodeType.Compatible.jongseong.allCases {
                if hangeul.rawValue == compatibleUnicode {
                    return index
                }
                index += 1
            }
        }
        return nil
    }
    
    private func getIndexOfFixed(_ fixedUnicode: Int, in position: HangeulCombinationPosition) -> Int? {
        var index = 0
        
        switch position {
        case .choseong:
            for hangeul in HangeulUnicodeType.Fixed.choseong.allCases {
                if hangeul.rawValue == fixedUnicode {
                    return index
                }
                index += 1
            }
        case .jungseong:
            for hangeul in HangeulUnicodeType.Fixed.jungseong.allCases {
                if hangeul.rawValue == fixedUnicode {
                    return index
                }
                index += 1
            }
        case .jongseong:
            for hangeul in HangeulUnicodeType.Fixed.jongseong.allCases {
                if hangeul.rawValue == fixedUnicode {
                    return index
                }
                index += 1
            }
        }
        return nil
    }
}


// MARK: - called in getUnicode

extension HangeulDictionary {
    
    private func getUnicodeOfCompatible(_ compatibleIndex: Int, in position: HangeulCombinationPosition) -> Int? {
        var count = 0
        
        switch position {
        case .choseong:
            for hangeul in HangeulUnicodeType.Compatible.choseong.allCases {
                if count == compatibleIndex {
                    return hangeul.rawValue
                }
                count += 1
            }
        case .jungseong:
            for hangeul in HangeulUnicodeType.Compatible.jungseong.allCases {
                if count == compatibleIndex {
                    return hangeul.rawValue
                }
                count += 1
            }
        case .jongseong:
            for hangeul in HangeulUnicodeType.Compatible.jongseong.allCases {
                if count == compatibleIndex {
                    return hangeul.rawValue
                }
                count += 1
            }
        }
        return nil
    }
    
    private func getUnicodeOfFixed(_ fixedIndex: Int, in position: HangeulCombinationPosition) -> Int? {
        var count = 0
        
        switch position {
        case .choseong:
            for hangeul in HangeulUnicodeType.Fixed.choseong.allCases {
                if count == fixedIndex {
                    return hangeul.rawValue
                }
                count += 1
            }
        case .jungseong:
            for hangeul in HangeulUnicodeType.Fixed.jungseong.allCases {
                if count == fixedIndex {
                    return hangeul.rawValue
                }
                count += 1
            }
        case .jongseong:
            for hangeul in HangeulUnicodeType.Fixed.jongseong.allCases {
                if count == fixedIndex {
                    return hangeul.rawValue
                }
                count += 1
            }
        }
        return nil
    }
}

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
    
    private func getAllCases(of unicodeType: HangeulUnicodeType, in position: HangeulCombinationPosition) -> Any {
        if unicodeType == .compatible {
            switch position {
            case .choseong:
                return HangeulUnicodeType.Compatible.choseong.allCases
            case .jungseong:
                return HangeulUnicodeType.Compatible.jungseong.allCases
            case .jongseong:
                return HangeulUnicodeType.Compatible.jongseong.allCases
            }
        } else {
            switch position {
            case .choseong:
                return HangeulUnicodeType.Fixed.choseong.allCases
            case .jungseong:
                return HangeulUnicodeType.Fixed.jungseong.allCases
            case .jongseong:
                return HangeulUnicodeType.Fixed.jongseong.allCases
            }
        }
    }
}


