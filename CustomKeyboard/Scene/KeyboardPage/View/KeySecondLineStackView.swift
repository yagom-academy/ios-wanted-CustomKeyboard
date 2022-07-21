//
//  KeySecondLineStackView.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/13.
//

import UIKit

class KeySecondLineStackView: UIStackView {
    
    weak var delegate: ButtonDelegate?
    
    let aButton = KeyButton(type: .consonant)
    let sButton = KeyButton(type: .consonant)
    let dButton = KeyButton(type: .consonant)
    let fButton = KeyButton(type: .consonant)
    let gButton = KeyButton(type: .consonant)
    let hButton = KeyButton(type: .vowel)
    let jButton = KeyButton(type: .vowel)
    let kButton = KeyButton(type: .vowel)
    let lButton = KeyButton(type: .vowel)
    
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
            aButton, sButton, dButton, fButton, gButton,
            hButton, jButton, kButton, lButton
        ]
        let title = [
            "ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ",
            "ㅗ", "ㅓ", "ㅏ", "ㅣ"
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
            aButton, sButton, dButton,
            fButton, gButton, hButton,
            jButton, kButton, lButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
    }
}
