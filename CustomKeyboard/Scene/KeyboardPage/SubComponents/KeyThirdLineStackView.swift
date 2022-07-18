//
//  KeyThirdLineStackView.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/13.
//

import UIKit

class KeyThirdLineStackView: UIStackView {
    
    var delegate: ButtonDelegate?
    
    let shiftButton = KeyButton(type: .dark_small)
    let zButton = KeyButton(type: .consonant)
    let xButton = KeyButton(type: .consonant)
    let cButton = KeyButton(type: .consonant)
    let vButton = KeyButton(type: .consonant)
    let bButton = KeyButton(type: .vowel)
    let nButton = KeyButton(type: .vowel)
    let mButton = KeyButton(type: .vowel)
    let eraseButton = KeyButton(type: .dark_small)
    
    init() {
        super.init(frame: .zero)
        
        configureProperties()
        setButtons()
        setLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureProperties() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = 10
    }
    
    private func setButtons() {
        let button = [
            shiftButton, zButton, xButton, cButton, vButton,
            bButton, nButton, mButton, eraseButton
        ]
        let title = [
            "⇧", "ㅋ", "ㅌ", "ㅊ", "ㅍ",
            "ㅠ", "ㅜ", "ㅡ", "⌫"
        ]
        
        for i in 0..<button.count {
            button[i].setTitle(title[i], for: .normal)
            if button[i].type != .dark_small {
                button[i].addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
            }
        }
        
        
    }
    
    @objc private func tapButton(sender: KeyButton) {
        delegate?.buttonClickEvent(sender: sender)
    }
    
    private func setLayout() {
        [
            shiftButton, zButton, xButton,
            cButton, vButton, bButton,
            nButton, mButton, eraseButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
    }
}
