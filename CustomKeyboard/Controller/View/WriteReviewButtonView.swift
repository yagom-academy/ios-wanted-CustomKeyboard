//
//  WriteReviewButtonView.swift
//  CustomKeyboard
//
//  Created by JunHwan Kim on 2022/07/11.
//

import UIKit

class WriteReviewButtonView: UIView {
    
    // MARK: - Properties
    private var writeReviewButtonTrailingConstraint: NSLayoutConstraint!
    
    // MARK: - ViewProperties
    private lazy var profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        return profileImageView
    }()
    
    lazy var writeReviewButton: UIButton = {
        let writeReviewButton = UIButton()
        writeReviewButton.backgroundColor = .systemGray5
        writeReviewButton.setTitleColor(UIColor.black, for: .normal)
        writeReviewButton.setTitle("이 테마가 마음에 드시나요?", for: .normal)
        
        return writeReviewButton
    }()
    
    lazy var sendReviewButton: UIButton = {
        let sendReviewButton = UIButton()
        sendReviewButton.setTitle("작성", for: .normal)
        sendReviewButton.setTitleColor(UIColor.black, for: .normal)
        
        sendReviewButton.addTarget(self, action: #selector(tapSendReviewButton), for: .touchUpInside)
        
        return sendReviewButton
    }()
    
    // MARK: - LifeCycle
    init() {
        super.init(frame: .zero)
        configureSubViews()
        setConstraints()
        showSendReviewButton(isCanSend: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        writeReviewButton.layer.cornerRadius = writeReviewButton.bounds.height / 2
    }
    
    // MARK: - Method
    func showSendReviewButton(isCanSend: Bool) {
        print("asdf")
        sendReviewButton.isHidden = isCanSend ? false : true
        writeReviewButtonTrailingConstraint.constant = isCanSend ? -60 : -10
    }
    
    @objc func tapSendReviewButton(){
        let networkManager = NetworkManager()
        guard let content = writeReviewButton.currentTitle else {return}
        networkManager.uploadPost(with: PostReviewModel(content: content)) { success in
            if success{
                DispatchQueue.main.async {
                    self.writeReviewButton.setTitle("", for: .normal)
                }
            }
        }
    }
}


// MARK: - UI
extension WriteReviewButtonView {
    private func configureSubViews() {
        [profileImageView, writeReviewButton, sendReviewButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
    
    private func setConstraints() {
        setConstraintsOfProfileImageView()
        setConstraintsOfWriteReviewButton()
        setConstraintsOfSendReviewButton()
    }
    
    private func setConstraintsOfProfileImageView() {
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant:  50),
            profileImageView.widthAnchor.constraint(equalToConstant:  50),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    private func setConstraintsOfWriteReviewButton() {
        writeReviewButtonTrailingConstraint = writeReviewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        NSLayoutConstraint.activate([
            writeReviewButton.heightAnchor.constraint(equalToConstant: 50),
            writeReviewButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            writeReviewButtonTrailingConstraint,
            writeReviewButton.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    
    private func setConstraintsOfSendReviewButton() {
        NSLayoutConstraint.activate([
            sendReviewButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            sendReviewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
        ])
    }
}

