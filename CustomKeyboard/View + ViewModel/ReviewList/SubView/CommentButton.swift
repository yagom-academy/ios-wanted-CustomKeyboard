//
//  CommentView.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/11.
//

import UIKit

class CommentButton: UIView {
    
    lazy var userProfileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        imageView.contentMode = .scaleAspectFit
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
        
        let config = UIImage.SymbolConfiguration(pointSize: 26, weight: .bold, scale: .medium)
        let imageview = UIImage(systemName: "paperplane.fill", withConfiguration: config)
        button.setImage(imageview, for: .normal)
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
        }
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
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 48),
            userProfileImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2),
            presentTextView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.7),
            sendButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2)
        ])
        
        stackView.arrangedSubviews[2].isHidden = true
    }
}
