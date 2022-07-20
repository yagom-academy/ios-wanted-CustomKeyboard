//
//  KeyboardIOManager.swift
//  CustomKeyboard
//
//  Created by CHUBBY on 2022/07/13.
//

import Foundation

final class KeyboardIOManager {
    
    private var hangulAutomata = HangulAutomata()
    
    private var input: String = "" {
        didSet {
            if input == " " {
                hangulAutomata.buffer.append(" ")
                hangulAutomata.inpStack.removeAll()
                hangulAutomata.currentHangulState = nil
            } else {
                hangulAutomata.hangulAutomata(key: input)
            }
            updateTextView(hangulAutomata.buffer.reduce("", { $0 + $1 }))
        }
    }
    
    var updateTextView: ((String) -> Void)!
    var dismiss: (() -> Void)?
    
}

extension KeyboardIOManager: CustomKeyboardDelegate {
    func hangulKeypadTap(char: String) {
        self.input = char
    }
    
    func backKeypadTap() {
        hangulAutomata.deleteBuffer()
        updateTextView(hangulAutomata.buffer.reduce("", { $0 + $1 }))
    }
    
    func enterKeypadTap() {
        dismiss?()
    }
    
    func spaceKeypadTap() {
        self.input = " "
    }
    
    
}
