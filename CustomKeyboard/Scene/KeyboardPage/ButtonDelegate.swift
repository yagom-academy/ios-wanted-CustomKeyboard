//
//  ButtonDelegate.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/13.
//

import UIKit

protocol ButtonEventDelegate {
    func frontButtonClickEvent(sender: UIButton)
    func middleButtonClickEvent(sender: UIButton)
    func endButtonClickEvent(sender: UIButton)
}

class ButtonDelegate {
    /*
    var delegate: ButtonEventDelegate?
    
    @objc func frontButtonClicked(sender: UIButton) {
        delegate?.frontButtonClickEvent(sender: sender)
    }
    
    @objc func middleButtonClicked(sender: UIButton) {
        delegate?.middleButtonClickEvent(sender: sender)
    }
    
    @objc func endButtonClicked(sender: UIButton) {
        delegate?.endButtonClickEvent(sender: sender)
    }
     */
}
