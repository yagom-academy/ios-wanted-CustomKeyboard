//
//  WriteReviewButtonView.swift
//  CustomKeyboard
//
//  Created by JunHwan Kim on 2022/07/11.
//

import UIKit

class WriteReviewButtonView: UIView {
    // MARK: - ViewProperties
    private lazy var profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        return profileImageView
    }()
    
    private lazy var writeReviewButton: UIButton = {
        let writeReviewButton = UIButton()
        writeReviewButton.backgroundColor = .systemGray5
        writeReviewButton.setTitle("", for: .normal)
        return writeReviewButton
    }()
    
    private lazy var sendReviewButton: UIButton = {
        let sendReviewButton = UIButton()
        sendReviewButton.addTarget(self, action: #selector(tapSendReviewButton), for: .touchUpInside)
        return sendReviewButton
    }()
    
    // MARK: - LifeCycle
    init() {
        super.init(frame: .zero)
        configureSubViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        writeReviewButton.layer.cornerRadius = writeReviewButton.bounds.height / 2
    }
    
    @objc func tapSendReviewButton(){
        var networkManager = NetworkManager()
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
        NSLayoutConstraint.activate([
            writeReviewButton.heightAnchor.constraint(equalToConstant: 50),
            writeReviewButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            writeReviewButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            writeReviewButton.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
}
