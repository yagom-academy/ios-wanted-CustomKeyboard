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
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.alignment = .center
    }
    
    private func setButtons() {
        qButton.setTitle("ㅂ", for: .normal)
        wButton.setTitle("ㅈ", for: .normal)
        eButton.setTitle("ㄷ", for: .normal)
        rButton.setTitle("ㄱ", for: .normal)
        tButton.setTitle("ㅅ", for: .normal)
        yButton.setTitle("ㅛ", for: .normal)
        uButton.setTitle("ㅕ", for: .normal)
        iButton.setTitle("ㅑ", for: .normal)
        oButton.setTitle("ㅐ", for: .normal)
        pButton.setTitle("ㅔ", for: .normal)
    }
    
    private func setLayout() {
        qButton.translatesAutoresizingMaskIntoConstraints = false
        wButton.translatesAutoresizingMaskIntoConstraints = false
        eButton.translatesAutoresizingMaskIntoConstraints = false
        rButton.translatesAutoresizingMaskIntoConstraints = false
        tButton.translatesAutoresizingMaskIntoConstraints = false
        yButton.translatesAutoresizingMaskIntoConstraints = false
        uButton.translatesAutoresizingMaskIntoConstraints = false
        iButton.translatesAutoresizingMaskIntoConstraints = false
        oButton.translatesAutoresizingMaskIntoConstraints = false
        pButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addArrangedSubview(qButton)
        self.addArrangedSubview(wButton)
        self.addArrangedSubview(eButton)
        self.addArrangedSubview(rButton)
        self.addArrangedSubview(tButton)
        self.addArrangedSubview(yButton)
        self.addArrangedSubview(uButton)
        self.addArrangedSubview(iButton)
        self.addArrangedSubview(oButton)
        self.addArrangedSubview(pButton)
    }
    
    private func mathWidth() {
        
    }
}
