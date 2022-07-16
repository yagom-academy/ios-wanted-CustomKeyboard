//
//  CommentView.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit

class CommentButton: UIStackView {
    
    lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize(width: 40, height: 40)
        return imageView
    }()
    
    
    lazy var presentTextView: BasePaddingTextView = {
        let textView = BasePaddingTextView()
        textView.textColor = .label
        textView.layer.backgroundColor = UIColor.secondarySystemBackground.cgColor
        textView.layer.cornerRadius = 25
        textView.inputView?.clipsToBounds = true
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.textContainer.maximumNumberOfLines = 1
        textView.backgroundColor = .secondarySystemBackground
        textView.isEditable = false
        return textView
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userProfileImageView, presentTextView, sendButton])
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
    
    func toggleAnimation(_ isSuccess: Bool) {
        UIView.animate(withDuration: 1) {
            self.userProfileImageView.isHidden = !isSuccess
            self.sendButton.isHidden = isSuccess
            if isSuccess {
                self.clearText()
            }
        }
    }
    
    func clearText() {
        presentTextView.text = ""
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
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            presentTextView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7)
        ])
        
        stackView.arrangedSubviews[2].isHidden = true
    }
}
