//
//  ReviewListViewController.swift
//  CustomKeyboard
//
//  Created by CHUBBY on 2022/07/11.
//

import UIKit

final class ReviewListCell: UITableViewCell {
    
    static let identifier = "ReviewListCell"
    
    private lazy var profileImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "person.circle.fill")
        
        return imgView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        label.text = "홍길동"
        
        return label
    }()
    
//    private lazy var ratingLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .label
//        label.text = "별점 : ⭐️⭐️⭐️⭐️⭐️"
//        label.font = .systemFont(ofSize: 15.0, weight: .light)
//        label.textColor = UIColor.red
//
//        return label
//    }()
    
    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15.0, weight: .light)
        label.text = "리뷰 : 아진짜 귀여워요!!!"
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "1분전"
        label.font = .systemFont(ofSize: 15.0, weight: .light)
        label.textColor = UIColor.gray
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        
        [profileImageView, userNameLabel,
        reviewLabel, timeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
            
        }
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            userNameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -20),
        ])
        
        NSLayoutConstraint.activate([
//            ratingLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
//            ratingLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
//            ratingLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            reviewLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
            reviewLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            reviewLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: reviewLabel.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func configure(with reviewModel: ReviewViewModel) {
        userNameLabel.text = reviewModel.name
        reviewLabel.text = reviewModel.content
        timeLabel.text = reviewModel.createDate
        profileImageView.load(url: reviewModel.profileImage)
    }

}
