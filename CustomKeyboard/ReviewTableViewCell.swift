//
//  ReviewTableViewCell.swift
//  CustomKeyboard
//
//  Created by 효우 on 2022/07/12.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    private let profileImageView: UIImageView = {
        let profileImageVIew = UIImageView()
        profileImageVIew.image = UIImage(systemName: "person.fill")
        return profileImageVIew
    }()
    
    private let nickNameLabel: UILabel = {
        let nickNameLabel = UILabel()
        nickNameLabel.text = "닉네임"
        nickNameLabel.font = UIFont.systemFont(ofSize: 18)
        return nickNameLabel
    }()
    
    private let rateLabel: UILabel = {
        let rateLabel = UILabel()
        rateLabel.text = "별점: ⭐️"
        rateLabel.font = UIFont.systemFont(ofSize: 16)
        return rateLabel
    }()
    
    private let reviewLabel: UILabel = {
        let reviewLabel = UILabel()
        reviewLabel.text = "리뷰: 굳"
        reviewLabel.font = UIFont.systemFont(ofSize: 16)
        return reviewLabel
    }()
    
    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "1분 전"
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = .systemGray2
        return timeLabel
    }()
    
    private let labelStackView: UIStackView = {
        let labelStackView = UIStackView()
        labelStackView.alignment = .leading
        labelStackView.axis = .vertical
        labelStackView.spacing = 0
        labelStackView.distribution = .equalSpacing
        return labelStackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(nickNameLabel)
        labelStackView.addArrangedSubview(rateLabel)
        labelStackView.addArrangedSubview(reviewLabel)
        labelStackView.addArrangedSubview(timeLabel)
        
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            profileImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.9),
            
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            labelStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}

