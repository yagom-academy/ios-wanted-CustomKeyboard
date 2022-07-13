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
        aButton.setTitle("ㅁ", for: .normal)
        sButton.setTitle("ㄴ", for: .normal)
        dButton.setTitle("ㅇ", for: .normal)
        fButton.setTitle("ㄹ", for: .normal)
        gButton.setTitle("ㅎ", for: .normal)
        hButton.setTitle("ㅗ", for: .normal)
        jButton.setTitle("ㅓ", for: .normal)
        kButton.setTitle("ㅏ", for: .normal)
        lButton.setTitle("ㅣ", for: .normal)
    }
    
    private func setLayout() {
        aButton.translatesAutoresizingMaskIntoConstraints = false
        sButton.translatesAutoresizingMaskIntoConstraints = false
        dButton.translatesAutoresizingMaskIntoConstraints = false
        fButton.translatesAutoresizingMaskIntoConstraints = false
        gButton.translatesAutoresizingMaskIntoConstraints = false
        hButton.translatesAutoresizingMaskIntoConstraints = false
        jButton.translatesAutoresizingMaskIntoConstraints = false
        kButton.translatesAutoresizingMaskIntoConstraints = false
        lButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addArrangedSubview(aButton)
        self.addArrangedSubview(sButton)
        self.addArrangedSubview(dButton)
        self.addArrangedSubview(fButton)
        self.addArrangedSubview(gButton)
        self.addArrangedSubview(hButton)
        self.addArrangedSubview(jButton)
        self.addArrangedSubview(kButton)
        self.addArrangedSubview(lButton)
    }
}
