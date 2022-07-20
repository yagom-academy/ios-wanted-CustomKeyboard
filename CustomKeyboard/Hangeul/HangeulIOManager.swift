//
//  HangeulIOManager.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

final class HangeulIOManger {
    
    private var inputList = HangeulList()
    private var output = ""
    
    func process(input: String) {
        let specifier = HangeulSpecifier()
        let combiner = HangeulCombiner()
        
        inputList.append(data: input)
        
        switch input {
        case "Back":
            guard !inputList.isEmpty() else {
                return
            }
    
            inputList.removeLast()
            updateOutput(with: "", outputMode: .remove)
            
            guard let inputListTail = inputList.tail else {
                return
            }
            
            if inputListTail.status == .finished {
                specifier.specify(inputListTail, inputMode: .remove)
                return
            }
            
            if inputListTail.position.count > 1 {
                specifier.specify(inputListTail, inputMode: .remove)
                updateOutput(with: "", outputMode: .remove)
            }
            
            combiner.combine(inputListTail, inputMode: .remove)
            updateOutput(with: combiner.getCombinedString(), outputMode: .add)
        case "Space":
            guard let inputListTail = inputList.tail else {
                return
            }
            specifier.specify(inputListTail, inputMode: .space)
            updateOutput(with: " ", outputMode: .add)
        default:
            guard let inputListTail = inputList.tail else {
                return
            }
            specifier.specify(inputListTail, inputMode: .add)
            combiner.combine(inputListTail, inputMode: .add)
            updateOutput(with: combiner.getCombinedString(), outputMode: combiner.getOutputMode())
        }
    }
    
  
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
    
    func getOutput() -> String {
        return output
    }
    
    func reset() {
        inputList = HangeulList()
        output = ""
    }
}
