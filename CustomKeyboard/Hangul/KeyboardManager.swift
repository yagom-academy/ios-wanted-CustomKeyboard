//
//  KeyboardManager.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/19.
//

import Foundation

class KeyboardManager {
    
    var keyboardMaker = KeyboardMaker()
    
    func enterText(text: String) -> String {
        return keyboardMaker.putHangul(input: text)
    }
    
}
