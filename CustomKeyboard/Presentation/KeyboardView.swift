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
    
    private lazy var keyboardKeyHeight = (self.bounds.height *
                                          Style.keyboardContentsViewRatio /
                                          Style.numberOfStackView *
                                          Style.keyboardKeyHeightRatio)
    private lazy var keyboardKeyWidth = self.bounds.width * Style.keyboardKeyWidthRatio
    
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
        button.layer.cornerRadius = Style.keyboardKeyCornerRaidus
        
        button.setImage(Style.shiftKeyImage, for: .normal)
        button.setImage(Style.shiftFilledKeyImage, for: .selected)
        
        button.addTarget(nil, action: #selector(shiftButtonTouched(_:)), for: .touchUpInside)
        
        button.heightAnchor.constraint(equalToConstant: keyboardKeyHeight) .isActive  = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        return button
    }()
    
    private lazy var deleteKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = Style.keyboardKeyCornerRaidus
        button.setImage(Style.deleteKeyImage, for: .normal)
        button.heightAnchor.constraint(equalToConstant: keyboardKeyHeight) .isActive  = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
        return button
    }()
    
    private lazy var numKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = Style.keyboardKeyCornerRaidus
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Style.functionKeyText, for: .normal)
        
        button.heightAnchor.constraint(equalToConstant: keyboardKeyHeight).isActive  = true
        button.widthAnchor.constraint(
            equalToConstant: self.bounds.width * Style.functionKeyWidthRatio
        ).isActive = true
        
        return button
    }()
    
    private lazy var spaceKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = Style.keyboardKeyCornerRaidus
        button.setTitleColor(.black, for: .normal)
        button.setTitle(Style.spaceKeyText, for: .normal)
        
        button.heightAnchor.constraint(equalToConstant: keyboardKeyHeight) .isActive  = true
        button.widthAnchor.constraint(
            equalToConstant: self.bounds.width * Style.spaceKeyWdithRatio
        ).isActive = true
        
        return button
    }()
    
    private lazy var returnKeyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = Style.keyboardKeyCornerRaidus
        button.setTitleColor(.black, for: .normal)
        button.setImage(Style.returnKeyImage, for: .normal)
        button.heightAnchor
            .constraint(equalToConstant:keyboardKeyHeight).isActive  = true
        button.widthAnchor.constraint(
            equalToConstant: self.bounds.width * Style.functionKeyWidthRatio
        ).isActive = true
        return button
    }()
    
    private lazy var keyboardFourthLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
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
        button.backgroundColor = .systemGray4
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Style.keyboardKeyCornerRaidus
        
        button.heightAnchor.constraint(equalToConstant: keyboardKeyHeight) .isActive  = true
        button.widthAnchor.constraint(equalToConstant: keyboardKeyWidth).isActive = true
        
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
            textLabel.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: Style.basicPadding
            ),
            textLabel.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -Style.basicPadding
            ),
            textLabel.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: Style.basicPadding
            ),
            textLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: keyboardContentsView.safeAreaLayoutGuide.topAnchor,
                constant: -Style.basicPadding
            ),
            textLabelHeightAutoLayout
        ])
    }
    
    func setupConstraintsOfKeyboardContentsView() {
        NSLayoutConstraint.activate([
            keyboardContentsView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor
            ),
            keyboardContentsView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor
            ),
            keyboardContentsView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor
            ),
            keyboardContentsView.heightAnchor.constraint(
                equalToConstant: self.frame.height * Style.keyboardContentsViewRatio
            )
        ])
    }
    
    func setupConstraintsOfShiftButton() {
        
        NSLayoutConstraint.activate([
            shiftKeyButton.leadingAnchor.constraint(
                equalTo: keyboardFirstLineStackView.safeAreaLayoutGuide.leadingAnchor
            ),
            shiftKeyButton.centerYAnchor.constraint(
                equalTo: keyboardThirdLineStackView.safeAreaLayoutGuide.centerYAnchor
            )
        ])
        
    }
    
    func setupConstraintsOfDeleteButton() {
        NSLayoutConstraint.activate([
            deleteKeyButton.trailingAnchor.constraint(
                equalTo: keyboardFirstLineStackView.safeAreaLayoutGuide.trailingAnchor
            ),
            deleteKeyButton.centerYAnchor.constraint(
                equalTo: keyboardThirdLineStackView.safeAreaLayoutGuide.centerYAnchor
            )
        ])
    }
    
    func setupConstraintsOfKeyboardFirstLineStackView() {
        NSLayoutConstraint.activate([
            keyboardFirstLineStackView.widthAnchor.constraint(
                equalTo: keyboardContentsView.safeAreaLayoutGuide.widthAnchor
            ),
            keyboardFirstLineStackView.centerXAnchor.constraint(
                equalTo: keyboardContentsView.safeAreaLayoutGuide.centerXAnchor
            ),
            keyboardFirstLineStackView.topAnchor.constraint(
                equalTo: keyboardContentsView.safeAreaLayoutGuide.topAnchor
            ),
            keyboardFirstLineStackView.heightAnchor.constraint(
                equalTo: keyboardContentsView.safeAreaLayoutGuide.heightAnchor,
                multiplier: Style.horizontalStackViewHeightRatio
            )
        ])
        
    }
    
    func setupConstraintsOfKeyboardSecondLineStackView() {
        NSLayoutConstraint.activate([
            keyboardSecondLineStackView.widthAnchor.constraint(
                equalTo: keyboardContentsView.safeAreaLayoutGuide.widthAnchor,
                multiplier: Style.secondStackViewWidthRatio
            ),
            keyboardSecondLineStackView.centerXAnchor.constraint(
                equalTo: keyboardContentsView.safeAreaLayoutGuide.centerXAnchor
            ),
            keyboardSecondLineStackView.topAnchor.constraint(
                equalTo: keyboardFirstLineStackView.safeAreaLayoutGuide.bottomAnchor
            ),
            keyboardSecondLineStackView.heightAnchor.constraint(
                equalTo: keyboardContentsView.safeAreaLayoutGuide.heightAnchor,
                multiplier: Style.horizontalStackViewHeightRatio
            )
        ])
        
    }
    
    func setupConstraintsOfKeyboardThirdLineStackView() {
        NSLayoutConstraint.activate([
            keyboardThirdLineStackView.centerXAnchor.constraint(
                equalTo: keyboardContentsView.safeAreaLayoutGuide.centerXAnchor
            ),
            keyboardThirdLineStackView.topAnchor.constraint(
                equalTo: keyboardSecondLineStackView.safeAreaLayoutGuide.bottomAnchor
            ),
            keyboardThirdLineStackView.heightAnchor.constraint(
                equalTo: keyboardContentsView.safeAreaLayoutGuide.heightAnchor,
                multiplier: Style.horizontalStackViewHeightRatio
            ),
            keyboardThirdLineStackView.leadingAnchor.constraint(
                lessThanOrEqualTo: shiftKeyButton.safeAreaLayoutGuide.trailingAnchor,
                constant: Style.basicPadding
            ),
            keyboardThirdLineStackView.trailingAnchor.constraint(
                lessThanOrEqualTo: deleteKeyButton.safeAreaLayoutGuide.leadingAnchor,
                constant: -Style.basicPadding
            ),
        ])
        
    }
    
    func setupConstraintsOfKeyboardFourthLineStackView() {
        NSLayoutConstraint.activate([
            keyboardFourthLineStackView.widthAnchor.constraint(
                equalTo: keyboardContentsView.widthAnchor
            ),
            keyboardFourthLineStackView.centerXAnchor.constraint(
                equalTo: keyboardContentsView.safeAreaLayoutGuide.centerXAnchor
            ),
            keyboardFourthLineStackView.topAnchor.constraint(
                equalTo: keyboardThirdLineStackView.safeAreaLayoutGuide.bottomAnchor
            ),
            keyboardFourthLineStackView.heightAnchor.constraint(
                equalTo: keyboardContentsView.safeAreaLayoutGuide.heightAnchor,
                multiplier: Style.horizontalStackViewHeightRatio
            )
        ])
    }
    
}

extension KeyboardView {
    private enum Style {
        static let shiftKeyImage = UIImage(systemName: "shift")
        static let shiftFilledKeyImage = UIImage(systemName: "shift.fill")
        static let deleteKeyImage = UIImage(systemName: "delete.left")
        static let functionKeyText = "123"
        static let spaceKeyText = "스페이스"
        static let returnKeyImage = UIImage(systemName: "return")
        
        static let keyboardKeyWidthRatio = CGFloat(0.09)
        static let keyboardContentsViewRatio = 0.3
        static let numberOfStackView = 4.0
        static let keyboardKeyHeightRatio = 0.8
        static let functionKeyWidthRatio = 0.24
        static let spaceKeyWdithRatio = 0.49
        static let horizontalStackViewHeightRatio = 0.25
        static let secondStackViewWidthRatio = 0.9
        
        static let keyboardKeyCornerRaidus: CGFloat = 5
        
        static let basicPadding: CGFloat = 16
    }
}
