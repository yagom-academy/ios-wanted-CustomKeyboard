//
//  HangeulIoManager.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

class HangeulIOManger {
    
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
            
            guard inputList.tail != nil && inputList.tail!.status != .finished else {
                specifier.specify(inputList.tail, inputMode: .remove)
                updateOutput(with: "", outputMode: .remove)
                return
            }
            
            if inputList.tail!.position.count > 1 {
                specifier.specify(inputList.tail, inputMode: .remove)
                updateOutput(with: "", outputMode: .remove)
            }
            
            combiner.combine(inputList.tail!, inputMode: .remove)
            updateOutput(with: combiner.getCombinedString(), outputMode: .change)
        case "Space":
            specifier.specify(inputList.tail!, inputMode: .space)
            updateOutput(with: " ", outputMode: .add)
        default:
            specifier.specify(inputList.tail!, inputMode: .add)
            combiner.combine(inputList.tail!, inputMode: .add)
            updateOutput(with: combiner.getCombinedString(), outputMode: combiner.getOutputMode())
        }
    }
    
  
    private func updateOutput(with character: String, outputMode: HangeulOutputMode) {

        guard outputMode != .remove else {
            output.unicodeScalars.removeLast()
            return
        }
        
        if outputMode == .change && !output.isEmpty {
            output.unicodeScalars.removeLast()
        }
        
        output += character
    }
    
    func getOutput() -> String {
        return output
    }
    
    func reset() {
        inputList = HangeulList()
        output = ""
    }
}
