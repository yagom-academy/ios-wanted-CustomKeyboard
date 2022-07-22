//
//  KeyboardViewModel.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/18.
//

import UIKit

class KeyboardViewModel {
    private let manager = KeyboardManager()
    private var state = 0
    
    private var title = [
        "ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ",
        "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"
    ]
    
    private let titleShift = [
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
    
    func eraseButton(_ reviewTextView: UITextView, _ keyboardView: KeyboardView) {
        let firstLineButtons = keyboardView.keyFirstLine.passButtons()
        keyboardView.keyThirdLine.shiftButton.isSelected = false
        resetShift(firstLineButtons)
        guard let text = reviewTextView.text?.last else {
            return
        }
        
        if state == 3 && reviewTextView.text.count >= 2 {
            let currentText = String(reviewTextView.text.suffix(2))
            reviewTextView.text = String(reviewTextView.text.prefix(reviewTextView.text.count - 2))
            
            let managerString = deleteString(3, currentText)
            reviewTextView.text += managerString.0
            state = managerString.1
        } else {
            reviewTextView.text.removeLast()
            let managerString = deleteString(state, String(text))
            reviewTextView.text += managerString.0
            state = managerString.1
        }
    }
    
    func buttonClick(_ reviewTextView: UITextView, _ keyboardView: KeyboardView, _ sender: KeyButton) {
        let firstLineButtons = keyboardView.keyFirstLine.passButtons()
        guard let text = reviewTextView.text?.last else {
            let managerString = makeString(state, "", sender)
            reviewTextView.text! = managerString.0
            state = managerString.1
            keyboardView.keyThirdLine.shiftButton.isSelected = false
            resetShift(firstLineButtons)
            return
        }
        
        let managerString = makeString(state, String(text), sender)

        if state != 0 && managerString.0 != " " {
            reviewTextView.text.removeLast()
        }
        
        reviewTextView.text! += managerString.0
        state = managerString.1
        
        keyboardView.keyThirdLine.shiftButton.isSelected = false
        resetShift(firstLineButtons)
    }
}
