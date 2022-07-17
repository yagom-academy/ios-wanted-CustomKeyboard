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
            print("back")
            if inputList.isEmpty()  {
                return
            }
            
            if inputList.tail!.unicode == -2 {
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
                outputList.removeLast()
                return
            }
            if tail.position.count > 1 {
                outputList.removeLast()
                tail.prev?.update(newType: tail.prev!.unicodeType, newStatus: .ongoing, newPosition: (tail.prev?.position.last!)!)
                tail.update(newType: .fixed, newStatus: .ongoing, newPosition: (tail.position.first!))
                tail.position.removeLast()
                tail.position.removeLast()
            }
            let result = combiner.combine(tail, editMode: .remove)
            updateOutput(with: result.newString, mode: .changeCharacter)
        case "Space":
            inputList.tail?.status = .finished
            inputList.append(data: "Space")
            updateOutput(with: " ", mode: .addCharacter)
        default:
            inputList.append(data: input)
            specifier.specify(inputList.tail!)
            let result = combiner.combine(inputList.tail!, editMode: .add)
            updateOutput(with: result.newString, mode: result.mode)
        }
    }
    
    private func updateOutput(with character: String, mode: HangeulOutputEditMode) {
        
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
