//
//  KeySecondLineStackView.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/13.
//

import UIKit

class KeySecondLineStackView: UIStackView {
    
    let aButton = KeyButton(type: .basic)
    let sButton = KeyButton(type: .basic)
    let dButton = KeyButton(type: .basic)
    let fButton = KeyButton(type: .basic)
    let gButton = KeyButton(type: .basic)
    let hButton = KeyButton(type: .basic)
    let jButton = KeyButton(type: .basic)
    let kButton = KeyButton(type: .basic)
    let lButton = KeyButton(type: .basic)
    
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
        }
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
