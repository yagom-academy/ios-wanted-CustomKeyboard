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
        shiftButton.setTitle("⇧", for: .normal)
        zButton.setTitle("ㅋ", for: .normal)
        xButton.setTitle("ㅌ", for: .normal)
        cButton.setTitle("ㅊ", for: .normal)
        vButton.setTitle("ㅍ", for: .normal)
        bButton.setTitle("ㅠ", for: .normal)
        nButton.setTitle("ㅜ", for: .normal)
        mButton.setTitle("ㅡ", for: .normal)
        eraseButton.setTitle("⌫", for: .normal)
    }
    
    private func setLayout() {
        shiftButton.translatesAutoresizingMaskIntoConstraints = false
        zButton.translatesAutoresizingMaskIntoConstraints = false
        xButton.translatesAutoresizingMaskIntoConstraints = false
        cButton.translatesAutoresizingMaskIntoConstraints = false
        vButton.translatesAutoresizingMaskIntoConstraints = false
        bButton.translatesAutoresizingMaskIntoConstraints = false
        nButton.translatesAutoresizingMaskIntoConstraints = false
        mButton.translatesAutoresizingMaskIntoConstraints = false
        eraseButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addArrangedSubview(shiftButton)
        self.addArrangedSubview(zButton)
        self.addArrangedSubview(xButton)
        self.addArrangedSubview(cButton)
        self.addArrangedSubview(vButton)
        self.addArrangedSubview(bButton)
        self.addArrangedSubview(nButton)
        self.addArrangedSubview(mButton)
        self.addArrangedSubview(eraseButton)
    }
}
