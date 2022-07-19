//
//  KeyboardManager.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/19.
//

import Foundation

protocol KeyboardStatusReceivable {
    func keyboard(pressedEnter: String)
}

class KeyboardManager {
    
    let keyboardIOManager = KeyboardIOManager()
    var keyboardMaker = KeyboardMaker()
    
    func enterText(text: String) -> String {
        
        let keyboardData = keyboardIOManager.stringToKeyboardData(input: text)
        return keyboardMaker.putKeyboardData(data: keyboardData)
    }
    
}
