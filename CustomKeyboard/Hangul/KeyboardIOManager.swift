//
//  KeyboardIOManager.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/19.
//

import Foundation

class KeyboardIOManager {
    
    func stringToKeyboardData(input: String) -> HangulKeyboardData {
        return HangulKeyboardData(char: input, state: .empty)
    }
    
    func keyboardDataToString(outputKeyboardData: [String]) -> String {
        return outputKeyboardData.reduce(into: ""){ $0 += $1 }
    }
}
