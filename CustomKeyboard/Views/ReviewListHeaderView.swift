//
//  ReviewListHeaderView.swift
//  CustomKeyboard
//
//  Created by 효우 on 2022/07/12.
//

import UIKit

protocol PresentButtonSelectable {
    func presentButtonStatus()
}

class ReviewListHeaderView: UITableViewHeaderFooterView {
    
    var delegate: PresentButtonSelectable!

    private let profileImageView: UIImageView = {
        let profileImageVIew = UIImageView()
        profileImageVIew.image = UIImage(systemName: "person.fill")
        return profileImageVIew
    }()
    
    private let reviewTextField: UITextField = {
        let reviewTextField = UITextField()
        reviewTextField.backgroundColor = .systemGray5
        reviewTextField.layer.cornerRadius = 20
        reviewTextField.placeholder = " 이 테마가 마음에 드시나요?"
        reviewTextField.font = UIFont.systemFont(ofSize: 16)
        reviewTextField.isEnabled = false
        return reviewTextField
    }()

    private let presentButton: UIButton = {
        let presentButton = UIButton()
        presentButton.backgroundColor = .clear
        presentButton.addTarget(nil, action: #selector(showCreateReivewVC), for: .touchUpInside)
        return presentButton
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(reviewTextField)
        contentView.addSubview(presentButton)

        presentButton.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        reviewTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            profileImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.9),
            
            reviewTextField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            reviewTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            reviewTextField.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            reviewTextField.heightAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 0.5),
            
            presentButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            presentButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            presentButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            presentButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    @objc func showCreateReivewVC() {
        delegate.presentButtonStatus()
    }
    
}
