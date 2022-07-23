//
//  KeyboardManager.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/19.
//

import Foundation

protocol HangulKeyboardDataReceivable: AnyObject {
    func hangulKeyboard(enterPressed: HangulKeyboardData)
    func hangulKeyboard(updatedResult text: String)
}

class HangulKeyboardManager {
    
    weak var delegate: HangulKeyboardDataReceivable!
    private let keyboardIOManager = KeyboardIOManager()
    private let keyboardMaker = KeyboardMaker()
    
    func enterText(text: String) {
        let keyboardData = keyboardIOManager.stringToKeyboardData(input: text)
        guard !isReturnKeyPressed(inputData: keyboardData) else { return }
        let result = keyboardMaker.insertKeyboardData(data: keyboardData)
        delegate.hangulKeyboard(
            updatedResult: keyboardIOManager.keyboardDataToString(
                outputKeyboardData: result
            )
        )
    }
    
    private func isReturnKeyPressed(inputData: HangulKeyboardData) -> Bool {
        guard inputData.unicode == SpecialCharSet.enter else { return false }
        delegate.hangulKeyboard(enterPressed: inputData)
        return true
    }
}
