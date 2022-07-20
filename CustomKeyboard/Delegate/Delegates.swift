//
//  ButtonDelegate.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/13.
//

import UIKit

protocol PassContentDelegate: AnyObject {
    func sendReviewData(content: String)
}

protocol ButtonDelegate: AnyObject {
    func buttonClickEvent(sender: KeyButton)
    func eraseButtonClickEvent(sender: KeyButton)
}

protocol ShiftDelegate: AnyObject {
    func shiftClickEvent(isShift: Bool)
}

protocol AnyButtonDelegate {
    func anyButtonClickEvent(sender: KeyButton)
}
