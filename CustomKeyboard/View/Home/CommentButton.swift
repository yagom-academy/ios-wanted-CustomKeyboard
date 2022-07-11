//
//  CommentView.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit

protocol CommentButtonDelegate: AnyObject {
    func present()
}

class CommentButton: UIView {
    weak var delegate: CommentButtonDelegate?
    
    lazy var userProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.image = UIImage(systemName: "person.circle.fill")
        return imageView
    }()
    
    lazy var presentButton: TextField = {
        let textField = TextField()
        textField.placeholder = "이 테마가 마음에 드시나요?"
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        textField.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
        textField.layer.cornerRadius = 25
        textField.delegate = self
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        [userProfileImage,presentButton].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            userProfileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userProfileImage.topAnchor.constraint(equalTo: self.topAnchor),
            userProfileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            userProfileImage.widthAnchor.constraint(equalToConstant: 50),
            userProfileImage.heightAnchor.constraint(equalToConstant: 50),
            
            presentButton.leadingAnchor.constraint(equalTo: userProfileImage.trailingAnchor,constant: 10),
            presentButton.topAnchor.constraint(equalTo: userProfileImage.topAnchor),
            presentButton.bottomAnchor.constraint(equalTo: userProfileImage.bottomAnchor),
            presentButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
}

extension CommentButton: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.presentButton.resignFirstResponder()
        self.delegate?.present()
        return false
    }
}
