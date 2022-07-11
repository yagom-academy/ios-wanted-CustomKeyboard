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
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "별점 : ⭐️⭐️⭐️⭐️⭐️"
        label.font = .systemFont(ofSize: 15.0, weight: .light)
        label.textColor = UIColor.red
        
        return label
    }()
    
    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15.0, weight: .light)
        label.text = "리뷰 : 아진짜 귀여워요!!!"
        
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
    
    func setUp() {
        let labelStackView = UIStackView(arrangedSubviews: [ userNameLabel, ratingLabel, reviewLabel, timeLabel ])
        labelStackView.axis = .vertical
        labelStackView.spacing = 10.0
        labelStackView.distribution = .fillEqually
        
        [ profileImageView, labelStackView].forEach { addSubview($0)}
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            labelStackView.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20)
        ])
    }

}
