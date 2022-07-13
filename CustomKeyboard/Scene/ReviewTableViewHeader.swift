//
//  ReviewTableViewHeader.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/12.
//

import UIKit

class ReviewTableViewHeader: UITableViewHeaderFooterView {
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 30
        image.image = UIImage(systemName: "person.circle.fill")
        image.tintColor = .lightGray
        
        return image
    }()
    
    let reviewTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 20
        textField.placeholder = "이 테마가 마음에 드시나요?"
        textField.addLeftPadding()
        textField.textColor = .secondaryLabel
        textField.backgroundColor = .secondarySystemBackground
        
        return textField
    }()
    
    private let writeButton: UIButton = {
        let button = UIButton()
        button.setTitle("작성", for: .normal)
        button.tintColor = .label
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray
        
        return button
    }()
    
    func setup() {
        layout()
    }
}

extension ReviewTableViewHeader {
    private func layout() {
        [
            profileImage,
            reviewTextField,
            writeButton
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let inset: CGFloat = 12
        
        profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: inset).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset).isActive = true
        
        reviewTextField.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        reviewTextField.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: inset).isActive = true
        reviewTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -74).isActive = true
        reviewTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        writeButton.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        writeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset).isActive = true
        writeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        writeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
