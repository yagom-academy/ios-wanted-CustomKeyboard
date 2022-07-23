//
//  HangeulCombineBuffer.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/20.
//

import Foundation

// MARK: - Variable

final class HangeulCombineBuffer {
    var choseongSection = [Hangeul]()
    var jungseongSection = [Hangeul]()
    var jongseongSection = [Hangeul]()
    
    init(_ letter: Hangeul?) {
        guard var currentLetter = letter else {
            return
        }
        
        repeat {
            guard let currentLetterPosition = currentLetter.position.last else {
                return
            }

            switch currentLetterPosition {
            case .choseong:
                self.choseongSection.append(currentLetter)
            case .jungseong:
                self.jungseongSection.insert(currentLetter, at: 0)
            case .jongseong:
                self.jongseongSection.insert(currentLetter, at: 0)
            }
            
            guard let previousLetter = currentLetter.prev else {
                return
            }
            
            currentLetter = previousLetter
        } while currentLetter.status != .finished && currentLetter.unicode != nil
    }
}
