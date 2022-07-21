//
//  HangeulSpecifier.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

// MARK: - Public Method

final class HangeulUpdater {
    
    func updateProperties(of letter: Hangeul, when inputMode: HangeulInputMode) {
        switch inputMode {
        case .space:
            updatePropertiesInSpaceMode(letter)
        case .remove:
            updatePropertiesInRemoveMode(letter)
        default:
            updatePropertiesInAddMode(letter)
        }
    }
}


// MARK: - Private Method

// MARK: - called in specifyProperties

extension HangeulUpdater {
    
    private func updatePropertiesInSpaceMode(_ letter: Hangeul) {
        if letter.canCombineWithPreviousLetter() == false {
            return
        }
        
        guard let previousLetter = letter.prev else {
            return
        }
        
        previousLetter.update(status: .finished)
    }
    
    private func updatePropertiesInRemoveMode(_ letter: Hangeul) {
        if letter.status == .finished && letter.text != Text.space {
            letter.update(status: .ongoing)
            return
        }
    
        if letter.position.count > 1 {
            guard let previousLetter = letter.prev,
                  let firstPositionOfLetter = letter.position.first else {
                return
            }
            
            previousLetter.update(status: .ongoing)
            letter.update(status: .ongoing, position: firstPositionOfLetter)
        }
    }
    
    private func updatePropertiesInAddMode(_ letter: Hangeul) {
        if letter.canCombineWithPreviousLetter() {
            updatePropertiesMoreThanOne(letter)
        } else {
            updatePropertiesOnlyOne(letter)
        }
    }
}

// MARK: - called in specifyPropertiesInAddMode

extension HangeulUpdater {
    
    private func updatePropertiesMoreThanOne(_ letter: Hangeul) {
        guard let previousLetterPosition = letter.prev?.position.last else {
            return
        }
        
        switch previousLetterPosition {
        case .choseong :
            updatePropertiesWhenPreviousLetterIsChoseong(letter)
        case .jungseong:
            updatePropertiesWhenPreviousLetterIsJungseong(letter)
        case .jongseong:
            updatePropertiesWhenPreviousLetterIsJongseong(letter)
        }
    }
    
    private func updatePropertiesOnlyOne(_ letter: Hangeul) {
        if letter.isDoubleJungseong() {
            letter.update(status: .finished, position: .jungseong)
        } else if letter.canBeJungseong() {
            letter.update(position: .jungseong)
        } else {
            letter.update(position: .choseong)
        }
    }
}

// MARK: - called in updatePropertiesMoreThanOne

extension HangeulUpdater {
    
    private func updatePropertiesWhenPreviousLetterIsChoseong(_ letter: Hangeul) {
        guard let previousLetter = letter.prev else {
            return
        }
        
        if letter.canBeJungseong() {
            letter.update(position: .jungseong)
        } else {
            previousLetter.update(status: .finished)
            letter.update(position: .choseong)
        }
    }
    
    private func updatePropertiesWhenPreviousLetterIsJungseong(_ letter: Hangeul) {
        guard let previousLetter = letter.prev else {
            return
        }
        
        if letter.canBeTripleJungseong() {
            letter.update(position: .jungseong)
        } else if letter.isDoubleJungseong() {
            previousLetter.update(status: .finished)
            letter.update(status: .finished, position: .jungseong)
        } else if letter.canBeDoubleJungseong() {
            letter.update(position: .jungseong)
        } else if letter.canBeJungseong() {
            previousLetter.update(status: .finished)
            letter.update(position: .jungseong)
        } else if previousLetter.canHaveJongseong() && letter.canBeJongseong() {
            letter.update(position: .jongseong)
        } else {
            previousLetter.update(status: .finished)
            letter.update(position: .choseong)
        }
        
        
    }
    
    private func updatePropertiesWhenPreviousLetterIsJongseong(_ letter: Hangeul) {
        guard let previousLetter = letter.prev,
              let mostPreviousLetter = previousLetter.prev else {
            return
        }
        
        if letter.canBeJungseong() {
            mostPreviousLetter.update(status: .finished)
            previousLetter.update(position: .choseong)
            letter.update(position: .jungseong)
        } else if letter.canBeDoubleJongseong() {
            letter.update(position: .jongseong)
        } else {
            previousLetter.update(status: .finished)
            letter.update(position: .choseong)
        }
    }
}
