//
//  HangeulCombineBuffer.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/20.
//

import Foundation

// MARK: - Variable

final class HangeulCombineBuffer {
    var choseongSection : [Hangeul]
    var jungseongSection : [Hangeul]
    var jongseongSection : [Hangeul]
    
    init() {
        choseongSection = []
        jungseongSection = []
        jongseongSection = []
    }
}

// MARK: Public Method

extension HangeulCombineBuffer {
    
    func append(_ currentCharacter: Hangeul?) {
        guard var currentCharacter = currentCharacter else {
            return
        }
        
        repeat {
            guard let currentPosition = currentCharacter.position.last else {
                return
            }

            switch currentPosition {
            case .choseong:
                self.choseongSection.append(currentCharacter)
            case .jungseong:
                self.jungseongSection.insert(currentCharacter, at: 0)
            case .jongseong:
                self.jongseongSection.insert(currentCharacter, at: 0)
            }
            
            guard let previousCharacter = currentCharacter.prev else {
                return
            }
            
            currentCharacter = previousCharacter
        } while currentCharacter.status != .finished && currentCharacter.unicode != nil
    }
}
