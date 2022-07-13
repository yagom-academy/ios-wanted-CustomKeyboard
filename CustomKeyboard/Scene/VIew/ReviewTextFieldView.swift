//
//  KeyboardtextFieldView.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/13.
//

import UIKit

class ReviewTextFieldView: UIView {
  
  var done:((String) -> ())?
  
  
  let userProfileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "default_image")
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    return imageView
  }()
  
  let reviewTextField: UITextField = {
    let textField = UITextField()
    textField.layer.cornerRadius = 20
    textField.placeholder = "이 테마가 마음에 드시나요?"
    textField.font = UIFont.systemFont(ofSize: 15)
    textField.textColor = .black
    textField.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    textField.addLeftPadding()
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(userProfileImageView)
    addSubview(reviewTextField)
    
    reviewTextField.delegate = self
    
    NSLayoutConstraint.activate([
      userProfileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      userProfileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
      userProfileImageView.heightAnchor.constraint(equalToConstant: 50),
      userProfileImageView.widthAnchor.constraint(equalToConstant: 50)
    ])
    
    NSLayoutConstraint.activate([
      reviewTextField.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor),
      reviewTextField.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 10),
      reviewTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
      reviewTextField.heightAnchor.constraint(equalToConstant: 40),
    ])
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension ReviewTextFieldView : UITextFieldDelegate {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.endEditing(true)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let text = textField.text else {return true}
    done?(text)
    textField.resignFirstResponder()
    return true
  }
}

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
