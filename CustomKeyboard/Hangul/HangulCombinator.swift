//
//  HangulCombinator.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/19.
//

import Foundation

class HangulCombinator {
    
    func combineHangul(buffer: [String], lastState: HangulKeyboardData.HangulState) -> HangulKeyboardData { // 글자 조합해서 방
        if lastState == .cho && buffer[1] == "" && buffer[2] == "" {
            return HangulKeyboardData(char: buffer[0], state: lastState)
        } else if lastState == .doubleCho && buffer[1] == "" && buffer[2] == "" {
            return HangulKeyboardData(char: buffer[0], state: lastState)
        } else if (lastState == .jung || lastState == .doubleJung) && buffer[0] == "" && buffer[2] == "" {
            return HangulKeyboardData(char: buffer[1], state: lastState)
        }
        
        guard buffer[0] != "" && buffer[1] != "" else {
            return HangulKeyboardData(char: "", state: lastState)
        }
        
        //TODO: - 한글set에 해당 unicode가 없을경우 예외처리 해야함
        let cho = HangulSet.chos.firstIndex(of: buffer[0]) ?? 0
        let jung = HangulSet.jungs.firstIndex(of: buffer[1]) ?? 0
        
        if buffer.count < 3 {
            let uni =  44032 + cho * 28 * 21 + 28 * jung + 0
            
            let hangul = HangulKeyboardData(uni: uni, state: lastState)
            
            return hangul
        }
        
        let jong = HangulSet.jongs.firstIndex(of: buffer[2]) ?? 0
        
        let uni =  44032 + cho * 28 * 21 + 28 * jung + jong
        let hangul = HangulKeyboardData(uni: uni, state: lastState)
        
        return hangul
    }
    
    func combineHangulForDelete(buffer: [String], lastState: HangulKeyboardData.HangulState) -> HangulKeyboardData { // 글자 조합해서 방
        if buffer.count == 1 {
            return HangulKeyboardData(char: buffer[0], state: .cho)
            
        } else if buffer.count == 2 {
            
            let cho = HangulSet.chos.firstIndex(of: buffer[0]) ?? 0
            let jung = HangulSet.jungs.firstIndex(of: buffer[1]) ?? 0
            
            let uni =  44032 + cho * 28 * 21 + 28 * jung + 0
            let hangul = HangulKeyboardData(uni: uni, state: lastState)
            
            return hangul
            
        } else {
            
            let cho = HangulSet.chos.firstIndex(of: buffer[0]) ?? 0
            let jung = HangulSet.jungs.firstIndex(of: buffer[1]) ?? 0
            let jong = HangulSet.jongs.firstIndex(of: buffer[2]) ?? 0
            
            let uni =  44032 + cho * 28 * 21 + 28 * jung + jong
            let hangul = HangulKeyboardData(uni: uni, state: lastState)
            
            return hangul
        }
    }
    
    func decomposeHangul(hangul: String, lastState: HangulKeyboardData.HangulState) -> [String] {
        
        let hangulUnicode = hangulConverter.convertStr2Unicode(char: hangul)
        
        let choIndex = (hangulUnicode - 0xAC00) / 588
        
        guard choIndex >= 0 && choIndex < HangulSet.chos.count else {
            if HangulSet.doubleChos.contains(hangul) && lastState == .cho {
                let singleUni = hangulConverter.convertStr2Unicode(char: hangul) - 1
                return [hangulConverter.convertUni2Str(uni: singleUni)]
            }
            return [hangul]
        }
        
        let removeCho = (hangulUnicode - 0xAC00) % 588
        let jungIndex = removeCho / 28
        let jongIndex = (hangulUnicode - 0xAC00) % 28
        
        let cho = HangulSet.chos[choIndex]
        let jung = HangulSet.jungs[jungIndex]
        let jong = decomposeJongs(str: HangulSet.jongs[jongIndex])
        
        return [cho, jung] + jong
    }
    
    func decomposeJongs(str: String) -> [String] {
        guard let idx = HangulSet.doubleJongs.firstIndex(of: str) else {
            return [str]
        }
        return [HangulSet.checkingJongs[idx].0, HangulSet.checkingJongs[idx].1]
    }

}
