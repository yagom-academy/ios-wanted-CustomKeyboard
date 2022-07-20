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
}

// MARK: - Public Method

extension HangeulIOManger {
    
    func process(input: String) {
        
        inputList.append(input)
        
        switch input {
        case Text.back:
            processWithBack()
        case Text.space:
            processWithSpace()
        default:
            processWithNormalInput(input)
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
    
    private func processWithBack() {
        if inputList.isEmpty() {
            return
        }
        
        inputList.removeLast()
        setOutput(with: Text.emptyString, editMode: .remove)
        
        guard let inputListTail = inputList.tail else {
            return
        }
        
        let specifier = HangeulSpecifier()
        let combiner = HangeulCombiner()
        
        if inputListTail.status == .finished {
            specifier.specifyProperties(of: inputListTail, when: .remove)
            return
        }
        
        if inputListTail.position.count > 1 {
            specifier.specifyProperties(of: inputListTail, when: .remove)
            setOutput(with: Text.emptyString, editMode: .remove)
        }
        
        combiner.setCombinedString(using: inputListTail, when: .remove)
        setOutput(with: combiner.getCombinedString(), editMode: .add)
    }
    
    private func processWithSpace() {
        guard let inputListTail = inputList.tail else {
            return
        }
        
        let specifier = HangeulSpecifier()
        
        specifier.specifyProperties(of: inputListTail, when: .space)
        setOutput(with: Text.whiteSpaceString, editMode: .add)
    }
    
    private func processWithNormalInput(_ input: String) {
        guard let inputListTail = inputList.tail else {
            return
        }
        
        let specifier = HangeulSpecifier()
        let combiner = HangeulCombiner()
        
        specifier.specifyProperties(of: inputListTail, when: .add)
        combiner.setCombinedString(using: inputListTail, when: .add)
        setOutput(with: combiner.getCombinedString(), editMode: combiner.getOutputMode())
    }
}

// MARK: - set output string

extension HangeulIOManger {
    
    private func setOutput(with combinedString: String, editMode: HangeulOutputMode) {

        if editMode == .remove {
            output.unicodeScalars.removeLast()
            return
        }
        
        if editMode == .change && !output.isEmpty {
            output.unicodeScalars.removeLast()
        }
        
        output += combinedString
    }
}
