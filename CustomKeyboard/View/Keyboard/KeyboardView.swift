//
//  KeyboardView.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/12.
//

import UIKit

class KeyboardView: UIView {
    let topButton1 = KeyboardButton(type: .text, text: "ㅂ", chosung: .ㅂ, jongsung: .ㅂ)
    let topButton2 = KeyboardButton(type: .text, text: "ㅈ", chosung: .ㅈ, jongsung: .ㅈ)
    let topButton3 = KeyboardButton(type: .text, text: "ㄷ", chosung: .ㄷ, jongsung: .ㄷ)
    let topButton4 = KeyboardButton(type: .text, text: "ㄱ", chosung: .ㄱ, jongsung: .ㄱ)
    let topButton5 = KeyboardButton(type: .text, text: "ㅅ", chosung: .ㅅ, jongsung: .ㅅ)
    let topButton6 = KeyboardButton(type: .text, text: "ㅛ", jungsung: .ㅛ)
    let topButton7 = KeyboardButton(type: .text, text: "ㅕ", jungsung: .ㅕ)
    let topButton8 = KeyboardButton(type: .text, text: "ㅑ", jungsung: .ㅑ)
    let topButton9 = KeyboardButton(type: .text, text: "ㅐ", jungsung: .ㅐ)
    let topButton10 = KeyboardButton(type: .text, text: "ㅔ", jungsung: .ㅔ)
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 6.0
        [
            topButton1, topButton2, topButton3, topButton4,
            topButton5, topButton6, topButton7, topButton8,
            topButton9, topButton10
        ].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    let midButton1 = KeyboardButton(type: .text, text: "ㅁ", chosung: .ㅁ, jongsung: .ㅁ)
    let midButton2 = KeyboardButton(type: .text, text: "ㄴ", chosung: .ㄴ, jongsung: .ㄴ)
    let midButton3 = KeyboardButton(type: .text, text: "ㅇ", chosung: .ㅇ, jongsung: .ㅇ)
    let midButton4 = KeyboardButton(type: .text, text: "ㄹ", chosung: .ㄹ, jongsung: .ㄹ)
    let midButton5 = KeyboardButton(type: .text, text: "ㅎ", chosung: .ㅎ, jongsung: .ㅎ)
    let midButton6 = KeyboardButton(type: .text, text: "ㅗ", jungsung: .ㅗ)
    let midButton7 = KeyboardButton(type: .text, text: "ㅓ", jungsung: .ㅓ)
    let midButton8 = KeyboardButton(type: .text, text: "ㅏ", jungsung: .ㅏ)
    let midButton9 = KeyboardButton(type: .text, text: "ㅣ", jungsung: .ㅣ)
    
    private lazy var midStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 6.0
        [
            midButton1, midButton2, midButton3, midButton4,
            midButton5, midButton6, midButton7, midButton8,
            midButton9
        ].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    let bottomButton1 = KeyboardButton(type: .text, text: "ㅋ", chosung: .ㅋ, jongsung: .ㅋ)
    let bottomButton2 = KeyboardButton(type: .text, text: "ㅌ", chosung: .ㅌ, jongsung: .ㅌ)
    let bottomButton3 = KeyboardButton(type: .text, text: "ㅊ", chosung: .ㅊ, jongsung: .ㅊ)
    let bottomButton4 = KeyboardButton(type: .text, text: "ㅍ", chosung: .ㅍ, jongsung: .ㅍ)
    let bottomButton5 = KeyboardButton(type: .text, text: "ㅠ", jungsung: .ㅠ)
    let bottomButton6 = KeyboardButton(type: .text, text: "ㅜ", jungsung: .ㅜ)
    let bottomButton7 = KeyboardButton(type: .text, text: "ㅡ", jungsung: .ㅡ)
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 6.0
        [
            bottomButton1, bottomButton2, bottomButton3, bottomButton4,
            bottomButton5, bottomButton6, bottomButton7
        ].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    private lazy var totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        [
            topStackView,
            midStackView,
            bottomStackView
        ].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(totalStackView)
        totalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            totalStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            totalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            totalStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            totalStackView.heightAnchor.constraint(equalToConstant: 160.0)
        ])
        
        [
            topButton1, topButton2, topButton3, topButton4,
            topButton5, topButton6, topButton7, topButton8,
            topButton9, topButton10, midButton1, midButton2,
            midButton3, midButton4, midButton5, midButton6,
            midButton7, midButton8, midButton9, bottomButton1,
            bottomButton2, bottomButton3, bottomButton4, bottomButton5,
            bottomButton6, bottomButton7
        ].forEach {
            $0.addTarget(
                self,
                action: #selector(didTapKeyboardButton(_:)),
                for: .touchUpInside
            )
        }
    }
    
    @objc func didTapKeyboardButton(_ sender: KeyboardButton) {
        print("didTapKeyboardButton")
    }
}
