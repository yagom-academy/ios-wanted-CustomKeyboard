//
//  ReviewListCell.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/13.
//

import UIKit

class ReviewListCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "ReviewListCell"
    
    var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var contentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var declarationStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var declarationIcon: UIImageView = {
        let imageView = UIImageView()
        let imageIcon = UIImage(systemName: "lightbulb.circle.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        imageView.image = imageIcon
        return imageView
    }()
    
    var declarationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "신고"
        return label
    }()
    
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.profileImage.layer.cornerRadius = self.frame.size.width / 2.0;
    }
}

// MARK: - Setup UI
extension ReviewListCell {
    
    private func setupUI() {
        
        contentView.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            profileImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
        
        contentView.addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            userNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
        ])
        
        contentView.addSubview(contentsLabel)
        NSLayoutConstraint.activate([
            contentsLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            contentsLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
        ])
        
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentsLabel.bottomAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
        ])
        
        contentView.addSubview(declarationStack)
        declarationStack.addArrangedSubview(declarationIcon)
        declarationStack.addArrangedSubview(declarationLabel)
        NSLayoutConstraint.activate([
            declarationStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            declarationStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}

