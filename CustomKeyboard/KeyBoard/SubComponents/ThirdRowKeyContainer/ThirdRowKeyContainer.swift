//
//  ThirdRowKeyContainer.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/18.
//

import UIKit

class ThirdRowKeyContainer: UIStackView {
    private let shiftButton = UIButton()
    private let thirdLineBasicKeys = BasicKeyLine(keys: ["ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ"])
    private let backButton = UIButton()
    weak var delegate: ThirdRowKeyContainerDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        
        attribute()
        layout()
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

//MARK: - Shift 버튼 기능
extension ThirdRowKeyContainer {
    @objc private func tappedShiftButton() {
        delegate?.tappedShiftButton()
    }
}

//MARK: - Back 버튼 기능
extension ThirdRowKeyContainer {
    @objc private func tappedBackButton() {
        delegate?.tappedBackButton()
            }
}
extension ThirdRowKeyContainer {
    private func attribute() {
        self.axis = .horizontal
        self.distribution = .equalSpacing
        
        thirdLineBasicKeys.delegate = self
        
        shiftButton.setTitle("shift", for: .normal)
        shiftButton.addTarget(self, action: #selector(tappedShiftButton), for: .touchUpInside)
        
        backButton.setTitle("back", for: .normal)
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        
        [shiftButton, backButton].forEach {
            $0.backgroundColor = .systemGray
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
            $0.titleLabel?.font = .systemFont(ofSize: CustomKeyBoard.Math.fontSize)
        }
    }
    
    private func layout() {
        [shiftButton, thirdLineBasicKeys, backButton].forEach {
            self.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        thirdLineBasicKeys.widthAnchor.constraint(equalToConstant: CustomKeyBoard.Math.keyboardWidth-CustomKeyBoard.Math.buttonWidth*3-CustomKeyBoard.Math.buttonPadding*2).isActive = true
        [shiftButton, backButton].forEach {
            $0.widthAnchor.constraint(equalToConstant: CustomKeyBoard.Math.buttonWidth*1.3).isActive = true
        }
    }
}
