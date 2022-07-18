//
//  FirthRowKeyContainer.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/18.
//

import UIKit

class FirthRowKeyContainer: UIStackView {
    private let spaceButton = UIButton()
    private let returnButton = UIButton()
    
    weak var delegate: FirthRowKeyContainerDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        
        attribute()
        layout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tappedReturnButton() {
        delegate?.tappedReturnButton()
    }

    @objc private func tappedSpaceButton(_ sender: UIButton) {
        delegate?.tappedSpaceButton(sender.tag)
    }
}

//MARK: - attribute, layout 메서드
extension FirthRowKeyContainer {
    private func attribute() {
        self.axis = .horizontal
        self.spacing = 10

        
        [returnButton].forEach {
            $0.backgroundColor = .systemGray
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
        }
        
        spaceButton.setTitle("space", for: .normal)
        spaceButton.backgroundColor = .white
        spaceButton.setTitleColor(.black, for: .normal)
        spaceButton.layer.cornerRadius = 10
        spaceButton.tag = Int(UnicodeScalar(" ").value)
        spaceButton.addTarget(self, action: #selector(tappedSpaceButton), for: .touchUpInside)
        
        returnButton.setTitle("return", for: .normal)
        returnButton.addTarget(self, action: #selector(tappedReturnButton), for: .touchUpInside)
        
        [spaceButton, returnButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: CustomKeyBoard.Math.fontSize)
        }
    }
    
    private func layout() {
        let spaceView = UIView()
        [spaceView, spaceButton, returnButton].forEach {
            self.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [spaceView, returnButton].forEach {
            $0.widthAnchor.constraint(equalToConstant: CustomKeyBoard.Math.buttonWidth*2.5).isActive = true
        }

    }
}
