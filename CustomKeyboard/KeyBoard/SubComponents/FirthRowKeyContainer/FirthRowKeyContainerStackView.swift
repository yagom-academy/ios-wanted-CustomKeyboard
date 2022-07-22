//
//  FirthRowKeyContainer.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/18.
//

import UIKit

final class FirthRowKeyContainerStackView: UIStackView {
    
    // MARK: - Properties
    private let spaceButton = UIButton(type: .system)
    private let returnButton = UIButton(type: .system)
    weak var delegate: FirthRowKeyContainerStackViewDelegate?
    
    private let spaceButtonTitle = "space"
    private let returnButtonTitle = "return"
    
    init() {
        super.init(frame: CGRect.zero)
        
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - @objc Methods
extension FirthRowKeyContainerStackView {
    @objc private func tappedReturnButton() {
        
        delegate?.tappedReturnButton()
    }

    @objc private func tappedSpaceButton(_ sender: UIButton) {
        
        delegate?.tappedSpaceButton(sender.tag)
    }
}

//MARK: - ConfigureUI
extension FirthRowKeyContainerStackView {
    private func configureUI() {
        
        configureAttribute()
        configureLayout()
    }
    
    private func configureAttribute() {
        
        axis = .horizontal
        spacing = 10

        [returnButton].forEach {
            $0.backgroundColor = .systemGray
            $0.setTitleColor(.black, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
        }
        
        spaceButton.setTitle(spaceButtonTitle, for: .normal)
        spaceButton.backgroundColor = .white
        spaceButton.setTitleColor(.black, for: .normal)
        spaceButton.layer.cornerRadius = 10
        spaceButton.tag = Int(UnicodeScalar(" ").value)
        spaceButton.addTarget(self, action: #selector(tappedSpaceButton), for: .touchUpInside)
        
        returnButton.setTitle(returnButtonTitle, for: .normal)
        returnButton.addTarget(self, action: #selector(tappedReturnButton), for: .touchUpInside)
        
        [spaceButton, returnButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: CustomKeyBoardStackView.Math.fontSize, weight: .medium)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.masksToBounds = false
            $0.layer.shadowOffset = CGSize(width: 2, height: 2)
            $0.layer.shadowRadius = 2
            $0.layer.shadowOpacity = 0.5
        }
    }
    
    private func configureLayout() {
        
        let spaceView = UIView()
        [spaceView, spaceButton, returnButton].forEach {
            addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [spaceView, returnButton].forEach {
            $0.widthAnchor.constraint(equalToConstant: CustomKeyBoardStackView.Math.buttonWidth*2.5).isActive = true
        }

    }
}
