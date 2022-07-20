//
//  HangeulCombineBuffer.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/20.
//

import Foundation

// MARK: - Variable

final class HangeulCombineBuffer {
    var choseongBuffer : [Hangeul]
    var jungseongBuffer : [Hangeul]
    var jongseongBuffer : [Hangeul]
    
    init() {
        choseongBuffer = []
        jungseongBuffer = []
        jongseongBuffer = []
    }
}

// MARK: Public Method

extension HangeulCombineBuffer {
    
    func append(_ currentCharacter: Hangeul?) {
        guard var currentCharacter = currentCharacter else {
            return
        }
        
        repeat {
            guard let position = currentCharacter.position.last else {
                return
            }

            switch position {
            case .choseong:
                self.choseongBuffer.append(currentCharacter)
            case .jungseong:
                self.jungseongBuffer.insert(currentCharacter, at: 0)
            case .jongseong:
                self.jongseongBuffer.insert(currentCharacter, at: 0)
            }
            
            guard let previousCharacter = currentCharacter.prev else {
                return
            }
            
            currentCharacter = previousCharacter
        } while currentCharacter.status != .finished && currentCharacter.unicode != nil
    }
}
