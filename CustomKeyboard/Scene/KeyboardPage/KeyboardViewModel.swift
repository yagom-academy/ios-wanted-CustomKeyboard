//
//  KeyboardViewModel.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/18.
//

import UIKit

class KeyboardViewModel {
    let title = [
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
}
