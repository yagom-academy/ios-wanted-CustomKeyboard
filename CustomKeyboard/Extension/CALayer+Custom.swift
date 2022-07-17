//
//  CALayer+Custom.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/17.
//

import UIKit

extension CALayer {
    func addBorder( arrEdge: [UIRectEdge],
                    color: UIColor,
                    width: CGFloat) {
        for edge in arrEdge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
            default:
                break
            }
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}
