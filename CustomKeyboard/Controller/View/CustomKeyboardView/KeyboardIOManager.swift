//
//  KeyboardIOManager.swift
//  CustomKeyboard
//
//  Created by CHUBBY on 2022/07/13.
//

import Foundation

class KeyboardIOManager {
    
    var hangulAutomata = HangulAutomata()
    
    var input: String = "" {
        didSet {
            if input == " "{
                hangulAutomata.buffer.append(" ")
                hangulAutomata.cursor += 1
                hangulAutomata.inpStack.removeAll()
                hangulAutomata.inpSP = 0
                hangulAutomata.currentHangulState = nil
            }else{
                hangulAutomata.hangulAutomata(key: input)
            }
            updateTextView(hangulAutomata.buffer.reduce("", { $0 + $1}))
        }
    }
    
    var updateTextView: ((String) -> Void)!

    
}

extension KeyboardIOManager: CustomKeyboardDelegate {
    func hangulKeypadTap(char: String) {
        self.input = char
    }
    
    func backKeypadTap() {
        hangulAutomata.deleteBuffer()
        updateTextView(hangulAutomata.buffer.reduce("", { $0 + $1}))
    }
    
    func enterKeypadTap() {
        
    }
    
    func spaceKeypadTap() {
        self.input = " "
    }
    
    
}
