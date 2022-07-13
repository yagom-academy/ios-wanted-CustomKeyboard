//
//  KeyboardMaker.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/13.
//

import Foundation

class KeyboardMaker {
    
    enum HangulState {
        case empty
        case cho
        case doubleCho
        case jung
        case doubleJung
        case jong
        case doubleJong
    }
    
    var currentStatus: HangulState = .empty
    var isCompleted = false
    var processArr = [Int]()
    
    var cho = ""
    var jun = ""
    var jon = ""
    
    func putHangul(input: String) {
        
        let uni = convertStr2Unicode(char: input)
        
        switch currentStatus {
        case .empty:
            emptyStage(status: (currentStatus, isCompleted, processArr), input: uni)
        case .cho:
            emptyStage(status: (currentStatus, isCompleted, processArr), input: uni)
        case .doubleCho:
            emptyStage(status: (currentStatus, isCompleted, processArr), input: uni)
        case .jung:
            emptyStage(status: (currentStatus, isCompleted, processArr), input: uni)
        case .doubleJung:
            emptyStage(status: (currentStatus, isCompleted, processArr), input: uni)
        case .jong:
            emptyStage(status: (currentStatus, isCompleted, processArr), input: uni)
        case .doubleJong:
            emptyStage(status: (currentStatus, isCompleted, processArr), input: uni)
        }
    }
    
    
    func reset() {
        currentStatus = .empty
        isCompleted = false
        processArr = []
        cho = ""
        jun = ""
        jon = ""
    }
    
    
    func convertStr2Unicode(char: String) -> Int {
        if let unicodeScalar = UnicodeScalar(char) {
            return Int(unicodeScalar.value)
        }
        return 0
    }
    func convertUni2Str(uni: Int) -> String {
        print(uni)
        return ""
    }
    
    func emptyStage(status: (HangulState, Bool, [Int]), input: Int) {
        
        processArr.append(input)
        
        if HangulSet.chos.contains(input) { // 초성
            
            currentStatus = .cho
            isCompleted = false
            
        } else if HangulSet.doubleChos.contains(input) {
            currentStatus = .doubleCho
            isCompleted = false
        } else if HangulSet.jons.contains(input) { // 중성
            isCompleted = true
            currentStatus = .empty
            reset()
        } else { // 종성
            
        }
    }
    
    func cho1Stage(status: (HangulState, Bool, [Int]), input: Int) {
        
        if HangulSet.chos.contains(input) { // 초성
            currentStatus = .doubleCho
            isCompleted = false
            // 초성 조합
            if canMakeDouble(onProcessing: status.2.last!, input: input) {
                
            }
            //
        } else if HangulSet.jons.contains(input) { // 중성
            
        } else { // 종성
            
        }
    }
    
    func cho2Stage(status: (HangulState, Bool, [Int]), input: Int) {
        
    }
    
    func makeChar() {
        
    }
    
    func canMakeDouble(onProcessing: Int, input: Int) -> Bool {
        if onProcessing == input {
            return true
        } else {
            return false
        }
    }
    
    
}
