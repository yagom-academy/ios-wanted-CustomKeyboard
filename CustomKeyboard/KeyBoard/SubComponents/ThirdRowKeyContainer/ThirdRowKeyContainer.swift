//
//  ThirdRowKeyContainer.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/18.
//

import UIKit

final class ThirdRowKeyContainer: UIStackView {
    
    // MARK: - Properties
    private let shiftButton = UIButton(type: .system)
    private let thirdLineBasicKeys = BasicKeyLine(keys: ["ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ"])
    private let backButton = UIButton(type: .system)
    weak var delegate: ThirdRowKeyContainerDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ThirdRowKeyContainer: BasicKeyLineDelegate {
    func tappedBasicKeyButton(unicode: Int) {
        
        delegate?.tappedThirdrowBasicKey(unicode: unicode)
    }
    
    
}

//MARK: - @objc Methods
extension ThirdRowKeyContainer {
    @objc private func tappedShiftButton() {
        guard let resultTappedShiftButton = delegate?.tappedShiftButton() else { return }
        toggleShiftButtonState(resultTappedShiftButton)
    }
    
    private func toggleShiftButtonState(_ isSelected: Bool) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            if isSelected == true {
                self?.shiftButton.backgroundColor = .white
                self?.shiftButton.setTitleColor(.black, for: .normal)
            } else {
                self?.shiftButton.backgroundColor = .systemGray
                self?.shiftButton.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    @objc private func tappedBackButton() {
        
        delegate?.tappedBackButton()
    }
}

extension ThirdRowKeyContainer {
    private func configureUI() {
        
        configureAttribute()
        configureLayout()
    }
    
    private func configureAttribute() {
        
        self.axis = .horizontal
        self.distribution = .equalSpacing
        
        thirdLineBasicKeys.delegate = self
        
        shiftButton.setTitle("shift", for: .normal)
        shiftButton.addTarget(self, action: #selector(tappedShiftButton), for: .touchUpInside)
        
        backButton.setTitle("back", for: .normal)
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        
        [shiftButton, backButton].forEach {
            $0.backgroundColor = .systemGray
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.titleLabel?.font = .systemFont(ofSize: CustomKeyBoard.Math.fontSize, weight: .medium)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.masksToBounds = false
            $0.layer.shadowOffset = CGSize(width: 2, height: 2)
            $0.layer.shadowRadius = 2
            $0.layer.shadowOpacity = 0.5
        }
    }
    
    private func configureLayout() {
        
        [shiftButton, thirdLineBasicKeys, backButton].forEach {
            self.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        thirdLineBasicKeys.widthAnchor.constraint(equalToConstant: CustomKeyBoard.Math.keyboardWidth-CustomKeyBoard.Math.buttonWidth*3-CustomKeyBoard.Math.buttonPadding*4).isActive = true
        [shiftButton, backButton].forEach {
            $0.widthAnchor.constraint(equalToConstant: CustomKeyBoard.Math.buttonWidth*1.5).isActive = true
        }
    }
}
