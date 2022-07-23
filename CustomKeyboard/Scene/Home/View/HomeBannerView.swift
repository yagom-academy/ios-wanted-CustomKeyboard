//
//  KeyboardtextFieldView.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/13.
//

import UIKit

final class HomeBannerView: UIView {
  
  var buttonDidTap:(() -> Void)?
  
  private let userProfileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "default_image")
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let reviewButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 20
    button.setTitle("이 테마가 마음에 드시나요?", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    button.setTitleColor(UIColor.black, for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    setReviewButtonAction()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}


private extension HomeBannerView {
  
  func setConstraints() {
    addSubview(userProfileImageView)
    addSubview(reviewButton)
    
    NSLayoutConstraint.activate([
      userProfileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      userProfileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
      userProfileImageView.heightAnchor.constraint(equalToConstant: 50),
      userProfileImageView.widthAnchor.constraint(equalToConstant: 50)
    ])
    
    NSLayoutConstraint.activate([
      reviewButton.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor),
      reviewButton.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 10),
      reviewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
      reviewButton.heightAnchor.constraint(equalToConstant: 40),
    ])
  }
  
  func setReviewButtonAction() {
    reviewButton.addTarget(self, action: #selector(reviewButtonDidTap), for: .touchUpInside)
  }
  
  @objc  func reviewButtonDidTap() {
    buttonDidTap?()
  }
  
}



