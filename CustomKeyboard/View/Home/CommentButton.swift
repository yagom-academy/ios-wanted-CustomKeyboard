//
//  CommentView.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit

protocol CommentButtonDelegate: AnyObject {
    func present()
    func post()
}
class CommentButton: UIStackView {
    weak var delegate: CommentButtonDelegate?
    lazy var stackView: UIStackView = {
        let userProfileImageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        userProfileImageView.contentMode = .scaleAspectFit
        userProfileImageView.frame.size = CGSize(width: 40, height: 40)
        
        let presentButton = TextField()
        presentButton.placeholder = "리뷰를 남겨보세요."
        presentButton.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
        presentButton.layer.cornerRadius = 25
        presentButton.delegate = self
        
        let sendButton = UIButton()
        sendButton.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        sendButton.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
        sendButton.frame.size = CGSize(width: 40, height: 40)
        
        let stackView = UIStackView(arrangedSubviews: [userProfileImageView,presentButton,sendButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    @objc func sendComment() {
        delegate?.post()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

extension CommentButton: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.delegate?.present()
        return false
    }
}


