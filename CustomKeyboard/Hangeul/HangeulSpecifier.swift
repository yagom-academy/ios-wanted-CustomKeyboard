//
//  HangeulSpecifier.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

final class HangeulSpecifier {
    
    func specify(_ currentCharacter: Hangeul, inputMode: HangeulInputMode) {
        switch inputMode {
        case .space:
            specifyInSpaceMode(currentCharacter)
        case .remove:
            specifyInRemoveMode(currentCharacter)
        default:
            specifyInAddMode(currentCharacter)
        }
    }
    
    private func specifyInSpaceMode(_ currentCharacter: Hangeul) {
        guard !currentCharacter.isAtStartingLine() else {
            return
        }
        
        currentCharacter.prev?.update(status: .finished)
    }
    
    private func specifyInRemoveMode(_ currentCharacter: Hangeul) {
        guard currentCharacter.status != .finished || currentCharacter.value == "Space" else {
            currentCharacter.update(status: .ongoing)
            return
        }
        
        if currentCharacter.position.count > 1 {
            currentCharacter.prev?.update(status: .ongoing)
            guard let firstPosition = currentCharacter.position.first else {
                return
            }
            
            currentCharacter.update(status: .ongoing, position: firstPosition)
        }
        
    }
    
    private func specifyInAddMode(_ currentCharacter: Hangeul) {
        if currentCharacter.isAtStartingLine() {
            if currentCharacter.isMid() {
                if currentCharacter.isDoubleMid() {
                    currentCharacter.update(status: .finished, position: .mid)
                } else {
                    currentCharacter.update(position: .mid)
                }
            } else {
                currentCharacter.update(position: .top)
            }
            return
        }
        
        let previousCharacter = currentCharacter.prev!
        
        switch previousCharacter.position.last {
        case .top :
            if currentCharacter.isMid() {
                currentCharacter.update(position: .mid)
            } else {
                previousCharacter.update(status: .finished)
                currentCharacter.update(position: .top)
            }
        case .mid:
            if currentCharacter.isMid() {
                if previousCharacter.canBeTripleMid() {
                    currentCharacter.update(status: .finished, position: .mid)
                } else if currentCharacter.isDoubleMid() {
                    previousCharacter.update(status: .finished)
                    currentCharacter.update(status: .finished, position: .mid)
                } else if previousCharacter.canBeDoubleMid() {
                    currentCharacter.update(position: .mid)
                } else {
                    previousCharacter.update(status: .finished)
                    currentCharacter.update(position: .mid)
                }
            } else {
                if previousCharacter.canHaveEnd() && currentCharacter.isEnd() {
                    currentCharacter.update(position: .end)
                } else {
                    previousCharacter.update(status: .finished)
                    currentCharacter.update(position: .top)
                }
            }
        case .end:
            if currentCharacter.isMid() {
                previousCharacter.prev?.update(status: .finished)
                previousCharacter.update(position: .top)
                currentCharacter.update(position: .mid)
            } else {
                if previousCharacter.canBeDoubleEnd() {
                    currentCharacter.update(position: .end)
                } else {
                    previousCharacter.update(status: .finished)
                    currentCharacter.update(position: .top)
                }
            }
        default:
            break
        }
    }
    
}
