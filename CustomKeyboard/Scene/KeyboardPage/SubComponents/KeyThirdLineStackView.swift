//
//  KeyThirdLineStackView.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/13.
//

import UIKit

class KeyThirdLineStackView: UIStackView {
    
    let shiftButton = KeyButton(type: .dark_small)
    let zButton = KeyButton(type: .basic)
    let xButton = KeyButton(type: .basic)
    let cButton = KeyButton(type: .basic)
    let vButton = KeyButton(type: .basic)
    let bButton = KeyButton(type: .basic)
    let nButton = KeyButton(type: .basic)
    let mButton = KeyButton(type: .basic)
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
        }
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
