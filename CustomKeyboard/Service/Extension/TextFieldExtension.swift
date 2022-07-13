//
//  TextFieldExtension.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit


class TextField: UITextField {
    private let padding = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

