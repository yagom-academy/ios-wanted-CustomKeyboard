//
//  ButtonDelegate.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/13.
//

import UIKit

protocol ButtonDelegate {
    func buttonClickEvent(sender: KeyButton)
    func eraseButtonClickEvent(sender: KeyButton)
}
