//
//  UIButton+.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/15.
//

import UIKit

extension UIButton {
    func setupUtilButton(_ title: String, target: Any?, action: Selector) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.label, for: .normal)
        self.addTarget(target, action: action, for: .touchUpInside)
        self.backgroundColor = .white
        self.layer.cornerRadius = 4.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = .init(width: 0.0, height: 1.0)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.1
        self.layer.cornerRadius = 5
    }
}
