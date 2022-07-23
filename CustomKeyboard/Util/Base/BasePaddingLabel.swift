//
//  BasePaddingLabel.swift
//  CustomKeyboard
//
//  Created by 이윤주 on 2022/07/13.
//

import UIKit

final class BasePaddingLabel: UILabel {

    var padding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }

}
