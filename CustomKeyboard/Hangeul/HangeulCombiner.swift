//
//  HangeulCombiner.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

// MARK: - Variable

final class HangeulCombiner {
    private let converter = HangeulConverter()
    private let dictionary = HangeulDictionary()
}

// MARK: - Enum

extension HangeulCombiner {
    private enum BufferStatus {
        case onlyHaveOneJungseongLetter
        case onlyHaveOneChoseongLetter
        case HaveOneChoseongWhichWasJongseong
        case HaveNormalLetters
    }
}

// MARK: - Public

extension HangeulCombiner {
    
    func combineCharacter(using letter: Hangeul, when inputMode: HangeulInputMode) -> (combinedCharacter: String?, outputEditMode: HangeulOutputEditMode)? {
        let buffer = HangeulCombineBuffer(letter)
        let bufferStatus = getStatus(of: buffer, in: inputMode)
        
        switch bufferStatus {
        case .onlyHaveOneChoseongLetter:
            return (getCombinedCharacter(buffer.choseongSection.first), .add)
        case .onlyHaveOneJungseongLetter:
            return (getCombinedCharacter(buffer.jungseongSection.first), .add)
        case .HaveOneChoseongWhichWasJongseong:
            let previousBuffer = HangeulCombineBuffer(buffer.choseongSection.first?.prev)
            guard let previousCombinedCharacter = getCombinedCharacter(with: previousBuffer),
                  let currentCombinedCharacter = getCombinedCharacter(with: buffer) else {
                return nil
            }
            let combinedCharacter = previousCombinedCharacter + currentCombinedCharacter
            return (combinedCharacter, .change)
        case .HaveNormalLetters:
            return (getCombinedCharacter(with: buffer), .change)
        }
    }
}

// MARK: - Private

extension HangeulCombiner {
    
    private func getCombinedCharacter(_ letter: Hangeul? = nil, with buffer: HangeulCombineBuffer? = nil) -> String? {
        if letter != nil {
            return converter.toString(from: letter?.unicode)
        }
        
        guard let buffer = buffer else {
            return nil
        }
        
        if buffer.choseongSection.isEmpty && buffer.jungseongSection.count > 1 {
            let letterUnicode = getLetterUnicode(of: buffer.jungseongSection, in: .choseong)
            return converter.toString(from: letterUnicode)
        }
        
        let combinedUnicode = getCombinedUnicode(with: buffer)
        return converter.toString(from: combinedUnicode)
    }
    
    
    private func getCombinedUnicode(with buffer: HangeulCombineBuffer) -> Int? {
        guard let choseongIndex = getIndexForCombine(of: buffer.choseongSection, in: .choseong),
              let jungseongIndex = getIndexForCombine(of: buffer.jungseongSection, in: .jungseong),
              let jongseongIndex = getIndexForCombine(of: buffer.jongseongSection, in: .jongseong) else {
            return nil
        }
              
        let combinedUnicode = (choseongIndex * dictionary.jungseongTotalCount * dictionary.jongseongTotalCount) + (jungseongIndex * dictionary.jongseongTotalCount) + jongseongIndex + dictionary.baseCode
            
        return combinedUnicode
    }
    
    private func getLetterUnicode(of section: [Hangeul], in position: HangeulCombinationPosition) -> Int? {
        if section.count == 0 && position == .jongseong {
            return HangeulUnicodeType.Fixed.jongseong.blank.rawValue
        } else if section.count == 1 {
            return section.first?.unicode
        } else if section.count == 2 {
            return dictionary.getDoubleUnicode(section.first, section.last)
        } else if section.count == 3 {
            return dictionary.getTripleMidUnicode(section[0].text, section[1].text, section[2].text)
        }
        return nil
    }
    
    private func getIndexForCombine(of section: [Hangeul], in position: HangeulCombinationPosition) -> Int? {
        let letterUnicode = getLetterUnicode(of: section, in: position)
        
        return dictionary.getIndex(of: letterUnicode, in: position, type: .fixed)
    }
}

extension HangeulCombiner {
    
    private func getStatus(of buffer: HangeulCombineBuffer, in inputMode: HangeulInputMode) -> BufferStatus {
        if buffer.choseongSection.isEmpty && buffer.jungseongSection.count == 1 {
            return .onlyHaveOneJungseongLetter
        } else if buffer.jungseongSection.isEmpty && buffer.jongseongSection.isEmpty  {
            return .onlyHaveOneChoseongLetter
        } else if inputMode == .add
                    && buffer.jongseongSection.isEmpty
                    && buffer.jungseongSection.count == 1
                    && buffer.choseongSection.first?.position.count ?? 0 > 1 {
            return .HaveOneChoseongWhichWasJongseong
        } else {
            return .HaveNormalLetters
        }
    }
}
