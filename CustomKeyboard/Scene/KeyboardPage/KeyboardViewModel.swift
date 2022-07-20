//
//  KeyboardViewModel.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/18.
//

import UIKit

class KeyboardViewModel {
    let manager = KeyboardManager()
    
    var title = [
        "ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ",
        "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"
    ]
    
    let titleShift = [
        "ㅃ", "ㅉ", "ㄸ", "ㄲ", "ㅆ",
        "ㅛ", "ㅕ", "ㅑ", "ㅒ", "ㅖ"
    ]
    
    func changeShift(_ button: [UIButton]) {
        for i in 0..<button.count {
            button[i].setTitle(titleShift[i], for: .normal)
        }
    }
    
    func resetShift(_ button: [UIButton]) {
        for i in 0..<button.count {
            button[i].setTitle(title[i], for: .normal)
        }
    }
    
    func makeString(_ state: Int, _ currentText: String, _ tappedButton: KeyButton) -> (String, Int) {
        return manager.makeString(state, currentText, tappedButton)
    }
    
    func deleteString(_ state: Int, _ currentText: String) -> (String, Int) {
        return manager.deleteString(state, currentText)
    }
}
