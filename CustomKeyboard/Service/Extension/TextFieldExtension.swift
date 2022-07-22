//
//  TextFieldExtension.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit

class BasePaddingTextView: UITextView {
    override var contentSize: CGSize {
        didSet {
            var topCorrection = (bounds.size.height - contentSize.height) / 2.0
            topCorrection = max(0, topCorrection)
            contentInset = UIEdgeInsets(
                top: topCorrection,
                left: 10,
                bottom: 0,
                right: 10
            )
        }
    }
    
    private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect.inset(by: padding))
    }
}
