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
            if inputList.isEmpty()  { 
                return
            }
            
            inputList.removeLast()
            
            guard inputList.tail != nil && inputList.tail!.status != .finished else {
                specifier.specify(inputList.tail, inputMode: .remove)
                updateOutputList(with: "", mode: .remove)
                return
            }
            
            if inputList.tail!.position.count > 1 {
                specifier.specify(inputList.tail, inputMode: .remove)
                updateOutputList(with: "", mode: .remove)
            }
            
            let result = combiner.combine(inputList.tail!, inputMode: .remove)
            updateOutputList(with: result.newString, mode: .change)
        case "Space":
            specifier.specify(inputList.tail, inputMode: .space)
            updateOutputList(with: " ", mode: .add)
        default:
            specifier.specify(inputList.tail, inputMode: .add)
            let result = combiner.combine(inputList.tail!, inputMode: .add)
            updateOutputList(with: result.newString, mode: result.mode)
        }
    }
    
    private func updateOutputList(with character: String, mode: HangeulOutputEditMode) {

        guard mode != .remove else {
            outputList.removeLast()
            return
        }
        
        if mode == .change {
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
