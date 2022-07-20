//
//  HangeulCombiner.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

// MARK: - Variable

final class HangeulCombiner {
    
    private var combinedString: String = Text.emptyString
    private var outputMode: HangeulOutputMode = .none

}

// MARK: - Public Method

extension HangeulCombiner {
    
    func setCombinedString(using currentCharacter: Hangeul, when inputMode: HangeulInputMode) {
        let buffer = HangeulCombineBuffer()
        buffer.append(currentCharacter)
        
        if buffer.choseongBuffer.isEmpty {
            if buffer.jungseongBuffer.count > 1 {
                combinedString = getCombinedString(with: buffer) ?? Text.emptyString
                outputMode = .change
            } else {
                guard let midFirstCharacter = buffer.jungseongBuffer.first else {
                    return
                }
                combinedString = getCombinedString(midFirstCharacter) ?? Text.emptyString
                outputMode = .add
            }
        } else if buffer.jungseongBuffer.isEmpty && buffer.jongseongBuffer.isEmpty {
            guard let topFirstCharacter = buffer.choseongBuffer.first else {
                return
            }
            combinedString = getCombinedString(topFirstCharacter) ?? Text.emptyString
            outputMode = .add
        } else if buffer.jongseongBuffer.isEmpty {
            let topFirstCharacterPositionList = buffer.choseongBuffer.first!.position
            if inputMode == .add && buffer.jungseongBuffer.count == 1 && topFirstCharacterPositionList.count > 1 {
                let previousBuffer = HangeulCombineBuffer()
                guard let previousCurrentCharacter = buffer.choseongBuffer.first?.prev else {
                    return
                }
                previousBuffer.append(previousCurrentCharacter)
                combinedString += getCombinedString(with: previousBuffer) ?? Text.emptyString
            }
            combinedString += getCombinedString(with: buffer) ?? Text.emptyString
            outputMode = .change
        } else {
            combinedString += getCombinedString(with: buffer) ?? Text.emptyString
            outputMode = .change
        }
    }
    
    func getCombinedString() -> String {
        return combinedString
    }
        
    func getOutputMode() -> HangeulOutputMode {
        return outputMode
    }
    
}

// MARK: - Private Method

extension HangeulCombiner {
    
    private func getCombinedString(_ onlyOneCharacter: Hangeul? = nil, with buffer: HangeulCombineBuffer? = nil) -> String? {
        let converter = HangeulConverter()
    
        if onlyOneCharacter != nil {
            return converter.toString(from: onlyOneCharacter?.unicode)
        }
        
        guard let buffer = buffer else {
            return nil
        }
        
        let dictionary = HangeulDictionary()
        
        if buffer.choseongBuffer.isEmpty {
            if buffer.jungseongBuffer.count == 2 {
                let doubleUnicode = dictionary.getDoubleUnicode(buffer.jungseongBuffer[0], buffer.jungseongBuffer[1])
                return converter.toString(from: doubleUnicode)
            } else if buffer.jungseongBuffer.count == 3 {
                let tripleUnicode = dictionary.getTripleMidUnicode(buffer.jungseongBuffer[0], buffer.jungseongBuffer[1], buffer.jungseongBuffer[2])
                return converter.toString(from: tripleUnicode)
            }
        }
        
        guard let index = getIndexArrayForCombine(with: buffer) else {
            return nil
        }
        let combineUnicode = (index.top * dictionary.jungseongTotalCount * dictionary.jongseongTotalCount) + (index.mid * dictionary.jongseongTotalCount) + index.end + dictionary.baseCode
        
        return converter.toString(from: combineUnicode)
    }
    
    
    private func getIndexArrayForCombine(with buffer: HangeulCombineBuffer) -> (top: Int, mid: Int, end: Int)? {
        let dictionary = HangeulDictionary()
        var midIndex = 0, endIndex = 0
        
        let topIndex = dictionary.getIndex(of: buffer.choseongBuffer.first!.unicode, in: .choseong, type: .fixed)
        
        if buffer.jungseongBuffer.count == 1 {
            guard let index = dictionary.getIndex(of: buffer.jungseongBuffer.first!.unicode, in: .jungseong, type: .fixed) else {
                return nil
            }
            midIndex = index
        } else if buffer.jungseongBuffer.count == 2 {
            let doubleMidUnicode = dictionary.getDoubleUnicode(buffer.jungseongBuffer.first!, buffer.jungseongBuffer.last!)
            guard let index = dictionary.getIndex(of: doubleMidUnicode, in: .jungseong, type: .fixed) else {
                return nil
            }
            midIndex = index
        } else if buffer.jungseongBuffer.count == 3 {
            let tripleUnicode = dictionary.getTripleMidUnicode(buffer.jungseongBuffer[0], buffer.jungseongBuffer[1], buffer.jungseongBuffer[2])
            guard let index = dictionary.getIndex(of: tripleUnicode, in: .jungseong, type: .fixed) else {
                return nil
            }
            midIndex = index
        }
        
        if buffer.jongseongBuffer.isEmpty {
            guard let index = dictionary.getIndex(of: HangeulDictionary.fixed.jongseong.blank.rawValue, in: .jongseong, type: .fixed) else {
                return nil
            }
            endIndex = index
        } else if buffer.jongseongBuffer.count == 1 {
            guard let index = dictionary.getIndex(of: buffer.jongseongBuffer.first?.unicode, in: .jongseong, type: .fixed) else {
                return nil
            }
            endIndex = index
        } else {
            let doubleEndUnicode = dictionary.getDoubleUnicode(buffer.jongseongBuffer.first!, buffer.jongseongBuffer.last!)
            guard let index = dictionary.getIndex(of: doubleEndUnicode, in: .jongseong, type: .fixed) else {
                return nil
            }
            endIndex = index
        }
        
        return (topIndex, midIndex, endIndex) as? (top: Int, mid: Int, end: Int)
    }
    
    
}
