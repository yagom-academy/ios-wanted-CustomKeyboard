//
//  TextFieldExtension.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit


class TextField: UITextField {
    private let padding = UIEdgeInsets(top: 3, left: 10, bottom: 3, right: 10)
    
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


class BasePaddingTextView: UITextView {
    
    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(top: topCorrection, left: 10, bottom: 0, right: 10)
        }
    }
    
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect.inset(by: padding))
    }
}
