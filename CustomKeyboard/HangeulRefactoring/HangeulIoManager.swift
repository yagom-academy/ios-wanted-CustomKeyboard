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
        
        switch input {
        case "Back":
            if inputList.isEmpty()  { 
                return
            }
            
            if inputList.tail!.value == "Space" {
                outputList.removeLast()
                inputList.removeLast()
                return
            }
            
            inputList.removeLast()
            
            guard let tail = inputList.tail else {
                outputList.removeLast()
                return
            }
            
            
            if tail.status == .finished {
                tail.status = .ongoing
                outputList.removeLast()
                return
            }
            
            
            
            if tail.position.count > 1 {
                outputList.removeLast()
                tail.prev?.update(status: .ongoing)
                tail.update(type: .fixed, status: .ongoing, position: (tail.position.first!))
                tail.position.removeLast()
                tail.position.removeLast()
            }
            let result = combiner.combine(tail, inputMode: .remove)
            updateOutputList(with: result.newString, mode: .changeCharacter)
        case "Space":
            specifier.specify(inputList.tail!, inputMode: .space)
            inputList.append(data: input)
            updateOutputList(with: " ", mode: .addCharacter)
        default:
            inputList.append(data: input)
            specifier.specify(inputList.tail!, inputMode: .add)
            let result = combiner.combine(inputList.tail!, inputMode: .add)
            updateOutputList(with: result.newString, mode: result.mode)
        }
    }
    
    private func updateOutputList(with character: String, mode: HangeulOutputEditMode) {
        
        if mode == .changeCharacter {
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
