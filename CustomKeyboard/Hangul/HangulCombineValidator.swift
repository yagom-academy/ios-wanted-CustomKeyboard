//
//  HangulKeyboardValidator.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/19.
//

import Foundation

class HangulCombineValidator {
    
    func canMakeDoubleCho(onProcessing: String, input: String) -> Bool { // 쌍자음 체크
        if HangulSet.checkingDoubleChos.contains(where: { $0 == (onProcessing, input) }) {
            return true
        } else {
            return false
        }
    }
    
    func canMakeDoubleJung(onProcessing: String, input: String) -> Bool { // 모음 조합 확인
        if HangulSet.checkingDoubleJungs.contains(where: { $0 == (onProcessing, input) }) {
            return true
        } else {
            return false
        }
    }
    func canMakeTripleJung(onProcessing: String, input: String) -> Bool { // 삼중 모음 조합 확인
        if HangulSet.checkingTripleJungs.contains(where: { $0 == (onProcessing, input) }) {
            return true
        } else {
            return false
        }
    }
    
    func canMakeDoubleJong(onProcessing: String, input: String) -> Bool { // 종성 조합 확인
        if HangulSet.checkingJongs.contains(where: { $0 == (onProcessing, input) }) {
            return true
        } else {
            return false
        }
    }
    
    func combineSingleToDouble(input: Int) -> Int {
        return input+1
    }
    
    func combineSingleJungToDouble(onProcessing: String, input: String) -> String {
        let index = HangulSet.checkingDoubleJungs.firstIndex{$0 == (onProcessing, input)} ?? 0
        return HangulSet.doubleJungs[index]
    }
    
    func combineTripleJungToDouble(onProcessing: String, input: String) -> String {
        let index = HangulSet.checkingTripleJungs.firstIndex{$0 == (onProcessing, input)} ?? 0
        return HangulSet.tripleJungs[index]
    }
    
    func combineSingleJongToDouble(onProcessing: String, input: String) -> String {
        let index = HangulSet.checkingJongs.firstIndex{ $0 == (onProcessing, input)} ?? 0
        return HangulSet.doubleJongs[index]
    }
    
}
