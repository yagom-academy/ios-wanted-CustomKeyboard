//
//  CommentView.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit

//MARK: - CommentButtonDelegate
protocol CommentButtonDelegate: AnyObject {
    func present()
    func post()
}


class CommentButton: UIStackView {
    weak var delegate: CommentButtonDelegate?
    
    lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 40, height: 40)
        return imageView
    }()

    lazy var presentButton: TextField = {
        let textField = TextField()
        textField.placeholder = "리뷰를 남겨보세요."
        textField.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
        textField.layer.cornerRadius = 25
        textField.delegate = self
        return textField
    }()

    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
        button.frame.size = CGSize(width: 40, height: 40)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userProfileImageView, presentButton, sendButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hideProfileImage() {
        userProfileImageView.isHidden = true
        sendButton.isHidden = false
    }
    
    func showProfileImage() {
        userProfileImageView.isHidden = false
        sendButton.isHidden = true
    }
}

//MARK: - UITextField Delegate
extension CommentButton: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.delegate?.present()
        return false
    }
}

//MARK: - Objc Method
private extension CommentButton {
    @objc func sendComment() {
        delegate?.post()
    }
}

//MARK: - View Configure
private extension CommentButton {
    func setupUI() {
        [stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        stackView.arrangedSubviews[2].isHidden = true
    }
}
