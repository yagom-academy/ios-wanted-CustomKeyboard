//
//  KeyboardView.swift
//  CustomKeyboard
//
//  Created by BH on 2022/07/12.
//

import Foundation
import UIKit

class KeyboardView: UIView {
    
    // MARK: - UIProperties
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .brown
        label.text = "ㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaaㅇslnaa"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var keyboardContentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var keyboardFirstLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var keyboardSecondLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var keyboardThirdLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var shiftKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 5
        button.setImage(UIImage.init(systemName: "circle"), for: .normal)
        
        button.addTarget(nil, action: #selector(shiftButtonTouched(_:)), for: .touchUpInside)
        
        button.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.3 / 4 * 0.8 ) .isActive  = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        return button
    }()
    
    private lazy var deleteKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.setImage(UIImage.init(systemName: "square"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.3 / 4 * 0.8 ) .isActive  = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        return button
    }()
    
    private lazy var numKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.setTitle("123", for: .normal)
        button.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.3 / 4 * 0.6 ) .isActive  = true
        button.widthAnchor.constraint(equalToConstant: self.bounds.width * 0.25).isActive = true
        return button
    }()

    private lazy var spaceKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.setTitle("스페이스", for: .normal)
        button.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.3 / 4 * 0.6 ) .isActive  = true
        button.widthAnchor.constraint(lessThanOrEqualToConstant: self.bounds.width * 0.5).isActive = true
        return button
    }()

    private lazy var returnKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        button.setTitle("return", for: .normal)
        button.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.3 / 4 * 0.6 ) .isActive  = true
        button.widthAnchor.constraint(equalToConstant: self.bounds.width * 0.25).isActive = true
        return button
    }()
    
    private lazy var keyboardFourthLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 7
        return stackView
    }()
    
    private var toBeConvertedButtons = [UIButton]()
    
    // MARK: - LifeCycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }
    
    // MARK: - objc Methods
    
    @objc func keyboardButtonTouched(_ sender: UIButton) {
        var isShiftedState = sender.state
        if sender.state.rawValue == 5 {
            isShiftedState = UIControl.State.selected
        }
        
        guard let contents = sender.title(for: isShiftedState) else {
            return
        }
        
        print(contents)
    }
    
    @objc func shiftButtonTouched(_ sender: UIButton) {
        sender.isSelected.toggle()
        toBeConvertedButtons.forEach {
            $0.isSelected = sender.isSelected
        }
    }
    
}

extension KeyboardView {
    
    // MARK: - UI Methods
    
    private func insertKeyboardKeys() {
        for char in "ㅂㅈㄷㄱㅅㅛㅕㅑㅐㅔ" {
            let key : UIButton!
            key = makeKeyboardButtons(contents: "\(char)")
            keyboardFirstLineStackView.addArrangedSubview(key)
        }
        
        for char in "ㅁㄴㅇㄹㅎㅗㅓㅏㅣ" {
            let key = makeKeyboardButtons(contents: "\(char)")
            keyboardSecondLineStackView.addArrangedSubview(key)
        }
        
        for char in "ㅋㅌㅊㅍㅠㅜㅡ" {
            let key = makeKeyboardButtons(contents: "\(char)")
            keyboardThirdLineStackView.addArrangedSubview(key)
        }
        
        for i in [numKeyButton, spaceKeyButton, returnKeyButton] {
            keyboardFourthLineStackView.addArrangedSubview(i)
        }
    }

    private func makeKeyboardButtons(contents: String) -> UIButton {
        let button = UIButton()
        button.setTitle(contents, for: .normal)
        if checkToBeConverted(contents: contents) {
            let doubleCharacter = convertToDouble(contents: contents)
            button.setTitle(doubleCharacter, for: .selected)
            toBeConvertedButtons.append(button)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(keyboardButtonTouched(_:)), for: .touchUpInside)
        button.backgroundColor = .systemGray2
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.3 / 4 * 0.8 ) .isActive  = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor ,multiplier: 0.8).isActive = true
        
        return button
    }

    private func checkToBeConverted(contents: String) -> Bool {
        let toBeConvertedToDoubleCharacter = ["ㅂ", "ㅈ", "ㄷ", "ㄱ", "ㅅ", "ㅐ", "ㅔ"]
        let isDoubleCharacter = toBeConvertedToDoubleCharacter.contains(contents)

        return isDoubleCharacter
    }

    private func convertToDouble(contents: String) -> String {
        switch contents {
        case "ㅂ":
            return "ㅃ"
        case "ㅈ":
            return "ㅉ"
        case "ㄷ":
            return "ㄸ"
        case "ㄱ":
            return "ㄲ"
        case "ㅅ":
            return "ㅆ"
        case "ㅐ":
            return "ㅒ"
        case "ㅔ":
            return "ㅖ"
        default:
            return contents
        }
    }

    
    func setupView() {
        insertKeyboardKeys()
        
        [textLabel,
         keyboardContentsView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [keyboardFirstLineStackView,
         keyboardSecondLineStackView,
         keyboardThirdLineStackView,
         keyboardFourthLineStackView,
         shiftKeyButton,
         deleteKeyButton].forEach {
            keyboardContentsView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        setupConstraintsOfTextLabel()
        setupConstraintsOfKeyboardContentsView()
        setupConstraintsOfShiftButton()
        setupConstraintsOfDeleteButton()
        setupConstraintsOfKeyboardFirstLineStackView()
        setupConstraintsOfKeyboardSecondLineStackView()
        setupConstraintsOfKeyboardThirdLineStackView()
        setupConstraintsOfKeyboardFourthLineStackView()
    }
    
    func setupConstraintsOfTextLabel() {
        let textLabelHeightAutoLayout = textLabel.heightAnchor.constraint(equalToConstant: 30)
        textLabelHeightAutoLayout.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            textLabel.bottomAnchor.constraint(lessThanOrEqualTo: keyboardContentsView.safeAreaLayoutGuide.topAnchor, constant: -16),
            textLabelHeightAutoLayout
        ])
    }
    
    func setupConstraintsOfKeyboardContentsView() {
        NSLayoutConstraint.activate([
            keyboardContentsView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            keyboardContentsView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            keyboardContentsView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            keyboardContentsView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.3)
        ])
    }
    
    func setupConstraintsOfShiftButton() {
        
        NSLayoutConstraint.activate([
            shiftKeyButton.leadingAnchor.constraint(equalTo: keyboardFirstLineStackView.safeAreaLayoutGuide.leadingAnchor),
            shiftKeyButton.centerYAnchor.constraint(equalTo: keyboardThirdLineStackView.safeAreaLayoutGuide.centerYAnchor)
        ])
        
    }
    
    func setupConstraintsOfDeleteButton() {
        NSLayoutConstraint.activate([
            deleteKeyButton.trailingAnchor.constraint(equalTo: keyboardFirstLineStackView.safeAreaLayoutGuide.trailingAnchor),
            deleteKeyButton.centerYAnchor.constraint(equalTo: keyboardThirdLineStackView.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    func setupConstraintsOfKeyboardFirstLineStackView() {
        NSLayoutConstraint.activate([
            keyboardFirstLineStackView.widthAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.widthAnchor),
            keyboardFirstLineStackView.centerXAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.centerXAnchor),
            keyboardFirstLineStackView.topAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.topAnchor),
            keyboardFirstLineStackView.heightAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25)
        ])
        
    }
    func setupConstraintsOfKeyboardSecondLineStackView() {
        NSLayoutConstraint.activate([
            keyboardSecondLineStackView.widthAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            keyboardSecondLineStackView.centerXAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.centerXAnchor),
            keyboardSecondLineStackView.topAnchor.constraint(equalTo: keyboardFirstLineStackView.safeAreaLayoutGuide.bottomAnchor),
            keyboardSecondLineStackView.heightAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25)
        ])
        
    }

    func setupConstraintsOfKeyboardThirdLineStackView() {
        NSLayoutConstraint.activate([
            keyboardThirdLineStackView.centerXAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.centerXAnchor),
            keyboardThirdLineStackView.topAnchor.constraint(equalTo: keyboardSecondLineStackView.safeAreaLayoutGuide.bottomAnchor),
            keyboardThirdLineStackView.heightAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            
            keyboardThirdLineStackView.leadingAnchor.constraint(lessThanOrEqualTo: shiftKeyButton.safeAreaLayoutGuide.trailingAnchor, constant: 12),
            keyboardThirdLineStackView.trailingAnchor.constraint(lessThanOrEqualTo: deleteKeyButton.safeAreaLayoutGuide.leadingAnchor, constant: -12),
        ])
        
    }

    func setupConstraintsOfKeyboardFourthLineStackView() {
        NSLayoutConstraint.activate([
            keyboardFourthLineStackView.widthAnchor.constraint(equalTo: keyboardContentsView.widthAnchor),
            keyboardFourthLineStackView.centerXAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.centerXAnchor),
            keyboardFourthLineStackView.topAnchor.constraint(equalTo: keyboardThirdLineStackView.safeAreaLayoutGuide.bottomAnchor),
            keyboardFourthLineStackView.heightAnchor.constraint(equalTo: keyboardContentsView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25)
        ])
    }

}
