//
//  CALayer+Custom.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/17.
//

import UIKit

extension CALayer {
    func addBorder(rectEdge: [UIRectEdge], color: UIColor, width: CGFloat) {
        
        for edge in rectEdge {
            let border = CALayer()
            if edge == .bottom {
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
            }
            border.backgroundColor = color.cgColor
            addSublayer(border)
        }
    }
}
