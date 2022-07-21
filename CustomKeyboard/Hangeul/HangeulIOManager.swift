//
//  HangeulIOManager.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

// MARK: - Variable

final class HangeulIOManger {
    private var inputList = HangeulList()
    private var output = Text.emptyString
    private let specifier = HangeulUpdater()
    private let combiner = HangeulCombiner()
}

// MARK: - Public Method

extension HangeulIOManger {
    
    func process(input: String) {
        inputList.append(input)
        
        switch input {
        case Text.back:
            processWhenInputIsBack()
        case Text.space:
            processWhenInputIsSpace()
        default:
            processWhenInputIsNormalLetter()
        }
    }
    
    func getOutput() -> String {
        return output
    }
    
    func reset() {
        inputList = HangeulList()
        output = Text.emptyString
    }
}

// MARK: - Private Method

// MARK: - called in process

extension HangeulIOManger {
    
    private func processWhenInputIsBack() {
        if inputList.isEmpty() {
            return
        }
        
        inputList.removeLast()
        setOutput(with: Text.emptyString, editMode: .remove)
        
        guard let lastInputLetter = inputList.tail else {
            return
        }
        
        if lastInputLetter.status == .finished {
            specifier.updateProperties(of: lastInputLetter, when: .remove)
            return
        }
        
        if lastInputLetter.position.count > 1 {
            specifier.updateProperties(of: lastInputLetter, when: .remove)
            setOutput(with: Text.emptyString, editMode: .remove)
        }
        
        guard let result = combiner.combineCharacter(using: lastInputLetter, when: .remove) else {
            return
        }
        setOutput(with: result.combinedCharacter, editMode: .add)
    }
    
    private func processWhenInputIsSpace() {
        guard let lastInputLetter = inputList.tail else {
            return
        }
        
        specifier.updateProperties(of: lastInputLetter, when: .space)
        setOutput(with: Text.whiteSpaceString, editMode: .add)
    }
    
    private func processWhenInputIsNormalLetter() {
        guard let lastInputLetter = inputList.tail else {
            return
        }
        
        specifier.updateProperties(of: lastInputLetter, when: .add)
        
        guard let result = combiner.combineCharacter(using: lastInputLetter, when: .add) else {
            return
        }
        setOutput(with: result.combinedCharacter, editMode: result.outputEditMode)
    }
}

// MARK: - set output string

extension HangeulIOManger {
    
    private func setOutput(with combinedCharacter: String?, editMode: HangeulOutputEditMode?) {
        guard let editMode = editMode else {
            return
        }
        
        if editMode == .remove {
            output.unicodeScalars.removeLast()
            return
        }
        
        if editMode == .change && output.isEmpty == false {
            output.unicodeScalars.removeLast()
        }
        
        guard let combinedCharacter = combinedCharacter else {
            return
        }

        output += combinedCharacter
    }
}
