//
//  CustomKeyBoard.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/12.
//

import UIKit

class CustomKeyBoard: UIView {
    struct Math {
        static var keyboardWidth: CGFloat {
            let sceneDelegate = UIApplication.shared.connectedScenes
                    .first!.delegate as! SceneDelegate
            return sceneDelegate.windowWidth!
        }
        static let buttonPadding = 5.0
        static let buttonWidth = keyboardWidth / 10.0 - buttonPadding
        static let fontSize: CGFloat = keyboardWidth < 340 ? 13.0 : 19.0
    }
    private let mainContainer = UIStackView()
    private let firstLineDynamicBasicKeys = DynamicBasicKeyLine()
    private let secondLineBasicKeys = BasicKeyLine(keys: ["ㅁ", "ㄴ", "ㅇ", "ㄹ", "ㅎ", "ㅗ", "ㅓ", "ㅏ", "ㅣ"])
    
    private let thirdLineContainer = UIStackView()
    private let shiftButton = UIButton()
    private let thirdLineBasicKeys = BasicKeyLine(keys: ["ㅋ", "ㅌ", "ㅊ", "ㅍ", "ㅠ", "ㅜ", "ㅡ"])
    private let backButton = UIButton()
    
    private let firthLineContainer = UIStackView()
    private let spaceButton = UIButton()
    private let returnButton = UIButton()
    
    var delegate: CustomKeyBoardDelegate?
    private let viewModel = CustomKeyBoardViewModel()
    
    init() {
        super.init(frame: CGRect.zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Basic(기본)키 이벤트 메서드
extension CustomKeyBoard: BasicKeyLineDelegate {
    private func connectBasicKeyDelegate() {
        [firstLineDynamicBasicKeys, secondLineBasicKeys, thirdLineBasicKeys].forEach {
            $0.delegate = self
        }
    }
    
    func tappedBasicKeyButton(unicode: Int) {
        delegate?.connectTextView().text = viewModel.addWord(unicode: unicode, to: delegate?.connectTextView().text)
    }
}

//MARK: - Shift 버튼 기능
extension CustomKeyBoard {
    @objc private func tappedShiftButton() {
        firstLineDynamicBasicKeys.tappedShiftKey()
    }
}

//MARK: - Space 버튼 기능
extension CustomKeyBoard {
    @objc private func tappedSpaceButton(_ sender: UIButton) {
        delegate?.connectTextView().text = viewModel.addSpace(unicode: sender.tag, to: delegate?.connectTextView().text)
    }
}

//MARK: - Return 버튼 기능
extension CustomKeyBoard {
    @objc private func tappedReturnButton() {
        delegate?.tappedReturnButton()
    }
}

//MARK: - Back 버튼 기능
extension CustomKeyBoard {
    @objc private func tappedBackButton() {
        delegate?.connectTextView().text = viewModel.removeWord(from: delegate?.connectTextView().text)
    }
}

//MARK: - attribute
extension CustomKeyBoard {
    private func attribute() {
        connectBasicKeyDelegate()
        
        self.backgroundColor = .systemGray3
        
        mainContainer.axis = .vertical
        mainContainer.distribution = .equalSpacing
        mainContainer.alignment = .center
        
        thirdLineContainer.axis = .horizontal
        thirdLineContainer.distribution = .equalSpacing
        
        firthLineContainer.axis = .horizontal
        firthLineContainer.spacing = 10
        
        shiftButton.setTitle("shift", for: .normal)
        shiftButton.addTarget(self, action: #selector(tappedShiftButton), for: .touchUpInside)
        
        backButton.setTitle("back", for: .normal)
        
        [shiftButton, backButton, returnButton].forEach {
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
        
        [shiftButton, backButton, spaceButton, returnButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: Math.fontSize)
        }
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
        let bottomPaddingView = UIView()
        
        [UIView(), firstLineDynamicBasicKeys, secondLineBasicKeys, thirdLineContainer, firthLineContainer, bottomPaddingView].forEach {
            mainContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        bottomPaddingView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/8).isActive = true
        [firstLineDynamicBasicKeys, secondLineBasicKeys, thirdLineContainer, firthLineContainer].forEach {
            $0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/6).isActive = true
        }
        firstLineDynamicBasicKeys.widthAnchor.constraint(equalToConstant: Math.keyboardWidth-Math.buttonPadding*2).isActive = true
        secondLineBasicKeys.widthAnchor.constraint(equalToConstant: Math.keyboardWidth-Math.buttonWidth-Math.buttonPadding*2).isActive = true
        thirdLineContainer.widthAnchor.constraint(equalToConstant: Math.keyboardWidth-Math.buttonPadding*2).isActive = true
        firthLineContainer.widthAnchor.constraint(equalToConstant: Math.keyboardWidth-Math.buttonPadding*2).isActive = true
        
        //MARK: 세번째줄
        [shiftButton, thirdLineBasicKeys, backButton].forEach {
            thirdLineContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        thirdLineBasicKeys.widthAnchor.constraint(equalToConstant: Math.keyboardWidth-Math.buttonWidth*3-Math.buttonPadding*2).isActive = true
        [shiftButton, backButton].forEach {
            $0.widthAnchor.constraint(equalToConstant: Math.buttonWidth*1.3).isActive = true
        }
        
        //MARK: 네번쨰줄
        let spaceView = UIView()
        [spaceView, spaceButton, returnButton].forEach {
            firthLineContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [spaceView, returnButton].forEach {
            $0.widthAnchor.constraint(equalToConstant: Math.buttonWidth*2.5).isActive = true
        }
    }
}
