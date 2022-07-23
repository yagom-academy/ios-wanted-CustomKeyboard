//
//  KeyboardView.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/13.
//

import UIKit

class KeyboardView: UIView {
    let viewModel = KeyboardViewModel()
    
    let keyFirstLine = KeyFirstLineStackView()
    let keySecondLine = KeySecondLineStackView()
    let keyThirdLine = KeyThirdLineStackView()
    let keyFourthLine = KeyFourthLineStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension KeyboardView {
    
    private func layout() {
        [
            keyFirstLine,
            keySecondLine,
            keyThirdLine,
            keyFourthLine
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            keyFirstLine.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            keyFirstLine.topAnchor.constraint(equalTo: self.topAnchor),
            keyFirstLine.widthAnchor.constraint(equalTo: self.widthAnchor),
            keyFirstLine.heightAnchor.constraint(equalToConstant: 50),
            
            keySecondLine.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            keySecondLine.topAnchor.constraint(equalTo: keyFirstLine.bottomAnchor, constant: 5),
            keySecondLine.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            keySecondLine.heightAnchor.constraint(equalToConstant: 50),
            
            keyThirdLine.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            keyThirdLine.topAnchor.constraint(equalTo: keySecondLine.bottomAnchor, constant: 5),
            keyThirdLine.widthAnchor.constraint(equalTo: self.widthAnchor),
            keyThirdLine.heightAnchor.constraint(equalToConstant: 50),
            
            keyFourthLine.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            keyFourthLine.topAnchor.constraint(equalTo: keyThirdLine.bottomAnchor, constant: 5),
            keyFourthLine.widthAnchor.constraint(equalTo: self.widthAnchor),
            keyFourthLine.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
