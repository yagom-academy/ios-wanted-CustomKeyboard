//
//  KeyboardButton.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/13.
//

import UIKit

class KeyboardButton: UIButton {
    
    var text: String?
    var compatibility: Compatibility
    var isShift: Bool = false {
        willSet {
            setupShiftMode(newValue)
            setupButton()
        }
    }
    
    
    init(
        text: String? = nil,
        compatibility: Compatibility
    ) {
        self.text = text
        self.compatibility = compatibility
        super.init(frame: .zero)
        setupButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        setTitle(text, for: .normal)
        setTitleColor(.label, for: .normal)
        backgroundColor = .white
        layer.cornerRadius = 4.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .init(width: 0.0, height: 1.0)
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0.1
        translatesAutoresizingMaskIntoConstraints = false
        let width = (UIScreen.main.bounds.width - 54.0) / 10
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setupShiftMode(_ isShift: Bool) {
        switch compatibility {
        case .ㄱ:
            if isShift { compatibility = .ㄲ }
        case .ㄲ:
            if !isShift { compatibility = .ㄱ }
        case .ㄷ:
            if isShift { compatibility = .ㄸ }
        case .ㄸ:
            if !isShift { compatibility = .ㄷ }
        case .ㅂ:
            if isShift { compatibility = .ㅃ }
        case .ㅃ:
            if !isShift { compatibility = .ㅂ }
        case .ㅅ:
            if isShift { compatibility = .ㅆ }
        case .ㅆ:
            if !isShift { compatibility = .ㅅ }
        case .ㅈ:
            if isShift { compatibility = .ㅉ }
        case .ㅉ:
            if !isShift { compatibility = .ㅈ }
        case .ㅐ:
            if isShift { compatibility = .ㅒ }
        case .ㅒ:
            if !isShift { compatibility = .ㅐ }
        case .ㅔ:
            if isShift { compatibility = .ㅖ }
        case .ㅖ:
            if !isShift { compatibility = .ㅔ }
        default: break
        }
        text = compatibility.text
    }
}
