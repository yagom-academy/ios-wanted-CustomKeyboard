//
//  WriteReviewButtonView.swift
//  CustomKeyboard
//
//  Created by JunHwan Kim on 2022/07/11.
//

import Foundation
import UIKit

class WriteReviewButtonView : UIView{
    
    private lazy var profileImageView : UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        return profileImageView
    }()
    
    private lazy var writeReviewButton : UIButton = {
        let writeReviewButton = UIButton()
        writeReviewButton.translatesAutoresizingMaskIntoConstraints = false
        writeReviewButton.backgroundColor = .systemGray5
        return writeReviewButton
    }()
    
    private lazy var sendReviewButton : UIButton = {
        let sendReviewButton = UIButton()
        sendReviewButton.translatesAutoresizingMaskIntoConstraints = false
        return sendReviewButton
    }()
    
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews() 
        writeReviewButton.layer.cornerRadius = writeReviewButton.bounds.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        addSubview(profileImageView)
        addSubview(writeReviewButton)
        addSubview(sendReviewButton)
        NSLayoutConstraint.activate([
            
            profileImageView.heightAnchor.constraint(equalToConstant:  50),
            profileImageView.widthAnchor.constraint(equalToConstant:  50),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            //writeReviewButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            writeReviewButton.heightAnchor.constraint(equalToConstant: 50),
            writeReviewButton.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            writeReviewButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            writeReviewButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            //sendReviewButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
}
