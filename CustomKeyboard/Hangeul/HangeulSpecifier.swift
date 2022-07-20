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
        if currentCharacter.canCombineWithPreviousCharacter() == false {
            return
        }
        
        guard let previousCharacter = currentCharacter.prev else {
            return
        }
        
        previousCharacter.update(status: .finished)
    }
    
    private func specifyPropertiesInRemoveMode(_ currentCharacter: Hangeul) {
        if currentCharacter.status == .finished && currentCharacter.text != Text.space {
            currentCharacter.update(status: .ongoing)
            return
        }
    
        if currentCharacter.position.count > 1 {
            guard let previousCharacter = currentCharacter.prev,
                  let firstPosition = currentCharacter.position.first else {
                return
            }
            
            previousCharacter.update(status: .ongoing)
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
        guard let previousCharacterPosition = currentCharacter.prev?.position.last else {
            return
        }
        
        switch previousCharacterPosition {
        case .choseong :
            specifyPropertiesWhenPreviousIsChoseong(currentCharacter)
        case .jungseong:
            specifyPropertiesWhenPreviousIsJungseong(currentCharacter)
        case .jongseong:
            specifyPropertiesWhenPreviousIsJongseong(currentCharacter)
        }
    }
    
    private func specifyPropertiesOnlyOne(_ currentCharacter: Hangeul) {
        if currentCharacter.isDoubleJungseong() {
            currentCharacter.update(status: .finished, position: .jungseong)
        } else if currentCharacter.canBeJungseong() {
            currentCharacter.update(position: .jungseong)
        } else {
            currentCharacter.update(position: .choseong)
        }
    }
}

// MARK: - called in specifyPropertiesMoreThanOne

extension HangeulSpecifier {
    
    private func specifyPropertiesWhenPreviousIsChoseong(_ currentCharacter: Hangeul) {
        guard let previousCharacter = currentCharacter.prev else {
            return
        }
        
        if currentCharacter.canBeJungseong() {
            currentCharacter.update(position: .jungseong)
        } else {
            previousCharacter.update(status: .finished)
            currentCharacter.update(position: .choseong)
        }
    }
    
    private func specifyPropertiesWhenPreviousIsJungseong(_ currentCharacter: Hangeul) {
        guard let previousCharacter = currentCharacter.prev else {
            return
        }
        
        if currentCharacter.canBeTripleJungseong() {
            currentCharacter.update(status: .finished, position: .jungseong)
        } else if currentCharacter.isDoubleJungseong() {
            previousCharacter.update(status: .finished)
            currentCharacter.update(status: .finished, position: .jungseong)
        } else if previousCharacter.canBeDoubleJungseong() {
            currentCharacter.update(position: .jungseong)
        } else if currentCharacter.canBeJungseong() {
            previousCharacter.update(status: .finished)
            currentCharacter.update(position: .jungseong)
        } else if previousCharacter.canHaveJongseong() && currentCharacter.canBeJongseong() {
            currentCharacter.update(position: .jongseong)
        } else {
            previousCharacter.update(status: .finished)
            currentCharacter.update(position: .choseong)
        }
    }
    
    private func specifyPropertiesWhenPreviousIsJongseong(_ currentCharacter: Hangeul) {
        guard let previousCharacter = currentCharacter.prev,
              let mostPreviousCharacter = previousCharacter.prev else {
            return
        }
        
        if currentCharacter.canBeJungseong() {
            mostPreviousCharacter.update(status: .finished)
            previousCharacter.update(position: .choseong)
            currentCharacter.update(position: .jungseong)
        } else if previousCharacter.canBeDoubleJongseong() {
            currentCharacter.update(position: .jongseong)
        } else {
            previousCharacter.update(status: .finished)
            currentCharacter.update(position: .choseong)
        }
    }
}
