//
//  KeyFirstLineStackView.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import UIKit

class KeyFirstLineStackView: UIStackView {
    
    let width: Float = 0
    
    let qButton = KeyButton(type: .basic)
    let wButton = KeyButton(type: .basic)
    let eButton = KeyButton(type: .basic)
    let rButton = KeyButton(type: .basic)
    let tButton = KeyButton(type: .basic)
    let yButton = KeyButton(type: .basic)
    let uButton = KeyButton(type: .basic)
    let iButton = KeyButton(type: .basic)
    let oButton = KeyButton(type: .basic)
    let pButton = KeyButton(type: .basic)
    
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
            qButton, wButton, eButton, rButton, tButton,
            yButton, uButton, iButton, oButton, pButton
        ]
        let title = [
            "ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ",
            "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"
        ]
        
        for i in 0..<button.count {
            button[i].setTitle(title[i], for: .normal)
        }
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
