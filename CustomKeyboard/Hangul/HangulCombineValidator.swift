//
//  HangulKeyboardValidator.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/19.
//

import Foundation

class HangulCombineValidator {
    
    func isPossibleToMakeDoubleCho(onProcessing: HangulKeyboardData, input: HangulKeyboardData) -> Bool {
        if HangulSet.checkingDoubleChos.contains(where: { $0 == (onProcessing.hangul, input.hangul) }) {
            return true
        } else {
            return false
        }
    }
    
    func isPossibleToMakeDoubleJung(onProcessing: HangulKeyboardData, input: HangulKeyboardData) -> Bool {
        if HangulSet.checkingDoubleJungs.contains(where: { $0 == (onProcessing.hangul, input.hangul) }) {
            return true
        } else {
            return false
        }
    }
    
    func isPossibleToMakeTripleJung(onProcessing: HangulKeyboardData, input: HangulKeyboardData) -> Bool {
        if HangulSet.checkingTripleJungs.contains(where: { $0 == (onProcessing.hangul, input.hangul) }) {
            return true
        } else {
            return false
        }
    }
    
    func isPossibleToMakeDoubleJong(onProcessing: HangulKeyboardData, input: HangulKeyboardData) -> Bool {
        if HangulSet.checkingJongs.contains(where: { $0 == (onProcessing.hangul, input.hangul) }) {
            return true
        } else {
            return false
        }
    }
    
    func combineSingleToDouble(input: HangulKeyboardData) -> HangulKeyboardData {
        return HangulKeyboardData(uni: input.unicode + 1, state: .cho)
    }
    
    func combineSingleJungToDouble(onProcessing: HangulKeyboardData, input: HangulKeyboardData) -> HangulKeyboardData {
        let index = HangulSet.checkingDoubleJungs.firstIndex{$0 == (onProcessing.hangul, input.hangul)} ?? 0
        return HangulKeyboardData(char: HangulSet.doubleJungs[index], state: .jung)
    }
    
    func combineTripleJungToDouble(onProcessing: HangulKeyboardData, input: HangulKeyboardData) -> HangulKeyboardData {
        let index = HangulSet.checkingTripleJungs.firstIndex{$0 == (onProcessing.hangul, input.hangul)} ?? 0
        return HangulKeyboardData(char: HangulSet.tripleJungs[index], state: .doubleJung)
    }
    
    func combineSingleJongToDouble(onProcessing: HangulKeyboardData, input: HangulKeyboardData) -> HangulKeyboardData {
        let index = HangulSet.checkingJongs.firstIndex{ $0 == (onProcessing.hangul, input.hangul)} ?? 0
        return HangulKeyboardData(char: HangulSet.onlyDoubleJongs[index], state: .jong)
    }
}
