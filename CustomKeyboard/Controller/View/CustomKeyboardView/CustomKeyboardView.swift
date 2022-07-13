//
//  CustomKeyboardView.swift
//  CustomKeyboard
//
//  Created by J_Min on 2022/07/12.
//

import UIKit

protocol CustomKeyboardDelegate : AnyObject{
    func hangulKeypadTap()
    func backKeypadTap()
    func enterKeypadTap()
    func spaceKeypadTap()
}

class CustomKeyboardView: UIView {
    
    weak var delegate : CustomKeyboardDelegate?
    
    @IBAction func hangulKeypadTap(_ sender: UIButton) {
        delegate?.hangulKeypadTap()
    }
    
    @IBAction func shiftKeypadTap(_ sender: UIButton) {
        
    }
    
    @IBAction func backKeypadTap(_ sender: UIButton) {
        delegate?.backKeypadTap()
    }
    
    @IBAction func enterKeypadTap(_ sender: UIButton) {
        delegate?.enterKeypadTap()
    }
    
    @IBAction func spaceKeypadTap(_ sender: UIButton) {
        delegate?.spaceKeypadTap()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
