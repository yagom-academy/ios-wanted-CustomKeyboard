//
//  ReviewListViewController.swift
//  CustomKeyboard
//
//  Created by CHUBBY on 2022/07/11.
//

import UIKit

final class ReviewListCell: UITableViewCell {
    
    static let identifier = "ReviewListCell"
    
    // MARK: - ViewProperties
    private lazy var profileImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "person.circle.fill")
        
        return imgView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        return label
    }()
    
    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15.0, weight: .light)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 15.0, weight: .light)
        label.textColor = UIColor.gray
        
        return label
    }()
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    func configureCell(with reviewModel: ReviewViewModel) {
        userNameLabel.text = reviewModel.name
        reviewLabel.text = reviewModel.content
        timeLabel.text = reviewModel.createDate
        profileImageView.load(urlString: reviewModel.profileImage)
    }
}

// MARK: - UI
extension ReviewListCell {
    private func configureSubViews() {
        
        [profileImageView, userNameLabel,
         reviewLabel, timeLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
    
    private func setConstraints() {
        setConstraintsOfProfileImageView()
        setConstraintsUserNameLabel()
        setConstraintsReviewLabel()
        setConstraintsOfTimeLabel()
    }
    
    private func setConstraintsOfProfileImageView() {
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        ])
    }
    
    private func setConstraintsUserNameLabel() {
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            userNameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -20),
        ])
    }
    
    private func setConstraintsReviewLabel() {
        NSLayoutConstraint.activate([
            reviewLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5),
            reviewLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            reviewLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor)
        ])
    }
    
    private func setConstraintsOfTimeLabel() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: reviewLabel.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: userNameLabel.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
