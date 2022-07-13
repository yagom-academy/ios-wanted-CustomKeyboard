//
//  CustomKeyBoard.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/12.
//

import UIKit

class CustomKeyBoard: UIView {
    struct Math {
        static var windowWidth: CGFloat {
            let sceneDelegate = UIApplication.shared.connectedScenes
                    .first!.delegate as! SceneDelegate
            return sceneDelegate.windowWidth!
        }
        
        static let buttonPadding = 5.0
        static let buttonWidth = windowWidth / 10.0 - buttonPadding
    }
    
    private let mainContainer = UIStackView()
    private let firstLineDynamicBasicKeys = BasicKeyLine(keys: ["ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ", "ㅛ", "ㅕ", "ㅑ", "ㅐ", "ㅔ"])
    
    private let secondLineBasicKeys = BasicKeyLine(keys: ["ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ"])
    
    private let thirdLineContainer = UIStackView()
    private let thirdLineBasicKeys = BasicKeyLine(keys: ["ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ"])
    private let shiftButton = UIButton()
    private let backButton = UIButton()
    
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
        mainContainer.alignment = .center
        
        thirdLineContainer.axis = .horizontal
        thirdLineContainer.distribution = .equalSpacing
        
        shiftButton.setTitle("Shift", for: .normal)
        
        backButton.setTitle("Back", for: .normal)
        
        [shiftButton, backButton].forEach {
            $0.backgroundColor = .systemGray
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = 10
        }
        
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
        
        [UIView(), firstLineDynamicBasicKeys, secondLineBasicKeys, thirdLineContainer, firthLineKeys, UIView()].forEach {
            mainContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [firstLineDynamicBasicKeys, secondLineBasicKeys, thirdLineContainer, firthLineKeys].forEach {
            $0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true
        }
        firstLineDynamicBasicKeys.widthAnchor.constraint(equalToConstant: Math.windowWidth-Math.buttonPadding*2).isActive = true
        secondLineBasicKeys.widthAnchor.constraint(equalToConstant: Math.windowWidth-Math.buttonWidth-Math.buttonPadding*2).isActive = true
        thirdLineContainer.widthAnchor.constraint(equalToConstant: Math.windowWidth).isActive = true
        
        [shiftButton, thirdLineBasicKeys, backButton].forEach {
            thirdLineContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        thirdLineBasicKeys.widthAnchor.constraint(equalToConstant: Math.windowWidth-Math.buttonWidth*3-Math.buttonPadding*2).isActive = true
        [shiftButton, backButton].forEach {
            $0.widthAnchor.constraint(equalToConstant: Math.buttonWidth*1.5).isActive = true
        }
    }
}
