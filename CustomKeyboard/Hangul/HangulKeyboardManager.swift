//
//  KeyboardManager.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/19.
//

import Foundation

protocol HangulKeyboardDataReceivable {
    func hangulKeyboard(enterPressed: HangulKeyboardData)
    func hangulKeyboard(updatedResult text: String)
}

class HangulKeyboardManager {
    
    var delegate: HangulKeyboardDataReceivable!
    private let keyboardIOManager = KeyboardIOManager()
    private let keyboardMaker = KeyboardMaker()
    
    func enterText(text: String) {
        let keyboardData = keyboardIOManager.stringToKeyboardData(input: text)
        guard !isEnter(inputData: keyboardData) else { return }
        let result = keyboardMaker.putKeyboardData(data: keyboardData)
        delegate.hangulKeyboard(
            updatedResult: keyboardIOManager.keyboardDataToString(
                outputKeyboardData: result
            )
        )
    }
    
    private func isEnter(inputData: HangulKeyboardData) -> Bool {
        guard inputData.unicode == SpecialCharSet.enter else { return false }
        delegate.hangulKeyboard(enterPressed: inputData)
        return true
    }
}
