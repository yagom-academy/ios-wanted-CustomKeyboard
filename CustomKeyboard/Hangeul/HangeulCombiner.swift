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

// MARK: - Public Method

extension HangeulCombiner {
    
    func combineCharacter(using letter: Hangeul, when inputMode: HangeulInputMode) -> (combinedCharacter: String?, outputEditMode: HangeulOutputEditMode)? {
        let buffer = HangeulCombineBuffer(letter)
        
        if buffer.choseongSection.isEmpty && buffer.jungseongSection.count == 1 {
            return (getCombinedCharacter(buffer.jungseongSection.first), .add)
        } else if buffer.jungseongSection.isEmpty && buffer.jongseongSection.isEmpty  {
            return (getCombinedCharacter(buffer.choseongSection.first), .add)
        } else if inputMode == .add
                    && buffer.jongseongSection.isEmpty
                    && buffer.jungseongSection.count == 1
                    && buffer.choseongSection.first?.position.count ?? 0 > 1 {
            let previousBuffer = HangeulCombineBuffer(buffer.choseongSection.first?.prev)
            guard let previousCombinedCharacter = getCombinedCharacter(with: previousBuffer),
                  let currentCombinedCharacter = getCombinedCharacter(with: buffer) else {
                return nil
            }
            let combinedCharacter = previousCombinedCharacter + currentCombinedCharacter
            return (combinedCharacter, .change)
        } else {
            return (getCombinedCharacter(with: buffer), .change)
        }
    }
}

// MARK: - Private Method

extension HangeulCombiner {
    
    private func getCombinedCharacter(_ letter: Hangeul? = nil, with buffer: HangeulCombineBuffer? = nil) -> String? {
        if letter != nil {
            return converter.toString(from: letter?.unicode)
        }
        
        guard let buffer = buffer else {
            return nil
        }
        
        if buffer.choseongSection.isEmpty && buffer.jungseongSection.count > 1 {
            let letterUnicode = getLetterUnicode(of: buffer.choseongSection, using: buffer.jungseongSection, in: .choseong)
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
    
    private func getLetterUnicode(of section: [Hangeul], using jungseongSection: [Hangeul]? = nil, in position: HangeulCombinationPosition) -> Int? {
        switch section.count {
        case 0 where position == .jongseong:
            return HangeulDictionary.fixed.jongseong.blank.rawValue
        case 0 where position == .choseong && jungseongSection?.count == 2:
            return dictionary.getDoubleUnicode(jungseongSection?[0], jungseongSection?[1])
        case 0 where position == .choseong && jungseongSection?.count == 3:
            guard let jungseongSection = jungseongSection else {
                return nil
            }
            return dictionary.getTripleMidUnicode(jungseongSection[0].text, jungseongSection[1].text, jungseongSection[2].text)
        case 1:
            return section.first?.unicode
        case 2:
            return dictionary.getDoubleUnicode(section.first, section.last)
        case 3:
            return dictionary.getTripleMidUnicode(section[0].text, section[1].text, section[2].text)
        default:
            return nil
        }
    }
    
    private func getIndexForCombine(of section: [Hangeul], in position: HangeulCombinationPosition) -> Int? {
        let letterUnicode = getLetterUnicode(of: section, in: position)
        
        return dictionary.getIndex(of: letterUnicode, in: position, type: .fixed)
    }
    
}
