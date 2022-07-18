//
//  ButtonDelegate.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/13.
//

import UIKit

protocol PassContentDelegate {
    func sendReviewData(content: String)
}

protocol ButtonDelegate {
    func buttonClickEvent(sender: KeyButton)
}

protocol ShiftDelegate {
    func shiftClickEvent(isShift: Bool)
}

protocol AnyButtonDelegate {
    func anyButtonClickEvent(sender: KeyButton)
}
