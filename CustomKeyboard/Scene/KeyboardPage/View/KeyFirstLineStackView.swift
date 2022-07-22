//
//  KeyFirstLineStackView.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import UIKit

class KeyFirstLineStackView: UIStackView {
    weak var delegate: ButtonDelegate?
    
    let qButton = KeyButton(type: .consonant)
    let wButton = KeyButton(type: .consonant)
    let eButton = KeyButton(type: .consonant)
    let rButton = KeyButton(type: .consonant)
    let tButton = KeyButton(type: .consonant)
    let yButton = KeyButton(type: .vowel)
    let uButton = KeyButton(type: .vowel)
    let iButton = KeyButton(type: .vowel)
    let oButton = KeyButton(type: .vowel)
    let pButton = KeyButton(type: .vowel)
    
    init() {
        super.init(frame: .zero)
        
        configureProperties()
        setButtons()
        setLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func passButtons() -> [UIButton] {
        let button = [
            qButton, wButton, eButton, rButton, tButton,
            yButton, uButton, iButton, oButton, pButton
        ]
        
        return button
    }
    
    private func configureProperties() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.alignment = .fill
        self.spacing = 10
    }
    
    private func setButtons() {
        let button = [
            qButton, wButton, eButton, rButton, tButton,
            yButton, uButton, iButton, oButton, pButton
        ]
        
        let title = [
            "ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ",
            "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"
        ]
        
        for i in 0..<button.count {
            button[i].setTitle(title[i], for: .normal)
            button[i].addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
        }
    }
    
    @objc private func tapButton(sender: KeyButton) {
        delegate?.buttonClickEvent(sender: sender)
    }
    
    private func setLayout() {
        [
            qButton, wButton, eButton,
            rButton, tButton, yButton,
            uButton, iButton, oButton,
            pButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
    }
}
