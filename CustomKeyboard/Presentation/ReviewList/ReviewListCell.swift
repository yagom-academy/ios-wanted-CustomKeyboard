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
    
    let profileImage = UIImageView()
    let userNameLabel = UILabel()
    let contentsLabel = UILabel()
    let timeLabel = UILabel()
    private let declarationStack = UIStackView()
    private let declarationIcon = UIImageView()
    private let declarationLabel = UILabel()
    
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAttribute()
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(data: ReviewListViewModel.CellType?) {
        guard let data = data else {
            return
        }
        
        profileImage.load(url: data.profileURL)
        userNameLabel.text = data.userName
        contentsLabel.text = data.contents
        timeLabel.text = data.createdAt
        
    }

    override func layoutSubviews() {
        self.profileImage.layer.cornerRadius =  self.profileImage.frame.height / 2
        self.profileImage.clipsToBounds = true
    }
}

// MARK: - Setup UI
extension ReviewListCell {
    
    private func configureAttribute() {

        [profileImage, userNameLabel, contentsLabel, timeLabel, declarationStack].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        //유저네임
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
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
    
    private func configureUI() {
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            profileImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15),
            profileImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            userNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
        ])
        
        NSLayoutConstraint.activate([
            contentsLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            contentsLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentsLabel.bottomAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
        ])
        
        declarationStack.addArrangedSubview(declarationIcon)
        declarationStack.addArrangedSubview(declarationLabel)
        NSLayoutConstraint.activate([
            declarationStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            declarationStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
}
