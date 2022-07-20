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
    
    lazy var buttons = keyFirstLine.passButtons()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        keyThirdLine.shiftDelegate = self
        
        viewModel.OnTitleUpdate = { subtitle in
            subtitle
        }
        
        viewModel.titleUpdate = {
            
        }
        
        let l = layout
        l()
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
            keyFirstLine.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            
            keySecondLine.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            keySecondLine.topAnchor.constraint(equalTo: keyFirstLine.bottomAnchor, constant: 5),
            keySecondLine.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95),
            keySecondLine.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            
            keyThirdLine.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            keyThirdLine.topAnchor.constraint(equalTo: keySecondLine.bottomAnchor, constant: 5),
            keyThirdLine.widthAnchor.constraint(equalTo: self.widthAnchor),
            keyThirdLine.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            
            keyFourthLine.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            keyFourthLine.topAnchor.constraint(equalTo: keyThirdLine.bottomAnchor, constant: 5),
            keyFourthLine.widthAnchor.constraint(equalTo: self.widthAnchor),
            keyFourthLine.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
        ])
    }
}

extension KeyboardView: ShiftDelegate {
    
    func shiftClickEvent(isShift: Bool) {
        if isShift {
            viewModel.changeShift(buttons)
        } else {
            viewModel.resetShift(buttons)
        }
    }
}
