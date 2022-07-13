//
//  KeyboardIOManager.swift
//  CustomKeyboard
//
//  Created by CHUBBY on 2022/07/13.
//

import Foundation

class KeyboardIOManager {
    var input: String = "" {
        didSet {
            updateTextView(input)
        }
    }
    
    var updateTextView: ((String) -> Void)!

    
}

extension KeyboardIOManager: CustomKeyboardDelegate {
    func hangulKeypadTap(char: String) {
        self.input = char
    }
    
    func backKeypadTap() {
        
    }
    
    func enterKeypadTap() {
        
    }
    
    func spaceKeypadTap() {
        
    }
    
    
}
