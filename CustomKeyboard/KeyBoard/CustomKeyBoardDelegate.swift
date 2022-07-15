//
//  CustomKeyBoardDelegate.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/13.
//

import UIKit

protocol CustomKeyBoardDelegate: AnyObject {
    func tappedReturnButton()
    func connectTextView() -> UITextView
}
