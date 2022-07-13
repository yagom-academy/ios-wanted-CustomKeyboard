//
//  KeyFourthLineStackView.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/13.
//

import UIKit

class KeyFourthLineStackView: UIStackView {
    
    let numButton = KeyButton(type: .dark_large)
    let spaceButton = KeyButton(type: .space)
    let returnButton = KeyButton(type: .dark_large)
    
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
        self.distribution = .equalSpacing
        self.alignment = .fill
        self.spacing = 10
    }
    
    private func setButtons() {
        numButton.setTitle("123", for: .normal)
        spaceButton.setTitle("space", for: .normal)
        returnButton.setTitle("↵", for: .normal)
    }
    
    private func setLayout() {
        numButton.translatesAutoresizingMaskIntoConstraints = false
        spaceButton.translatesAutoresizingMaskIntoConstraints = false
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addArrangedSubview(numButton)
        self.addArrangedSubview(spaceButton)
        self.addArrangedSubview(returnButton)
        
        NSLayoutConstraint.activate([
            numButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            spaceButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.55),
            returnButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
    }
}
