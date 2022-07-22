//
//  ReviewContentView.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/23.
//

import UIKit

class ReviewContentView: UIView {
  
  var startEditing:((String?) -> Void)?
  
  let placeHolderText = "어떤점이 인상 깊었나요?"
  
  private let userProfileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "default_image")
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let reviewerInfoLabel: UILabel = {
    let view = UILabel()
    view.layer.cornerRadius = 20
    view.text = "o달빔o"
    view.font = UIFont.systemFont(ofSize: 15)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  

  lazy var reviewTextView: UITextView = {
    let textView = UITextView()
    textView.text = "어떤점이 인상 깊었나요?"
    textView.textColor = .lightGray
    textView.inputView = customKeyboard
    textView.font = UIFont.systemFont(ofSize: 20)
    textView.delegate = self
    let contentHeight = textView.contentSize.height
    let offSet = textView.contentOffset.x
    let contentOffset = contentHeight - offSet
    textView.contentOffset = CGPoint(x: 0,y: -contentOffset)
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  
  
  let customKeyboard = CustomKeyboardView(frame: CGRect(x: 0, y: 0, width: 0, height: UIScreen.main.bounds.height / 3.4))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    setConstraints()
    setCustomKeyBoardClosure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


private extension ReviewContentView {
  func setConstraints() {
    addSubview(userProfileImageView)
    addSubview(reviewerInfoLabel)
    addSubview(reviewTextView)

    NSLayoutConstraint.activate([
      userProfileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
      userProfileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
      userProfileImageView.widthAnchor.constraint(equalToConstant: 50)
    ])
    
    NSLayoutConstraint.activate([
      reviewerInfoLabel.topAnchor.constraint(equalTo: userProfileImageView.topAnchor),
      reviewerInfoLabel.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 10),
      reviewerInfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
      reviewerInfoLabel.bottomAnchor.constraint(equalTo: userProfileImageView.bottomAnchor)
    ])
    
    NSLayoutConstraint.activate([
      reviewTextView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 16),
      reviewTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      reviewTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      reviewTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
  }
  
  func setCustomKeyBoardClosure() {
    customKeyboard.pressedRetrunButton = {
      self.reviewTextView.text += "\n"
      self.startEditing?(self.reviewTextView.text)
    }
    customKeyboard.buttonPressed = {
      self.reviewTextView.text = $0
      self.startEditing?(self.reviewTextView.text)
    }
  }

}


extension ReviewContentView: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == placeHolderText {
      textView.text = nil
      textView.textColor = .black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      textView.text = placeHolderText
      textView.textColor = .lightGray
    }
  }
  
}
