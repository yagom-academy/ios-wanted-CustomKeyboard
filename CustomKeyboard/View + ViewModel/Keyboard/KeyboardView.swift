//
//  KeyboardView.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/12.
//

import UIKit

protocol KeyboardViewDelegate: AnyObject {
    var reviewText: String { get set }
}

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

    private lazy var shiftButton: UIButton = {
        let button = UIButton()
        button.setupUtilButton(
            "shift",
            target: self,
            action: #selector(didTapShift)
        )
        return button
    }()
    private lazy var spaceButton: UIButton = {
        let button = UIButton()
        button.setupUtilButton(
            "space",
            target: self,
            action: #selector(didTapSpace)
        )
        return button
    }()
    private lazy var returnButton: UIButton = {
        let button = UIButton()
        button.setupUtilButton(
            "return",
            target: self,
            action: #selector(didTapReturn)
        )
        return button
    }()
    

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
    

    var sejongState: SejongState = .writeInitialState
    var value = "" {
        didSet {
            delegate?.reviewText = value
        }

    }
    var currentJungsung: Jungsung? = nil
    var currentLastJongsung: Jongsung? = nil
    var isShift = false
    weak var delegate: KeyboardViewDelegate?

    func configureButton(_ letters: [Any], stackView: UIStackView) {
        letters.forEach { letterValue in
            if let value = letterValue as? Chosung {
                let button = KeyboardButton(
                    type: .text,
                    text: value.description,
                    chosung: value,
                    jongsung: value.jongsung
                )
                button.addTarget(
                    self,
                    action: #selector(didTapKeyboardButton(_:)),
                    for: .touchUpInside
                )
                stackView.addArrangedSubview(button)
            }
            
            if let value = letterValue as? Jungsung {
                let button = KeyboardButton(
                    type: .text,
                    text: value.description,
                    jungsung: value
                )
                button.addTarget(
                    self,
                    action: #selector(didTapKeyboardButton(_:)),
                    for: .touchUpInside
                )
                stackView.addArrangedSubview(button)
            }
        }
    }
    
    // MARK: - INIT

    init() {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SETUP
    func setupView() {

        setupLayout()
    }

    
    func changeShiftMode(_ bool: Bool) {
        topStackView.arrangedSubviews
                    .compactMap { $0 as? KeyboardButton }
                    .forEach { $0.isShift = bool }
    }
    
    private let viewModel = KeyboardViewModel()
}

// MARK: - @objc Methods
private extension KeyboardView {
    @objc func didTapKeyboardButton(_ sender: KeyboardButton) {
        var curr: Int? = 0
        
        switch sejongState {
        case .writeInitialState: // 초성을 적어야 하는 상태
            curr = sender.chosung?.rawValue // 1. 초성을 적는다
            sejongState = .writeMiddleState
        case .writeMiddleState: // 중성을 적어야 하는 상태
            if sender.jungsung != nil {
                curr = sender.jungsung?.rawValue // 1. 중성을 적는다
                currentJungsung = sender.jungsung
                sejongState = .writeLastState
            } else {
                curr = sender.chosung?.rawValue
                sejongState = .writeMiddleState
            }
        case .writeLastState: // 종성을 적어야 하는 상태
            if sender.jungsung != nil { // 중성이 들어온다면
                value.unicodeScalars.removeLast()
                let doubleJungsung = viewModel.mergeJungsung(currentJungsung, sender.jungsung)
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
                let mergedJongsung = viewModel.mergeDoubleJongsung(currentLastJongsung, sender.jongsung)
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
                let splitedDoubleJongsung = viewModel.splitDoubleJongsungReverse(currentLastJongsung)
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
        
        isShift = false
        changeShiftMode(isShift)
        
        print(value)
    }
    
    @objc func didTapSpace() {
        value.append(" ")
        sejongState = .writeInitialState
    }
    @objc func didTapShift() {
        print("didTapShift")
        isShift = !isShift
        changeShiftMode(isShift)
    }
    @objc func didTapReturn() {
        print("didTapReturn")
        // TODO: - 첫번째 화면으로 나가기
    }
}

// MARK: - Methods
private extension KeyboardView {}

// MARK: - UI Methods
private extension KeyboardView {
    func setupLayout() {
        [
            topStackView,
            midStackView,
            bottomStackView,
            shiftButton,
            spaceButton,
            returnButton
        ].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            midStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            midStackView.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor, constant: 10),
            midStackView.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor, constant: -10),
            
            bottomStackView.topAnchor.constraint(equalTo: midStackView.bottomAnchor, constant: 10),
            bottomStackView.leadingAnchor.constraint(equalTo: midStackView.leadingAnchor, constant: 25),
            bottomStackView.trailingAnchor.constraint(equalTo: midStackView.trailingAnchor, constant: -25),
            
            shiftButton.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor),
            shiftButton.topAnchor.constraint(equalTo: spaceButton.topAnchor),
            shiftButton.widthAnchor.constraint(lessThanOrEqualToConstant: 60.0),
            
            spaceButton.leadingAnchor.constraint(equalTo: shiftButton.trailingAnchor, constant: 6),
            spaceButton.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor, constant: 10),
            spaceButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            returnButton.leadingAnchor.constraint(equalTo: spaceButton.trailingAnchor, constant: 6),
            returnButton.topAnchor.constraint(equalTo: spaceButton.topAnchor),
            returnButton.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor),
            returnButton.widthAnchor.constraint(lessThanOrEqualToConstant: 60.0)
        ])
    }
}
