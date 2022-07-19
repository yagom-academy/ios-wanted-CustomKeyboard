//
//  HangeulIoManager.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

class HangeulIOManger {
    
    private var inputList = HangeulList()
    private var outputList = [String]()
    
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
                updateOutputList(with: "", outputMode: .remove)
                return
            }
            
            if inputList.tail!.position.count > 1 {
                specifier.specify(inputList.tail, inputMode: .remove)
                updateOutputList(with: "", outputMode: .remove)
            }
            
            combiner.combine(inputList.tail!, inputMode: .remove)
            updateOutputList(with: combiner.getCombinedString(), outputMode: .change)
        case "Space":
            specifier.specify(inputList.tail!, inputMode: .space)
            updateOutputList(with: " ", outputMode: .add)
        default:
            specifier.specify(inputList.tail!, inputMode: .add)
            combiner.combine(inputList.tail!, inputMode: .add)
            updateOutputList(with: combiner.getCombinedString(), outputMode: combiner.getOutputMode())
        }
    }
    
  
    private func updateOutputList(with character: String, outputMode: HangeulOutputMode) {

        guard outputMode != .remove else {
            outputList.removeLast()
            return
        }
        
        if outputMode == .change && !outputList.isEmpty {
            outputList.removeLast()
        }
        
        let characterArray = Array(character)
        for ele in characterArray {
            outputList.append(String(ele))
        }
        
    }
    
    func getOutput() -> String {
        return outputList.map{$0}.reduce("",+)
    }
    
    func reset() {
        inputList = HangeulList()
        outputList = []
    }
}
