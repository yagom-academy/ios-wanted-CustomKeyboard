//
//  KeyboardMaker.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/13.
//

import Foundation

class KeyboardMaker {
    
    struct Status {
        var currentState: HangulKeyboardData.HangulState
        var isCompleted: Bool
        var alphaRepository: [HangulKeyboardData]
        var mode: EditingMode
    }
    
    enum EditingMode {
        case none
        case doubleJong
        case jong
        case deleting
    }
    
    private var isDoubleJong = false
    private var isJong = false
    
    private var combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
    private var processingBuffer = Status(currentState: .empty, isCompleted: false, alphaRepository: [], mode: .none)
    private var releaseTextField = [String]()
    private let hangulConverter = HangulKeyboardConverter()
    private let combineValidator = HangulCombineValidator()
    private let combinator = HangulCombinator()
    
    public func putKeyboardData(data inputData: HangulKeyboardData) -> [String] {
         guard inputData.hangul != " " else {
            let spaceKeyboardData = HangulKeyboardData(char: " ", state: processingBuffer.currentState)
            
            processingBuffer.alphaRepository.removeAll()
            processingBuffer.isCompleted = false
            processingBuffer.currentState = .empty
            processingBuffer.mode = .none
            
            combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
            releaseTextField.append(spaceKeyboardData.hangul)
            return releaseTextField
        }
        
        switch processingBuffer.currentState {
        case .empty:
            processingBuffer = emptyStage(status: processingBuffer, input: inputData)
        case .cho:
            processingBuffer = singleChoStage(status: processingBuffer, input: inputData)
        case .doubleCho:
            processingBuffer = doubleChoStage(status: processingBuffer, input: inputData)
        case .jung:
            processingBuffer = singleJungStage(status: processingBuffer, input: inputData)
        case .doubleJung:
            processingBuffer = doubleJungStage(status: processingBuffer, input: inputData)
        case .jong:
            processingBuffer = singleJongStage(status: processingBuffer, input: inputData)
        case .doubleJong:
            processingBuffer = doubleJongStage(status: processingBuffer, input: inputData)
        }
        
        switch processingBuffer.mode {
        case .none:
            print("y")
        case .jong:
            print("y")
        case .doubleJong:
            print("y")
        case .deleting:
            return deleteKeyboardData(currentKeyboardData: inputData)
        }
        
        
        if isJong {
            
        } else if isDoubleJong {
            let decomposedHangul = combinator.decomposeHangul(hangul: releaseTextField.last!, lastState: .doubleJong)
            let newBuffer = decomposedHangul
            let newKeyboardData = combinator.combineHangul(buffer: newBuffer, lastState: .jong)
            isDoubleJong = false
            releaseTextField[releaseTextField.count - 1] = newKeyboardData.hangul
        }
        
        if processingBuffer.isCompleted {
            let combinedHagul = combinator.combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState)
            releaseTextField.append(combinedHagul.hangul)
            processingBuffer.isCompleted = false
            return releaseTextField
        }
        
        if releaseTextField.count <= 1 {
            let newHangul = combinator.combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState)
            if releaseTextField.isEmpty {
                releaseTextField.append(newHangul.hangul)
            } else {
                if processingBuffer.alphaRepository.count == 1 {
                    releaseTextField.append(newHangul.hangul)
                    return releaseTextField
                }
                releaseTextField[0] = newHangul.hangul
            }
        } else if releaseTextField.count > 1 {
            if releaseTextField.last == " " {
                let combinedHagul = combinator.combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState)
                releaseTextField.append(combinedHagul.hangul)
                processingBuffer.isCompleted = false
                return releaseTextField
            } else if processingBuffer.alphaRepository.count == 1 {
                let combinedHagul = combinator.combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState)
                releaseTextField.append(combinedHagul.hangul)
                processingBuffer.isCompleted = false
                return releaseTextField
            }
            releaseTextField[releaseTextField.count - 1] = combinator.combineHangul(buffer: combineBuffer, lastState: processingBuffer.currentState).hangul
        }
        return releaseTextField
    }
    
    func deleteKeyboardData(currentKeyboardData inputData: HangulKeyboardData) -> [String] {
        
        if !releaseTextField.isEmpty && !processingBuffer.alphaRepository.isEmpty {
            return deleteHangulInEditing()
            
        } else if inputData.unicode == SpecialCharSet.delete && processingBuffer.alphaRepository.count == 0 {
            return deleteHangulAfterSpacing()
        }
        
        return releaseTextField
    }
    
    func deleteHangulInEditing() -> [String] {
        
        if processingBuffer.alphaRepository.last!.hangul == releaseTextField.last! {
            
            processingBuffer.alphaRepository.removeLast()
            releaseTextField.removeLast()
            processingBuffer.mode = .none
            
            if !releaseTextField.isEmpty {
                let decomposedHangul = combinator.decomposeForCompletedHangul(hangul: releaseTextField.last!, lastState: processingBuffer.currentState)
                decomposedHangul.enumerated().forEach{ combineBuffer[$0.offset] = $0.element }
            }
            
            return releaseTextField
            
        } else {
            
            var decomposedHangul = combinator.decomposeHangul(hangul: releaseTextField.last!, lastState: processingBuffer.currentState)
            
            decomposedHangul = decomposedHangul.filter{$0.hangul != " "}
            processingBuffer.alphaRepository.removeLast()
            decomposedHangul.removeLast()
            combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
            decomposedHangul.enumerated().forEach{ combineBuffer[$0.offset] = $0.element }
            
            let recombinedHangul = combinator.combineHangulForDelete(buffer: decomposedHangul, lastState: processingBuffer.currentState)
            
            releaseTextField[releaseTextField.count - 1] = recombinedHangul.hangul
            processingBuffer.mode = .none
            
            return releaseTextField
        }
    }
    
    func deleteHangulAfterSpacing() -> [String] {
        
        processingBuffer.currentState = .empty
        processingBuffer.mode = .none
        combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
        
        if !releaseTextField.isEmpty {
            releaseTextField.removeLast()
        }
        
        return releaseTextField
    }
    
    func emptyStage(status: Status, input: HangulKeyboardData) -> Status {
        
        combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .empty
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.chos.contains(input.hangul) {
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) {
                
                combineBuffer[0] = currentKeyboardData
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = false
                
                return currentStatus
            }
            
            combineBuffer[0] = currentKeyboardData
            currentStatus.currentState = .cho
            currentStatus.isCompleted = false
            
            return currentStatus
            
        } else if HangulSet.jungs.contains(currentKeyboardData.hangul) {
            if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) {
                
                combineBuffer[1] = currentKeyboardData
                currentStatus.isCompleted = true
                currentStatus.currentState = .doubleJung
                
                return currentStatus
            }
            
            combineBuffer[1] = currentKeyboardData
            currentStatus.isCompleted = true
            currentStatus.currentState = .jung
            
            return currentStatus
            
        } else if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            currentStatus.mode = .deleting
            
            if currentStatus.alphaRepository.count == 0 {
                
                currentStatus.isCompleted = false
                currentStatus.currentState = .empty
                
                return currentStatus
                
            } else {
                
                currentStatus.isCompleted = false
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
                combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
                
                return currentStatus
            }
        }
        
        return currentStatus
    }
    
    func singleChoStage(status: Status, input: HangulKeyboardData) -> Status {
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .cho
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.chos.contains(currentKeyboardData.hangul) {
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) {
                
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                combineBuffer[0] = currentKeyboardData
                
                return currentStatus
            }
            
           
            if combineValidator.isPossibleToMakeDoubleCho(onProcessing: status.alphaRepository.last!, input: currentKeyboardData) {
                
                let combinedChar = combineValidator.combineSingleToDouble(input: currentKeyboardData)
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = false
                combineBuffer[0] = combinedChar
                
                return currentStatus
                
            } else {
                
                currentStatus.currentState = .cho
                currentStatus.isCompleted = true
                combineBuffer[0] = currentKeyboardData
                
                return currentStatus
            }
            
            
        } else if HangulSet.jungs.contains(currentKeyboardData.hangul) {
            if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) {
                
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = false
                combineBuffer[1] = currentKeyboardData
                
                return currentStatus
            }
            
            currentStatus.currentState = .jung
            currentStatus.isCompleted = false
            
            combineBuffer[1] = currentKeyboardData
            
            return currentStatus
            
        }
        
        if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            currentStatus.mode = .deleting
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count > 1 {
                
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
                
            } else {
                currentStatus.currentState = .empty
            }
            
            return currentStatus
        }
        
        return currentStatus
    }
    
    func doubleChoStage(status: Status, input: HangulKeyboardData) -> Status {
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .doubleCho
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.chos.contains(currentKeyboardData.hangul) {
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) {
                
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                combineBuffer[0] = currentKeyboardData
                
                return currentStatus
            }
            
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            combineBuffer[0] = currentKeyboardData
            
            return currentStatus
            
        } else if HangulSet.jungs.contains(currentKeyboardData.hangul) {
            if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) {
                
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = false
                combineBuffer[1] = currentKeyboardData
                
                return currentStatus
            }
            
            currentStatus.currentState = .jung
            currentStatus.isCompleted = false
            combineBuffer[1] = currentKeyboardData
            
            return currentStatus
            
        } else if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            currentStatus.mode = .deleting
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count > 1 {
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
                
            } else {
                currentStatus.currentState = .empty
            }
            
            return currentStatus
        }
        
        return currentStatus
    }
    
    func singleJungStage(status: Status, input: HangulKeyboardData) -> Status {
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .jung
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.jungs.contains(currentKeyboardData.hangul) {
            if combineValidator.isPossibleToMakeDoubleJung(onProcessing: combineBuffer[1], input: currentKeyboardData) {
                
                let combinedStr = combineValidator.combineSingleJungToDouble(onProcessing: combineBuffer[1], input: currentKeyboardData)
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = false
                combineBuffer[1] = combinedStr
                
                return currentStatus
            }
            
            combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
            currentStatus.currentState = .jung
            currentStatus.isCompleted = true
            combineBuffer[1] = currentKeyboardData
            
            return currentStatus
            
        } else if combineBuffer[0].hangul != "" {
            
         
            if HangulSet.jongs.contains(currentKeyboardData.hangul) {
                
                currentStatus.isCompleted = false
                combineBuffer[2] = currentKeyboardData
                
                if HangulSet.doubleJongs.contains(currentKeyboardData.hangul) {
                    
                    currentStatus.currentState = .doubleJong
                    
                    return currentStatus
                }
                
                currentStatus.currentState = .jong
                
                return currentStatus
            } else if HangulSet.chos.contains(currentKeyboardData.hangul) {
                
                combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
                currentStatus.isCompleted = true
                combineBuffer[0] = currentKeyboardData
                
                if HangulSet.doubleChos.contains(currentKeyboardData.hangul) {
                    currentStatus.currentState = .doubleCho
                    
                    return currentStatus
                }
                
                currentStatus.currentState = .cho
                
                return currentStatus
            }
            
        } else if HangulSet.chos.contains(currentKeyboardData.hangul) {
            
            combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
            currentStatus.isCompleted = true
            combineBuffer[0] = currentKeyboardData
            
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) {
                currentStatus.currentState = .doubleCho
                
                return currentStatus
            }
            
            currentStatus.currentState = .cho
            
            return currentStatus
            
        }
        
        if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            currentStatus.mode = .deleting
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count <= 1 {
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
            } else {
                currentStatus.currentState = .empty
            }
            
            return currentStatus
        }
        
        return currentStatus
    }
    
    func doubleJungStage(status: Status, input: HangulKeyboardData) -> Status {
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .doubleJung
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.jungs.contains(currentKeyboardData.hangul) {
            if combineValidator.isPossibleToMakeTripleJung(onProcessing: combineBuffer[1], input: currentKeyboardData) {
                
                currentStatus.isCompleted = false
                currentStatus.currentState = .doubleJung
                let newJung = combineValidator.combineTripleJungToDouble(onProcessing: combineBuffer[1], input: currentKeyboardData)
                combineBuffer[1] = newJung
                
                return currentStatus
                
            } else if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) {
                
                combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
                currentStatus.currentState = .doubleJung
                currentStatus.isCompleted = true
                combineBuffer[1] = currentKeyboardData
                
                return currentStatus
            }
            
            combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
            currentStatus.currentState = .jung
            currentStatus.isCompleted = true
            combineBuffer[1] = currentKeyboardData
            
            return currentStatus
            
        } else if combineBuffer[0].hangul != "" {
            
            if HangulSet.jongs.contains(currentKeyboardData.hangul) {
                
                currentStatus.isCompleted = false
                currentStatus.currentState = .jong
                combineBuffer[2] = currentKeyboardData

                if HangulSet.doubleJongs.contains(currentKeyboardData.hangul) {
                    
                    currentStatus.currentState = .doubleJong
                    // MARK: - 이 부분에서 true를 넘길경우 중복으로 쓰여진다.
                    currentStatus.isCompleted = false
                    combineBuffer[2] = currentKeyboardData
                    
                    return currentStatus
                }
                
                currentStatus.currentState = .jong
                currentStatus.isCompleted = false
                combineBuffer[2] = currentKeyboardData
                
                return currentStatus
            }
        } else if HangulSet.chos.contains(currentKeyboardData.hangul) {
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) {
                
                combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                combineBuffer[0] = currentKeyboardData
                
                return currentStatus
            }
            
            combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            combineBuffer[0] = currentKeyboardData
            
            return currentStatus
        }
        
        if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            currentStatus.mode = .deleting
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count > 1 {
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
                
            } else {
                currentStatus.currentState = .empty
            }
            
            return currentStatus
        }
        
        return currentStatus
    }
    
    func singleJongStage(status: Status, input: HangulKeyboardData) -> Status {
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .jong
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.jungs.contains(currentKeyboardData.hangul) {
            
            currentStatus.isCompleted = true
            isJong = true
            combineBuffer[0] = combineBuffer[2]
            combineBuffer[1] = currentKeyboardData
            combineBuffer[2] = HangulKeyboardData(char: "", state: .empty)
            currentStatus.currentState = .jung
            
            
            if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) {
                isDoubleJong = true
                currentStatus.currentState = .doubleJung
                
                return currentStatus
            }
            
            return currentStatus
            
        } else if HangulSet.chos.contains(currentKeyboardData.hangul) {
            if combineValidator.isPossibleToMakeDoubleJong(onProcessing: combineBuffer[2], input: currentKeyboardData) {
                
                currentStatus.currentState = .doubleJong
                currentStatus.isCompleted = false
                let combinedDoubleJong = combineValidator.combineSingleJongToDouble(onProcessing: combineBuffer[2], input: currentKeyboardData)
                combineBuffer[2] = combinedDoubleJong
                
                return currentStatus
            }
            
            combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            combineBuffer[0] = currentKeyboardData
            
            return currentStatus
            
        }
        
        if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            currentStatus.mode = .deleting
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count > 1 {
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
            } else {
                currentStatus.currentState = .empty
            }
            
            return currentStatus
        }
        
        return currentStatus
    }
    
    func doubleJongStage(status: Status, input: HangulKeyboardData) -> Status {
        
        var currentStatus = status
        var currentKeyboardData = input
        currentKeyboardData.bornState = .doubleJong
        
        currentStatus.alphaRepository.append(currentKeyboardData)
        
        if HangulSet.chos.contains(input.hangul) {
            if HangulSet.doubleChos.contains(currentKeyboardData.hangul) {
                
                combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
                combineBuffer[0] = currentKeyboardData
                currentStatus.currentState = .doubleCho
                currentStatus.isCompleted = true
                
                return currentStatus
            }
            
            combineBuffer = [HangulKeyboardData](repeating: HangulKeyboardData(char: "", state: .empty), count: 3)
            combineBuffer[0] = currentKeyboardData
            currentStatus.currentState = .cho
            currentStatus.isCompleted = true
            
            return currentStatus
            
        } else if HangulSet.jungs.contains(currentKeyboardData.hangul) {
            
            currentStatus.isCompleted = true
            isDoubleJong = true
            combineBuffer[0] = currentStatus.alphaRepository[currentStatus.alphaRepository.count - 2]
            combineBuffer[1] = currentKeyboardData
            combineBuffer[2] = HangulKeyboardData(char: "", state: .empty)
            
            currentStatus.currentState = .jung
            
            if HangulSet.doubleJungs.contains(currentKeyboardData.hangul) {
                currentStatus.currentState = .doubleJung
                return currentStatus
            }
            
            return currentStatus
        }
        
        if currentKeyboardData.unicode == SpecialCharSet.delete {
            
            currentStatus.alphaRepository.removeLast()
            currentStatus.mode = .deleting
            currentStatus.isCompleted = false
            
            if currentStatus.alphaRepository.count > 1 {
                currentStatus.currentState = currentStatus.alphaRepository.last!.bornState
            } else {
                currentStatus.currentState = .empty
            }
            
            return currentStatus
        }
        
        return currentStatus
    }
    
}
