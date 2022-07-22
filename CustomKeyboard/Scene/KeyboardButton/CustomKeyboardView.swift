//
//  CustomKeybordView.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/14.
//

import UIKit

enum BackgroundColor {
  case gray
  case lightGray
}

enum TextOperation {
  case charPressed(Int)
  case deletePressed
  case spacePressed
}

class CustomKeyboardView: UIView {
  
  var buttonPressed: ((String) -> Void)?
  var pressedRetrunButton: (()->Void)?
  
  private let viewModel = CustomKeyboardViewModel()
  private lazy var firstLineButtonList = makeButtonList(viewModel.firstLineCharList)
  private lazy var secondLineButtonList = makeButtonList(viewModel.secondLineCharList)
  private lazy var thirdLineButtonList = makeButtonList(viewModel.thirdLineCharList)
  
  private lazy var shiftButton : CustomRoundButton = {
    let button = CustomRoundButton()
    setupBasicSetting(button: button, backgroundColor: .gray)
    button.setImage(UIImage(systemName: "shift"), for: .normal)
    button.setImage(UIImage(systemName: "shift.fill"), for: .selected)
    button.addTarget(self, action: #selector(pressedShift), for: .touchUpInside)
    return button
  }()
  
  private lazy var deleteButton : CustomRoundButton = {
    let button = CustomRoundButton()
    setupBasicSetting(button: button, backgroundColor: .gray)
    button.setImage(UIImage(systemName: "delete.left"), for: .normal)
    button.addTarget(self, action: #selector(pressedDelete), for: .touchUpInside)
    return button
  }()
  
  private lazy var returnButton : CustomRoundButton = {
    let button = CustomRoundButton()
    setupBasicSetting(button: button, backgroundColor: .gray)
    button.setImage(UIImage(systemName: "return.left"), for: .normal)
    button.addTarget(self, action: #selector(pressedRetrun), for: .touchUpInside)
    return button
  }()
  
  private lazy var spaceButton : CustomRoundButton = {
    let button = CustomRoundButton()
    setupBasicSetting(button: button, backgroundColor: .lightGray)
    button.setTitle("스페이스", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.titleLabel?.textColor = .white
    button.addTarget(self, action: #selector(pressedSpace), for: .touchUpInside)
    return button
  }()
  
  private lazy var specialCharButton : CustomRoundButton = {
    let button = CustomRoundButton()
    setupBasicSetting(button: button, backgroundColor: .gray)
    button.setTitle("123", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    button.titleLabel?.textColor = .white
    return button
  }()
  
  private var containerView : UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = #colorLiteral(red: 0.1686274707, green: 0.1686274707, blue: 0.1686274707, alpha: 1)
    return view
  }()
  
  private lazy var firstLineStackView : UIStackView = {
    let stackView = UIStackView(arrangedSubviews: firstLineButtonList)
    stackView.axis = .horizontal
    stackView.spacing = 4
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private lazy var secondLineStackView : UIStackView = {
    let stackView = UIStackView(arrangedSubviews: secondLineButtonList)
    stackView.axis = .horizontal
    stackView.spacing = 4
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private lazy var thirdLineStackView : UIStackView = {
    let stackView = UIStackView(arrangedSubviews: thirdLineButtonList)
    stackView.axis = .horizontal
    stackView.spacing = 4
    stackView.distribution = .fillEqually
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = #colorLiteral(red: 0.1686274707, green: 0.1686274707, blue: 0.1686274707, alpha: 1)
    
    viewModel.text.bind { [weak self] in
      self?.buttonPressed?($0)
    }
    
    self.addSubview(containerView)
    containerView.addSubview(firstLineStackView)
    containerView.addSubview(secondLineStackView)
    containerView.addSubview(thirdLineStackView)
    containerView.addSubview(shiftButton)
    containerView.addSubview(deleteButton)
    containerView.addSubview(specialCharButton)
    containerView.addSubview(spaceButton)
    containerView.addSubview(returnButton)
    
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 3),
      containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -3),
      containerView.topAnchor.constraint(equalTo: self.topAnchor,constant: 3),
      containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -3)
    ])
    
    NSLayoutConstraint.activate([
      firstLineStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      firstLineStackView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
      firstLineStackView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.11),
      firstLineStackView.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 1),
    ])
    
    NSLayoutConstraint.activate([
      secondLineStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      secondLineStackView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9),
      secondLineStackView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.11),
      secondLineStackView.topAnchor.constraint(equalTo: firstLineStackView.bottomAnchor,constant: 7)
    ])
    
    NSLayoutConstraint.activate([
      thirdLineStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      thirdLineStackView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7),
      thirdLineStackView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.11),
      thirdLineStackView.topAnchor.constraint(equalTo: secondLineStackView.bottomAnchor,constant: 7),
    ])
    
    NSLayoutConstraint.activate([
      shiftButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      shiftButton.centerYAnchor.constraint(equalTo: thirdLineStackView.centerYAnchor),
      shiftButton.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.11),
      shiftButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.1),
      
    ])
    
    NSLayoutConstraint.activate([
      deleteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      deleteButton.centerYAnchor.constraint(equalTo: thirdLineStackView.centerYAnchor),
      deleteButton.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.11),
      deleteButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.1),
      
    ])
    
    NSLayoutConstraint.activate([
      specialCharButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      specialCharButton.topAnchor.constraint(equalTo: thirdLineStackView.bottomAnchor,constant: 7),
      specialCharButton.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.11),
      specialCharButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.25,constant: -3)
    ])
    
    NSLayoutConstraint.activate([
      spaceButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      spaceButton.centerYAnchor.constraint(equalTo: specialCharButton.centerYAnchor),
      spaceButton.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.11),
      spaceButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5,constant: -1.5)
    ])
    
    NSLayoutConstraint.activate([
      returnButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      returnButton.centerYAnchor.constraint(equalTo: specialCharButton.centerYAnchor),
      returnButton.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.11),
      returnButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.25,constant: -3)
    ])
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func makeButtonList(_ list:[String]) -> [CustomRoundButton] {
    var buttonList : [CustomRoundButton] = []
    for char in list {
      let button = CustomRoundButton()
      setupBasicSetting(button: button, backgroundColor: .gray)
      button.setTitle(char, for: .normal)
      button.backgroundColor = #colorLiteral(red: 0.4196077883, green: 0.4196078777, blue: 0.4196078181, alpha: 1)
      button.addTarget(self, action: #selector(pressedChar(_:)), for: .touchUpInside)
      buttonList.append(button)
    }
    return buttonList
  }
  
  private func setupBasicSetting(button : CustomRoundButton, backgroundColor : BackgroundColor) {
    if backgroundColor == .gray{
      button.backgroundColor = #colorLiteral(red: 0.274509728, green: 0.274509728, blue: 0.274509728, alpha: 1)
    } else {
      button.backgroundColor = #colorLiteral(red: 0.4196077883, green: 0.4196078777, blue: 0.4196078181, alpha: 1)
    }
    let selectColor = #colorLiteral(red: 0.8313727379, green: 0.8313727379, blue: 0.8313726187, alpha: 1)
    button.setBackgroundColor(selectColor, for: .highlighted)
    button.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func changeShiftMode() {
    shiftButton.isSelected = !shiftButton.isSelected
    
    if shiftButton.isSelected {
      shiftButton.backgroundColor = #colorLiteral(red: 0.8313727379, green: 0.8313727379, blue: 0.8313726187, alpha: 1)
      shiftButton.imageView?.tintColor = .black
      for button in firstLineButtonList {
        if let title = button.titleLabel?.text {
          if let consonant = KoreanCharacter.koreanConsonant(rawValue: title) {
            let value = KoreanCharacter(consonant: consonant,vowel: nil)
            button.setTitle(value.consonant?.doubleConsonant, for: .normal)
          }
          
          if let vowel = KoreanCharacter.koreanVowel(rawValue: title) {
            let value = KoreanCharacter(consonant: nil, vowel: vowel)
            button.setTitle(value.vowel?.diphthong, for: .normal)
          }
        }
      }
      
    } else {
      shiftButton.backgroundColor = #colorLiteral(red: 0.274509728, green: 0.274509728, blue: 0.274509728, alpha: 1)
      shiftButton.imageView?.tintColor = .white
      for button in firstLineButtonList {
        if let title = button.titleLabel?.text {
          if let consonant = KoreanCharacter.koreanConsonant(rawValue: title) {
            let value = KoreanCharacter(consonant: consonant,vowel: nil)
            button.setTitle(value.consonant?.reverceDoubleConsonant, for: .normal)
          }
          
          if let vowel = KoreanCharacter.koreanVowel(rawValue: title) {
            let value = KoreanCharacter(consonant: nil, vowel: vowel)
            button.setTitle(value.vowel?.reverceDiphthong, for: .normal)
          }
        }
      }
    }
    
  }
  
  @objc func pressedChar(_ sender : Any) {
    if let button = sender as? CustomRoundButton {
      if let char = button.titleLabel?.text{
        if shiftButton.isSelected {
          changeShiftMode()
        }
        guard let unicode = UnicodeScalar(char)?.value else { return }
        viewModel.processText(operation: .charPressed(Int(unicode)))
      }
    }
  }
  
  @objc func pressedSpace(_ sender : Any) {
    viewModel.processText(operation: .spacePressed)
  }
  
  @objc func pressedRetrun(_ sender : Any) {
    pressedRetrunButton?()
  }
  
  @objc func pressedDelete(_ sender : Any) {
    viewModel.processText(operation: .deletePressed)
  }
  
  @objc func pressedShift() {
    changeShiftMode()
  }
}
