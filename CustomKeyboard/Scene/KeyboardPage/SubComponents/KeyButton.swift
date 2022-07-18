//
//  KeyButton.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import UIKit

public enum CSButtonType {
    case consonant
    case vowel
    case space
    case shift
    case dark
}

class KeyButton: UIButton {
    
    let type: CSButtonType
    
    init(type: CSButtonType) {
        self.type = type
        super.init(frame: .zero)
        
        switch self.type {
        case .consonant, .vowel, .space:
            self.backgroundColor = .systemGray2
        case .shift, .dark:
            self.backgroundColor = .systemGray
        }
        
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
}
