//
//  KeyboardView.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/12.
//

import UIKit

class KeyboardView: UIView {
    
    let topLetterValues: [Any] = [
        Chosung.ㅂ,Chosung.ㅈ,Chosung.ㄷ,Chosung.ㄱ,Chosung.ㅅ,
        Jungsung.ㅛ,Jungsung.ㅕ,Jungsung.ㅑ,Jungsung.ㅐ,Jungsung.ㅔ
    ]
    let middleLetterValues:[Any] = [
        Chosung.ㅁ,Chosung.ㄴ,Chosung.ㅇ,Chosung.ㄹ,Chosung.ㅎ,
        Jungsung.ㅗ,Jungsung.ㅓ,Jungsung.ㅏ,Jungsung.ㅣ
    ]
    let lastLetterValues:[Any] = [
        Chosung.ㅋ,Chosung.ㅌ,Chosung.ㅊ,Chosung.ㅍ,
        Jungsung.ㅠ,Jungsung.ㅜ,Jungsung.ㅡ
    ]

    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 6.0
        configureButton(topLetterValues, stackView: stackView)
        return stackView
    }()
    
    private lazy var midStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 6.0
        
        configureButton(middleLetterValues, stackView: stackView)
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 6.0
        configureButton(lastLetterValues, stackView: stackView)
        return stackView
    }()
    
    private lazy var spaceButton: UIButton = {
        let button = UIButton()
        button.setTitle("space", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.addTarget(self, action: #selector(didTapSpace), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = .init(width: 0.0, height: 1.0)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.1
        button.layer.cornerRadius = 5
        return button
    }()
    
    @objc func didTapSpace() {
        value.append(" ")
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        [
            topStackView,
            midStackView,
            bottomStackView,
            spaceButton
        ].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            topStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            
            midStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor,constant: 10),
            midStackView.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor,constant: 10),
            midStackView.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor,constant: -10),
            
            bottomStackView.topAnchor.constraint(equalTo: midStackView.bottomAnchor,constant: 10),
            bottomStackView.leadingAnchor.constraint(equalTo: midStackView.leadingAnchor,constant: 25),
            bottomStackView.trailingAnchor.constraint(equalTo: midStackView.trailingAnchor,constant: -25),
            
            spaceButton.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor),
            spaceButton.trailingAnchor.constraint(equalTo: bottomStackView.trailingAnchor),
            spaceButton.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor,constant: 10)
        ])
    }
    
    func configureButton(_ letters: [Any], stackView: UIStackView) {
        letters.forEach { letterValue in
            if let value = letterValue as? Chosung {
                let button = KeyboardButton(type: .text,
                                            text: value.description,
                                            chosung: value,
                                            jongsung: value.jongsung)
                button.addTarget(self, action: #selector(didTapKeyboardButton(_:)), for: .touchUpInside)
                stackView.addArrangedSubview(button)
                
            }
            
            if let value = letterValue as? Jungsung {
                let button = KeyboardButton(type: .text,
                                            text: value.description,
                                            jungsung: value)
                button.addTarget(self, action: #selector(didTapKeyboardButton(_:)), for: .touchUpInside)
                stackView.addArrangedSubview(button)
            }
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
    
    var currentJungsung: Jungsung? = nil
    var currentLastJongsung: Jongsung? = nil
    
    @objc func didTapKeyboardButton(_ sender: KeyboardButton) {
        var curr: Int? = 0
        
        switch sejongState {
        case .writeInitialState: // 초성을 적어야 하는 상태
            curr = sender.chosung?.rawValue // 1. 초성을 적는다
            sejongState = .writeMiddleState
        case .writeMiddleState: // 중성을 적어야 하는 상태
            curr = sender.jungsung?.rawValue // 1. 중성을 적는다
            currentJungsung = sender.jungsung
            sejongState = .writeLastState
        case .writeLastState: // 종성을 적어야 하는 상태
            if sender.jungsung != nil { // 중성이 들어온다면
                value.unicodeScalars.removeLast()
                let doubleJungsung = mergeJungsung(currentJungsung, sender.jungsung)
                currentJungsung = doubleJungsung
                curr = doubleJungsung?.rawValue
                sejongState = .writeLastState
            } else {
                curr = sender.jongsung?.rawValue // 자음이 들어오면
                currentLastJongsung = sender.jongsung
                sejongState = .alreadyLastState
            }
        case .alreadyLastState:
            if sender.jungsung != nil { // 중성이 들어온 경우                       안 -> 아, ㄴ -> 아ㄴ -> 아니
                value.unicodeScalars.removeLast()
                value.appendUnicode(currentLastJongsung?.chosung?.rawValue)
                curr = sender.jungsung?.rawValue
                currentJungsung = sender.jungsung
                currentLastJongsung = nil
                sejongState = .writeLastState
            } else { // 초성, 종성이 들어온 경우                                      안, ㅎ -> 아, ㄴ, ㅎ -> 않
                let mergedJongsung = mergeDoubleJongsung(currentLastJongsung, sender.jongsung)
                if mergedJongsung != nil {
                    value.unicodeScalars.removeLast()
                    curr = mergedJongsung?.rawValue
                    currentLastJongsung = mergedJongsung
                    sejongState = .alreadyDoubleLastState
                } else {
                    curr = sender.chosung?.rawValue
                    sejongState = .writeMiddleState
                }
            }
        case .alreadyDoubleLastState: // 종성이 겹받침인 경우                    않, ㅣ -> 아, ㄶ, ㅣ -> 안, ㄶ, ㅣ -> 안ㅎ, ㅣ -> 안히
            if sender.jungsung != nil { // 중성이 들어온 경우
                value.unicodeScalars.removeLast()
                let splitedDoubleJongsung = splitDoubleJongsungReverse(currentLastJongsung)
                let jong1 = splitedDoubleJongsung?.0
                let jong2 = splitedDoubleJongsung?.1
                
                value.appendUnicode(jong1?.rawValue)
                value.appendUnicode(jong2?.chosung?.rawValue)
                curr = sender.jungsung?.rawValue
                currentJungsung = sender.jungsung
                currentLastJongsung = nil
                sejongState = .writeLastState
            } else { // 초성, 종성이 들어온 경우                                  않, ㅈ -> 않ㅈ
                curr = sender.chosung?.rawValue
                currentLastJongsung = nil
                sejongState = .writeMiddleState
            }
        }
        value.appendUnicode(curr)
        print(value)
    }
    
    func mergeDoubleJongsung(_ jong1: Jongsung?, _ jong2: Jongsung?) -> Jongsung? {
        switch jong1 {
        case .ㄱ:
            if jong2 == .ㅅ { return .ㄱㅅ }
            return nil
        case .ㄴ:
            if jong2 == .ㅈ { return .ㄴㅈ }
            else if jong2 == .ㅎ { return .ㄴㅎ }
            return nil
        case .ㄹ:
            switch jong2 {
            case .ㄱ: return .ㄹㄱ
            case .ㅁ: return .ㄹㅁ
            case .ㅂ: return .ㄹㅂ
            case .ㅅ: return .ㄹㅅ
            case .ㅌ: return .ㄹㅌ
            case .ㅍ: return .ㄹㅍ
            case .ㅎ: return .ㄹㅎ
            default: return nil
            }
        case .ㅂ:
            if jong2 == .ㅅ { return .ㅂㅅ }
            return nil
        default: return nil
        }
    }
    
    func splitDoubleJongsungReverse(_ jong: Jongsung?) -> (Jongsung, Jongsung)? {
        switch jong {
        case .ㄱㅅ: return (.ㄱ, .ㅅ)
        case .ㄴㅈ: return (.ㄴ, .ㅈ)
        case .ㄴㅎ: return (.ㄴ, .ㅎ)
        case .ㄹㄱ: return (.ㄹ, .ㄱ)
        case .ㄹㅁ: return (.ㄹ, .ㅁ)
        case .ㄹㅂ: return (.ㄹ, .ㅂ)
        case .ㄹㅅ: return (.ㄹ, .ㅅ)
        case .ㄹㅌ: return (.ㄹ, .ㅌ)
        case .ㄹㅍ: return (.ㄹ, .ㅍ)
        case .ㄹㅎ: return (.ㄹ, .ㅎ)
        case .ㅂㅅ: return (.ㅂ, .ㅅ)
        default: return nil
        }
    }
    
    func mergeJungsung(_ jung1: Jungsung?, _ jung2: Jungsung?) -> Jungsung? {
        switch jung1 {
        case .ㅗ:
            switch jung2 {
            case .ㅏ: return .ㅘ
            case .ㅐ: return .ㅙ
            case .ㅣ: return .ㅚ
            default: return nil
            }
        case .ㅜ:
            switch jung2 {
            case .ㅓ: return .ㅝ
            case .ㅔ: return .ㅞ
            case .ㅣ: return .ㅟ
            default: return nil
            }
        case .ㅡ:
            if jung2 == .ㅣ { return .ㅢ }
            return nil
        default: return nil
        }
    }
}
