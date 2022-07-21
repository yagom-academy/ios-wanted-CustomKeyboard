//
//  KeyFourthLineStackView.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/13.
//

import UIKit

class KeyFourthLineStackView: UIStackView {
    
    weak var delegate: ButtonDelegate?
    
    let numButton = KeyButton(type: .dark)
    let spaceButton = KeyButton(type: .space)
    let returnButton = KeyButton(type: .dark)
    
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
        let button = [
            numButton, spaceButton, returnButton
        ]
        let title = [
            "123", "space", "↵"
        ]
        
        for i in 0..<button.count {
            button[i].setTitle(title[i], for: .normal)
            if button[i].type == .space {
                button[i].addTarget(self, action: #selector(tapButton(sender:)), for: .touchUpInside)
            }
        }
    }
    
    @objc private func tapButton(sender: KeyButton) {
        delegate?.buttonClickEvent(sender: sender)
    }
    
    private func setLayout() {
        [
            numButton,
            spaceButton,
            returnButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            numButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            spaceButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.55),
            returnButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
    }
}
