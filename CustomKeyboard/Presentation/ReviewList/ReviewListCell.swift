//
//  ReviewListCell.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/13.
//

import UIKit

final class ReviewListCell: UICollectionViewCell, ReuseIdentifying {
    
    // MARK: - Properties
    private let profileImage = UIImageView()
    private let userNameLabel = UILabel()
    private let contentsLabel = UILabel()
    private let timeLabel = UILabel()
    private let declarationStack = UIStackView()
    private let declarationIcon = UIImageView()
    private let declarationLabel = UILabel()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: ReviewListViewModel.ReviewData?) {
        
        guard let data = data else {
            return
        }
        
        profileImage.load(urlString: data.profileURLStrig)
        userNameLabel.text = data.userName
        contentsLabel.text = data.contents
        timeLabel.text = data.createdAt
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.profileImage.layer.cornerRadius =  self.profileImage.frame.height / 2
        self.profileImage.clipsToBounds = true
    }
    
}

// MARK: - ConfigureUI
extension ReviewListCell {
    private func configureUI() {
        
        configureAttribute()
        configureLayout()
    }
    
    private func configureAttribute() {
        
        contentView.layer.addBorder(rectEdge: [.bottom], color: .systemGray5, width: 1)
        
        [profileImage, userNameLabel, contentsLabel, timeLabel, declarationStack].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //유저네임
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        contentsLabel.numberOfLines = 3
        
        //시간
        timeLabel.textColor = .lightGray
        timeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        //신고 스택뷰
        declarationStack.axis = .horizontal
        declarationStack.spacing = 5
        
        //신고 아이콘
        let imageIcon = UIImage(systemName: "lightbulb.circle.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        declarationIcon.image = imageIcon
        
        //신고 라벨
        declarationLabel.textColor = .lightGray
        declarationLabel.text = "신고"
    }
    
    private func configureLayout() {
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            profileImage.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            userNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
        ])
        
        NSLayoutConstraint.activate([
            contentsLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            contentsLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            contentsLabel.trailingAnchor.constraint(equalTo: declarationStack.leadingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentsLabel.bottomAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
        ])
        
        declarationStack.addArrangedSubview(declarationIcon)
        declarationStack.addArrangedSubview(declarationLabel)
        NSLayoutConstraint.activate([
            declarationStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            declarationStack.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -65),
            declarationStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}
