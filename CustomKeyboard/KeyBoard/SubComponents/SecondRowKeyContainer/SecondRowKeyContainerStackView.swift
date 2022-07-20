//
//  SecondRowKeyContainer.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/18.
//

import UIKit

final class SecondRowKeyContainerStackView: UIStackView {
    
    // MARK: - Properties
    private let secondLineBasicKeys = BasicKeyLine(keys: ["ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ"])

    weak var delegate: SecondRowKeyContainerDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SecondRowKeyContainerStackView: BasicKeyLineDelegate {
    func tappedBasicKeyButton(unicode: Int) {
        
        delegate?.tappedSecondrowBasicKey(unicode: unicode)
    }
}

// MARK: - ConfigureUI
extension SecondRowKeyContainerStackView {
    
    private func configureUI() {
        
        configureAttribute()
        configureLayout()
    }
    
    private func configureAttribute() {
        
        secondLineBasicKeys.delegate = self
        axis = .horizontal
        distribution = .equalSpacing
    }
    
    private func configureLayout() {
        
        [UIView(), secondLineBasicKeys, UIView()].forEach {
            addArrangedSubview($0)
        }
        secondLineBasicKeys.translatesAutoresizingMaskIntoConstraints = false
        secondLineBasicKeys.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -CustomKeyBoardStackView.Math.buttonWidth).isActive = true
    }
}
