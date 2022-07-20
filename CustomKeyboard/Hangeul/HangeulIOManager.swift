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
    private var output = ""
}

// MARK: - Public Method

extension HangeulIOManger {
    
    func process(input: String) {
        inputList.append(input)
        
        switch input {
        case "Back":
            processWithBack()
        case "Space":
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
        output = ""
    }
}

// MARK: - Private Method

extension HangeulIOManger {
    
    // MARK: - called in process
    
    private func processWithBack() {
        let specifier = HangeulSpecifier()
        let combiner = HangeulCombiner()

        guard !inputList.isEmpty() else {
            return
        }

        inputList.removeLast()
        updateOutput(with: "", outputMode: .remove)
        
        guard let inputListTail = inputList.tail else {
            return
        }
        
        if inputListTail.status == .finished {
            specifier.specifyProperties(of: inputListTail, when: .remove)
            return
        }
        
        if inputListTail.position.count > 1 {
            specifier.specifyProperties(of: inputListTail, when: .remove)
            updateOutput(with: "", outputMode: .remove)
        }
        
        combiner.combine(inputListTail, inputMode: .remove)
        updateOutput(with: combiner.getCombinedString(), outputMode: .add)
    }
    
    private func processWithSpace() {
        guard let inputListTail = inputList.tail else {
            return
        }
        
        let specifier = HangeulSpecifier()
        
        specifier.specifyProperties(of: inputListTail, when: .space)
        updateOutput(with: " ", outputMode: .add)
    }
    
    private func processWithNormalInput(_ input: String) {
        guard let inputListTail = inputList.tail else {
            return
        }
        
        let specifier = HangeulSpecifier()
        let combiner = HangeulCombiner()
        
        specifier.specifyProperties(of: inputListTail, when: .add)
        combiner.combine(inputListTail, inputMode: .add)
        updateOutput(with: combiner.getCombinedString(), outputMode: combiner.getOutputMode())
    }
  
    // MARK: - update output string
    private func updateOutput(with combinedString: String, outputMode: HangeulOutputMode) {

        guard outputMode != .remove else {
            output.unicodeScalars.removeLast()
            return
        }
        
        if outputMode == .change && !output.isEmpty {
            output.unicodeScalars.removeLast()
        }
        
        output += combinedString
    }
}
