//
//  KeyboardView.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/12.
//

import UIKit

class KeyboardView: UIView {
    let viewModel: KeyboardViewModel
    
    var isShift = false
    
    let topLetterValues: [Compatibility] = [
        .ㅂ,.ㅈ,.ㄷ,.ㄱ,.ㅅ,.ㅛ,.ㅕ,.ㅑ,.ㅐ,.ㅔ
    ]
    let middleLetterValues: [Compatibility] = [
        .ㅁ,.ㄴ,.ㅇ,.ㄹ,.ㅎ,.ㅗ,.ㅓ,.ㅏ,.ㅣ
    ]
    let lastLetterValues:[Compatibility] = [
        .ㅋ,.ㅌ,.ㅊ,.ㅍ,.ㅠ,.ㅜ,.ㅡ
    ]

    private lazy var shiftButton: UIButton = {
        let button = UIButton()
        button.setupUtilButton(
            "shift",
            target: self,
            touchUpAction: #selector(didTapShift(_:)),
            touchDownAction: #selector(didPressKeyboardButton(_:))
        )
        return button
    }()
    private lazy var spaceButton: UIButton = {
        let button = UIButton()
        button.setupUtilButton(
            "space",
            target: self,
            touchUpAction: #selector(didTapSpace(_:)),
            touchDownAction: #selector(didPressKeyboardButton(_:))
        )
        return button
    }()
    private lazy var returnButton: UIButton = {
        let button = UIButton()
        button.setupUtilButton(
            "return",
            target: self,
            touchUpAction: #selector(didTapReturn(_:)),
            touchDownAction: #selector(didPressKeyboardButton(_:))
        )
        return button
    }()
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setupUtilButton(
            "back",
            target: self,
            touchUpAction: #selector(didTapBack(_:)),
            touchDownAction: #selector(didPressKeyboardButton(_:))
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

    init(viewModel: KeyboardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupLayout()
        
        //Binding
        bindShiftMode()
        print(shiftButton.layer.bounds)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeShiftMode(_ bool: Bool) {
        topStackView
            .arrangedSubviews
            .compactMap {
                $0 as? KeyboardButton
            }
            .forEach {
                $0.isShift = bool
            }
    }
    
    func bindShiftMode() {
        viewModel.isShift.bind { isShift in
            self.isShift = isShift
            self.changeShiftMode(isShift)
        }
    }
}

// MARK: - @objc Methods
private extension KeyboardView {
    @objc func didPressKeyboardButton(_ sender: UIButton) {
        sender.backgroundColor = .secondarySystemFill
    }
    @objc func didTapKeyboardButton(_ sender: KeyboardButton) {
        sender.backgroundColor = .systemBackground
        let buffer = sender.compatibility
        viewModel.didTapKeyboardButton(buffer: buffer)
    }
    @objc func didTapSpace(_ sender: UIButton) {
        sender.backgroundColor = .systemBackground
        viewModel.result.value.append(" ")
        viewModel.sejongState = .writeInitialState
    }
    @objc func didTapShift(_ sender: UIButton) {
        sender.backgroundColor = .systemBackground
        debugPrint("didTapShift")
        isShift = !isShift
        viewModel.isShift.value = isShift
        changeShiftMode(isShift)
    }
    @objc func didTapReturn(_ sender: UIButton) {
        sender.backgroundColor = .systemBackground
        debugPrint("didTapReturn")
        viewModel.returnButtonTapped.value = true
    }
    @objc func didTapBack(_ sender: UIButton) {
        sender.backgroundColor = .systemBackground
        viewModel.didTapBack()
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
            returnButton,
            backButton
        ].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            topStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            midStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor,constant: 8),
            midStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            shiftButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3),
            shiftButton.trailingAnchor.constraint(equalTo: bottomStackView.leadingAnchor, constant: -8),
            shiftButton.centerYAnchor.constraint(equalTo: bottomStackView.centerYAnchor),
            shiftButton.heightAnchor.constraint(equalToConstant: KeyboardButton.height),
            
            bottomStackView.topAnchor.constraint(equalTo: midStackView.bottomAnchor,constant: 8),
            bottomStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backButton.leadingAnchor.constraint(equalTo: bottomStackView.trailingAnchor, constant: 8),
            backButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3),
            backButton.centerYAnchor.constraint(equalTo: bottomStackView.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: KeyboardButton.height),
            
            spaceButton.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor, constant: KeyboardButton.width + 6),
            spaceButton.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor, constant: 13),
            spaceButton.trailingAnchor.constraint(equalTo: bottomStackView.trailingAnchor, constant: -(KeyboardButton.width + 6)),
            spaceButton.heightAnchor.constraint(equalToConstant: KeyboardButton.height),
            
            
            returnButton.leadingAnchor.constraint(equalTo: spaceButton.trailingAnchor, constant: 6),
            returnButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3),
            returnButton.centerYAnchor.constraint(equalTo: spaceButton.centerYAnchor),
            returnButton.heightAnchor.constraint(equalToConstant: KeyboardButton.height)
        ])
    }
    
    func configureButton(_ letters: [Compatibility], stackView: UIStackView) {
        letters.forEach {
            let button = KeyboardButton(text: $0.text, compatibility: $0)
            button.addTarget(
                self,
                action: #selector(didTapKeyboardButton(_:)),
                for: .touchUpInside
            )
            button.addTarget(
                self,
                action: #selector(didPressKeyboardButton(_:)),
                for: .touchDown
            )
            stackView.addArrangedSubview(button)
        }
    }
}
