//
//  UIButton+.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/15.
//

import UIKit

extension UIButton {
    func setupUtilButton(
        _ title: String,
        target: Any?,
        touchUpAction: Selector,
        touchDownAction: Selector
    ) {
        setTitle(title, for: .normal)
        setTitleColor(.label, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 20.0, weight: .regular)
        addTarget(target, action: touchUpAction, for: .touchUpInside)
        addTarget(target, action: touchDownAction, for: .touchDown)
        backgroundColor = .systemBackground
        layer.cornerRadius = 4.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.4
        layer.shadowOffset = .init(width: 0.0, height: 1.0)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.1
        layer.cornerRadius = 5
    }
}
