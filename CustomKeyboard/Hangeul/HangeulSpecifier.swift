//
//  HangeulSpecifier.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

// MARK: - Public Method

final class HangeulSpecifier {
    
    func specifyProperties(of currentCharacter: Hangeul, when inputMode: HangeulInputMode) {
        switch inputMode {
        case .space:
            specifyPropertiesInSpaceMode(currentCharacter)
        case .remove:
            specifyPropertiesInRemoveMode(currentCharacter)
        default:
            specifyPropertiesInAddMode(currentCharacter)
        }
    }
}

// MARK: - Private Method

// MARK: - called in specifyProperties

extension HangeulSpecifier {
    
    private func specifyPropertiesInSpaceMode(_ currentCharacter: Hangeul) {
        guard currentCharacter.canCombineWithPreviousCharacter() else {
            return
        }
        
        guard let previousCharacter = currentCharacter.prev else {
            return
        }
        
        previousCharacter.update(status: .finished)
    }
    
    private func specifyPropertiesInRemoveMode(_ currentCharacter: Hangeul) {
        if currentCharacter.status == .finished && currentCharacter.text != "Space" {
            currentCharacter.update(status: .ongoing)
            return
        }
    
        if currentCharacter.position.count > 1 {
            
            guard let previousCharacter = currentCharacter.prev else {
                return
            }
            
            previousCharacter.update(status: .ongoing)
            
            guard let firstPosition = currentCharacter.position.first else {
                return
            }
            
            currentCharacter.update(status: .ongoing, position: firstPosition)
        }
    }
    
    private func specifyPropertiesInAddMode(_ currentCharacter: Hangeul) {
        if currentCharacter.canCombineWithPreviousCharacter() {
            specifyPropertiesMoreThanOne(currentCharacter)
        } else {
            specifyPropertiesOnlyOne(currentCharacter)
        }
    }
}

// MARK: - called in specifyPropertiesInAddMode

extension HangeulSpecifier {
    
    private func specifyPropertiesMoreThanOne(_ currentCharacter: Hangeul) {
        guard let previousCharacter = currentCharacter.prev else {
            return
        }
        
        switch previousCharacter.position.last {
        case .choseong :
            if currentCharacter.canBeJungseong() {
                currentCharacter.update(position: .jungseong)
            } else {
                previousCharacter.update(status: .finished)
                currentCharacter.update(position: .choseong)
            }
        case .jungseong:
            if currentCharacter.canBeJungseong() {
                if previousCharacter.canBeTripleMid() {
                    currentCharacter.update(status: .finished, position: .jungseong)
                } else if currentCharacter.isDoubleMid() {
                    previousCharacter.update(status: .finished)
                    currentCharacter.update(status: .finished, position: .jungseong)
                } else if previousCharacter.canBeDoubleMid() {
                    currentCharacter.update(position: .jungseong)
                } else {
                    previousCharacter.update(status: .finished)
                    currentCharacter.update(position: .jungseong)
                }
            } else {
                if previousCharacter.canHaveEnd() && currentCharacter.canBeJongseong() {
                    currentCharacter.update(position: .jongseong)
                } else {
                    previousCharacter.update(status: .finished)
                    currentCharacter.update(position: .choseong)
                }
            }
        case .jongseong:
            if currentCharacter.canBeJungseong() {
                previousCharacter.prev?.update(status: .finished)
                previousCharacter.update(position: .choseong)
                currentCharacter.update(position: .jungseong)
            } else {
                if previousCharacter.canBeDoubleEnd() {
                    currentCharacter.update(position: .jongseong)
                } else {
                    previousCharacter.update(status: .finished)
                    currentCharacter.update(position: .choseong)
                }
            }
        default:
            break
        }
    }
    
    private func specifyPropertiesOnlyOne(_ currentCharacter: Hangeul) {
        
        if currentCharacter.canBeJungseong() {
            if currentCharacter.isDoubleMid() {
                currentCharacter.update(status: .finished, position: .jungseong)
            } else {
                currentCharacter.update(position: .jungseong)
            }
        } else {
            currentCharacter.update(position: .choseong)
        }
    }
    
}
