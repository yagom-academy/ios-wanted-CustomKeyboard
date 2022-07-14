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
    // 초성 : 초성을 적어야 하는 상태
               // 중성 : 초성 적혀있는 경우, 중성을 적어야하는 상태 -> 초성이 들어왔다 -> 다음 글자에 적는다.
   //                                                   -> 종성이 들어왔다 -> 다음 글자에 적는다.
               //                                       -> 중성이 들어왔다 -> 현재 글자에 적는다.
               // 종성 : 초성, 중성이 적혀있는 경우, 종성을 적어야하는 상태 -> 종성을 적는다.
               // 있오요 : 종성이 이미 있는 상태 -> 초성, 종성이 들어왔다 -> 겹받침의 가능성 확인 -> 가능해 -> 겹받침으로 변환하여 현재 글자에 적는다.
               //                                                               -> 불가능해 -> 다음 초성으로 적는다.
               //                         -> 중성 -> 지금 종성을 초성으로 변경 후 들어온 글자와 합쳐서 다음글자에 적는다.
    
    
    var sejongState = SejongState.writeInitialState
    var value = ""
    
    var currentLastJongsung: Jongsung? = nil
    
    @objc func didTapKeyboardButton(_ sender: KeyboardButton) {
        print("didTapKeyboardButton")
        
        var curr = 0
        
        switch sejongState {
        case .writeInitialState: // 초성을 적어야 하는 상태
            curr = sender.chosung?.rawValue ?? 0 // 1. 초성을 적는다
            sejongState = .writeMiddleState
        case .writeMiddleState: // 중성을 적어야 하는 상태
            curr = sender.jungsung?.rawValue ?? 0 // 1. 중성을 적는다
            sejongState = .writeLastState
        case .writeLastState: // 종성을 적어야 하는 상태
            curr = sender.jongsung?.rawValue ?? 0 // 1. 종성을 적는다
            currentLastJongsung = sender.jongsung
            sejongState = .alreadyLastState
        case .alreadyLastState:
            if sender.jungsung != nil { // 중성이 들어온 경우                       안 -> 아, ㄴ -> 아ㄴ -> 아니
                value.unicodeScalars.removeLast()
                value.append(String(UnicodeScalar(currentLastJongsung!.chosung!.rawValue)!))
                curr = sender.jungsung?.rawValue ?? 0
                currentLastJongsung = nil
                sejongState = .writeLastState
            } else { // 초성, 종성이 들어온 경우                                      안, ㅎ -> 아, ㄴ, ㅎ -> 않
                if doubleDict[currentLastJongsung!] != nil {
                    if doubleDict[currentLastJongsung!]![sender.jongsung!] != nil {
                        value.unicodeScalars.removeLast()
                        curr = doubleDict[currentLastJongsung!]![sender.jongsung!]!.rawValue
                        currentLastJongsung = doubleDict[currentLastJongsung!]![sender.jongsung!]
                        sejongState = .alreadyDoubleLastState
                    } else {
                        curr = sender.chosung?.rawValue ?? 0
                        sejongState = .writeMiddleState
                    }
                } else {
                    curr = sender.chosung?.rawValue ?? 0
                    sejongState = .writeMiddleState
                }
            }
        case .alreadyDoubleLastState: // 종성이 겹받침인 경우                    않, ㅣ -> 아, ㄶ, ㅣ -> 안, ㄶ, ㅣ -> 안ㅎ, ㅣ -> 안히
            if sender.jungsung != nil { // 중성이 들어온 경우
                value.unicodeScalars.removeLast()
                value.append(String(UnicodeScalar(doubleReverseDict[currentLastJongsung!]!.first!.value.rawValue)!))
                value.append(String(UnicodeScalar(doubleReverseDict[currentLastJongsung!]!.first!.key.chosung!.rawValue)!))
                curr = sender.jungsung!.rawValue
                currentLastJongsung = nil
                sejongState = .writeLastState
            } else { // 초성, 종성이 들어온 경우                                  않, ㅈ -> 않ㅈ
                curr = sender.chosung!.rawValue
                currentLastJongsung = nil
                sejongState = .writeMiddleState
            }
        }
        value.append(String(UnicodeScalar(curr)!))
        print(value)
    }
    
    var doubleDict: [Jongsung: [Jongsung: Jongsung]] = [
        .ㄱ: [.ㅅ: .ㄳ],
        .ㄴ: [.ㅈ: .ㄵ, .ㅎ: .ㄶ],
        .ㄹ: [.ㄱ: .ㄺ, .ㅁ: .ㄻ, .ㅂ: .ㄼ, .ㅅ: .ㄽ, .ㅌ: .ㄾ, .ㅍ: .ㄿ, .ㅎ: .ㅀ],
        .ㅂ: [.ㅅ: .ㅄ]
    ]
    var doubleReverseDict: [Jongsung: [Jongsung: Jongsung]] = [
        .ㄳ: [.ㅅ: .ㄱ],
        .ㄵ: [.ㅈ: .ㄴ],
        .ㄶ: [.ㅎ: .ㄴ],
        .ㄺ: [.ㄱ: .ㄹ],
        .ㄻ: [.ㅁ: .ㄹ],
        .ㄼ: [.ㅂ: .ㄹ],
        .ㄽ: [.ㅅ: .ㄹ],
        .ㄾ: [.ㅌ: .ㄹ],
        .ㄿ: [.ㅍ: .ㄹ],
        .ㅀ: [.ㅎ: .ㄹ],
        .ㅄ: [.ㅅ: .ㅂ]
    ]
}

enum SejongState {
    case writeInitialState
    case writeMiddleState
    case writeLastState
    case alreadyLastState
    case alreadyDoubleLastState
}
