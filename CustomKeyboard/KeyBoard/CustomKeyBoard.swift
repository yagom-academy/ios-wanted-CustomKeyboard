//
//  CustomKeyBoard.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/12.
//

import UIKit

class CustomKeyBoard: UIView {
    private let mainContainer = UIStackView()
    private let firstLineBasicKeys = BasicKeyOneLine(keys: ["ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ", "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"])
    private let secondLineBasicKeys = BasicKeyOneLine(keys: ["ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ"])
    private let thirdLineBasicKeys = BasicKeyOneLine(keys: ["ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ"])
    
    private let firthLineKeys = UIView()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - attribute
extension CustomKeyBoard {
    private func attribute() {
        self.backgroundColor = .systemGray3
        
        mainContainer.axis = .vertical
        mainContainer.distribution = .equalSpacing
        
        //temp
        firthLineKeys.backgroundColor = .red
    }
}

//MARK: - layout
extension CustomKeyBoard {
    private func layout() {
        self.addSubview(mainContainer)
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        [UIView(), firstLineBasicKeys, secondLineBasicKeys, thirdLineBasicKeys, firthLineKeys, UIView()].forEach {
            mainContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [firstLineBasicKeys, secondLineBasicKeys, thirdLineBasicKeys, firthLineKeys].forEach {
            $0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true
        }
    }
}
