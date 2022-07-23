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
    private let updater = HangeulUpdater()
    private let combiner = HangeulCombiner()
}

extension HangeulIOManger {
    private enum InputlistTailInformation {
        case tailIsFinished, tailWasJongseong, tailIsNormal
    }
}

// MARK: - Public 

extension HangeulIOManger {
    
    func process(input: String) {
        inputList.append(input)
        
        switch input {
        case Text.back where !inputList.isEmpty():
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

// MARK: - Private

// MARK: - called in process

extension HangeulIOManger {
    
    private func processWhenInputIsBack() {
        inputList.removeLast()
        setOutput(with: Text.emptyString, editMode: .remove)
        
        guard let tail = inputList.tail else {
            return
        }
        
        let tailInformation = getInformationAbout(tail)
        
        switch tailInformation {
        case .tailIsFinished:
            updater.updateProperties(of: tail, when: .remove)
        case .tailWasJongseong:
            updater.updateProperties(of: tail, when: .remove)
            let result = combiner.combineCharacter(using: tail, when: .remove)
            setOutput(with: result?.combinedCharacter, editMode: .change)
        case .tailIsNormal:
            let result = combiner.combineCharacter(using: tail, when: .remove)
            setOutput(with: result?.combinedCharacter, editMode: .add)
        }
    }
    
    private func processWhenInputIsSpace() {
        guard let lastInputLetter = inputList.tail else {
            return
        }
        
        updater.updateProperties(of: lastInputLetter, when: .space)
        setOutput(with: Text.whiteSpaceString, editMode: .add)
    }
    
    private func processWhenInputIsNormalLetter() {
        guard let lastInputLetter = inputList.tail else {
            return
        }
        
        updater.updateProperties(of: lastInputLetter, when: .add)
        
        if let result = combiner.combineCharacter(using: lastInputLetter, when: .add) {
            setOutput(with: result.combinedCharacter, editMode: result.outputEditMode)
        }
    }
}

// MARK: - set output string

extension HangeulIOManger {
    
    private func setOutput(with combinedCharacter: String?, editMode: HangeulOutputEditMode?) {
        guard let editMode = editMode,
              let combinedCharacter = combinedCharacter else {
            return
        }
        
        switch editMode {
        case .add:
            output += combinedCharacter
        case .change where output.count > 0:
            output.unicodeScalars.removeLast()
            output += combinedCharacter
        case .remove:
            output.unicodeScalars.removeLast()
        default:
            break
        }
    }
}

// MARK: - get information about tail of input list

extension HangeulIOManger {
    
    private func getInformationAbout(_ tail: Hangeul) -> InputlistTailInformation {
        if tail.status == .finished {
            return .tailIsFinished
        } else if tail.position.count > 1 {
            return .tailWasJongseong
        } else {
            return .tailIsNormal
        }
    }
}
