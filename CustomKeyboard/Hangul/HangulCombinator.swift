//
//  HangulCombinator.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/19.
//

import Foundation

class HangulCombinator {
    
    func combineHangul(buffer: [HangulKeyboardData], lastState: HangulKeyboardData.HangulState) -> HangulKeyboardData {
        if lastState == .cho && buffer[1].hangul == "" && buffer[2].hangul == "" {
            return buffer[0]
        } else if lastState == .doubleCho && buffer[1].hangul == "" && buffer[2].hangul == "" {
            return buffer[0]
        } else if (lastState == .jung || lastState == .doubleJung) && buffer[0].hangul == "" && buffer[2].hangul == "" {
            return buffer[1]
        }
        
        guard buffer[0].hangul != "" && buffer[1].hangul != "" else {
            return HangulKeyboardData(char: "", state: lastState)
        }
        
        //TODO: - 한글set에 해당 unicode가 없을경우 예외처리 해야함
        let cho = HangulSet.chos.firstIndex(of: buffer[0].hangul) ?? 0
        let jung = HangulSet.jungs.firstIndex(of: buffer[1].hangul) ?? 0
        
        if buffer.count < 3 {
            let uni =  44032 + cho * 28 * 21 + 28 * jung + 0
            let hangul = HangulKeyboardData(uni: uni, state: lastState)
            return hangul
        }
        
        let jong = HangulSet.jongs.firstIndex(of: buffer[2].hangul) ?? 0
        let uni =  44032 + cho * 28 * 21 + 28 * jung + jong
        let hangul = HangulKeyboardData(uni: uni, state: lastState)
        return hangul
    }
    
    func combineHangulForDelete(buffer: [HangulKeyboardData], lastState: HangulKeyboardData.HangulState) -> HangulKeyboardData {
        if buffer.count == 1 {
            return HangulKeyboardData(char: buffer[0].hangul, state: .cho)
        } else if buffer.count == 2 {
            let cho = HangulSet.chos.firstIndex(of: buffer[0].hangul) ?? 0
            let jung = HangulSet.jungs.firstIndex(of: buffer[1].hangul) ?? 0
            let uni =  44032 + cho * 28 * 21 + 28 * jung + 0
            let hangul = HangulKeyboardData(uni: uni, state: lastState)
            return hangul
        } else {
            let cho = HangulSet.chos.firstIndex(of: buffer[0].hangul) ?? 0
            let jung = HangulSet.jungs.firstIndex(of: buffer[1].hangul) ?? 0
            let jong = HangulSet.jongs.firstIndex(of: buffer[2].hangul) ?? 0
            let uni =  44032 + cho * 28 * 21 + 28 * jung + jong
            let hangul = HangulKeyboardData(uni: uni, state: lastState)
            return hangul
        }
    }
    
    func decomposeHangul(hangul: String, lastState: HangulKeyboardData.HangulState) -> [HangulKeyboardData] {
        let keyboardData = HangulKeyboardData(char: hangul, state: lastState)
        let hangulUnicode = keyboardData.unicode
        
        if HangulSet.chos.contains(keyboardData.hangul) {
            if HangulSet.doubleChos.contains(keyboardData.hangul) {
                return [HangulKeyboardData(uni: keyboardData.unicode - 1, state: .cho),HangulKeyboardData(uni: keyboardData.unicode - 1, state: .cho)]
            }
            return [keyboardData]
        } else if HangulSet.jungs.contains(keyboardData.hangul) {
            return decomposeJungs(str: keyboardData.hangul)
        }
        
        let choIndex = (hangulUnicode - 0xAC00) / 588
        let removeCho = (hangulUnicode - 0xAC00) % 588
        let jungIndex = removeCho / 28
        let jongIndex = (hangulUnicode - 0xAC00) % 28
        
        if jongIndex != 0 {
            let cho = HangulKeyboardData(char: HangulSet.chos[choIndex], state: .cho)
            let jung = HangulKeyboardData(char: HangulSet.jungs[jungIndex], state: .jung)
            let jong = decomposeJongs(str: HangulSet.jongs[jongIndex])
            return [cho, jung] + jong
        } else if jongIndex == 0 {
            let cho = HangulKeyboardData(char: HangulSet.chos[choIndex], state: .cho)
            let jung = decomposeJungs(str: HangulSet.jungs[jungIndex])
            return [cho] + jung
        }
        return []
    }
    
    func decomposeForCompletedHangul(hangul: String, lastState: HangulKeyboardData.HangulState) -> [HangulKeyboardData] {
        let keyboardData = HangulKeyboardData(char: hangul, state: lastState)
        let hangulUnicode = keyboardData.unicode
        
        let choIndex = (hangulUnicode - 0xAC00) / 588
        let removeCho = (hangulUnicode - 0xAC00) % 588
        let jungIndex = removeCho / 28
        let jongIndex = (hangulUnicode - 0xAC00) % 28
        guard 0...HangulSet.chos.count ~= choIndex else {
            if HangulSet.doubleChos.contains(keyboardData.hangul) {
                return [HangulKeyboardData(uni: keyboardData.unicode - 1, state: .cho),HangulKeyboardData(uni: keyboardData.unicode - 1, state: .cho)]
            } else {
                return [keyboardData]
            }
        }
        let cho = HangulKeyboardData(char: HangulSet.chos[choIndex], state: .cho)
        let jung = HangulKeyboardData(char: HangulSet.jungs[jungIndex], state: .jung)
        let jong = HangulKeyboardData(char: HangulSet.jongs[jongIndex], state: .jong)
        return [cho, jung, jong]
    }
    
    func decomposeJongs(str: String) -> [HangulKeyboardData] {
        guard let idx = HangulSet.doubleJongs.firstIndex(of: str) else {
            let newHangulData = HangulKeyboardData(char: str, state: .jong)
            return [newHangulData]
        }
        return [HangulKeyboardData(char: HangulSet.checkingJongs[idx].0, state: .jong), HangulKeyboardData(char: HangulSet.checkingJongs[idx].1, state: .jong)]
    }
    
    func decomposeJungs(str: String) -> [HangulKeyboardData] {
        if let idx = HangulSet.tripleJungs.firstIndex(of: str) {
            return [HangulKeyboardData(char: HangulSet.checkingTripleJungs[idx].0, state: .jung), HangulKeyboardData(char: HangulSet.checkingTripleJungs[idx].1, state: .doubleJung)]
        }
        if let idx = HangulSet.doubleJungs.firstIndex(of: str) {
            return [HangulKeyboardData(char: HangulSet.checkingDoubleJungs[idx].0, state: .cho), HangulKeyboardData(char: HangulSet.checkingJongs[idx].1, state: .jung)]
        }
        let newHangulData = HangulKeyboardData(char: str, state: .jung)
        return [newHangulData]
    }
}
