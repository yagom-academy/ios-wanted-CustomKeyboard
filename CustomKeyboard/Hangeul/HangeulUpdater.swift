//
//  HangeulSpecifier.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

// MARK: - Public

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


// MARK: - Private

// MARK: - called in specifyProperties

extension HangeulUpdater {
    
    private func updatePropertiesInSpaceMode(_ letter: Hangeul) {
        if letter.canCombineWithPreviousLetter() == false {
            return
        }
        
        guard let previousLetter = letter.prev else {
            return
        }
        
        previousLetter.update(newStatus: .finished)
    }
    
    private func updatePropertiesInRemoveMode(_ letter: Hangeul) {
        if letter.status == .finished && letter.text != Text.space {
            letter.update(newStatus: .ongoing)
            return
        }
    
        if letter.position.count > 1 {
            guard let previousLetter = letter.prev,
                  let firstPositionOfLetter = letter.position.first else {
                return
            }
            
            previousLetter.update(newStatus: .ongoing)
            letter.update(newStatus: .ongoing, newPosition: firstPositionOfLetter)
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
            letter.update(newStatus: .finished, newPosition: .jungseong)
        } else if letter.canBecome(.jungseong) {
            letter.update(newPosition: .jungseong)
        } else {
            letter.update(newPosition: .choseong)
        }
    }
}

// MARK: - called in updatePropertiesMoreThanOne

extension HangeulUpdater {
    
    private func updatePropertiesWhenPreviousLetterIsChoseong(_ letter: Hangeul) {
        guard let previousLetter = letter.prev else {
            return
        }
        
        if letter.canBecome(.jungseong) {
            letter.update(newPosition: .jungseong)
        } else {
            previousLetter.update(newStatus: .finished)
            letter.update(newPosition: .choseong)
        }
    }
    
    private func updatePropertiesWhenPreviousLetterIsJungseong(_ letter: Hangeul) {
        guard let previousLetter = letter.prev else {
            return
        }
        
        if letter.canBeTripleJungseong() {
            letter.update(newPosition: .jungseong)
        } else if letter.isDoubleJungseong() {
            previousLetter.update(newStatus: .finished)
            letter.update(newStatus: .finished, newPosition: .jungseong)
        } else if letter.canBeDoubleJungseong() {
            letter.update(newPosition: .jungseong)
        } else if letter.canBecome(.jungseong) {
            previousLetter.update(newStatus: .finished)
            letter.update(newPosition: .jungseong)
        } else if previousLetter.canHaveJongseong() && letter.canBecome(.jongseong) {
            letter.update(newPosition: .jongseong)
        } else {
            previousLetter.update(newStatus: .finished)
            letter.update(newPosition: .choseong)
        }
        
        
    }
    
    private func updatePropertiesWhenPreviousLetterIsJongseong(_ letter: Hangeul) {
        guard let previousLetter = letter.prev,
              let mostPreviousLetter = previousLetter.prev else {
            return
        }
        
        if letter.canBecome(.jungseong) {
            mostPreviousLetter.update(newStatus: .finished)
            previousLetter.update(newPosition: .choseong)
            letter.update(newPosition: .jungseong)
        } else if letter.canBeDoubleJongseong() {
            letter.update(newPosition: .jongseong)
        } else {
            previousLetter.update(newStatus: .finished)
            letter.update(newPosition: .choseong)
        }
    }
}
