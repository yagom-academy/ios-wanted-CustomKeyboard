//
//  KeyButton.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import UIKit

public enum CSButtonType {
    case basic
    case space
    case dark_small
    case dark_large
}

class KeyButton: UIButton {
    
    var delegate: ButtonEventDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        setTitleColor(.white, for: .normal)
        
        let buttonConstraints = [
            heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    convenience init(type: CSButtonType) {
        self.init()
        
        switch type {
        case .basic:
            self.backgroundColor = .systemGray3
        case .space:
            self.backgroundColor = .systemGray3
        case .dark_small:
            self.backgroundColor = .systemGray2
        case .dark_large:
            self.backgroundColor = .systemGray2
        }
    }
}
