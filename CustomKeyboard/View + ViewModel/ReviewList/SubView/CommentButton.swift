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
        textView.delegate = self
        return textView
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.addTarget(self, action: #selector(sendComment), for: .touchUpInside)
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
        DispatchQueue.main.async {
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

extension CommentButton: UITextViewDelegate {    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        delegate?.present()
        return false
    }
}

//extension CommentButton: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.resignFirstResponder()
//        delegate?.present()
//    }
//}

//MARK: - Objc Method
private extension CommentButton {
    @objc func didTapPresentText() {
        self.delegate?.present()
    }
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
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            presentTextView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        stackView.arrangedSubviews[2].isHidden = true
    }
}
