//
//  reviewTableviewCell.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/14.
//

import UIKit

class ReviewTableviewCell: UITableViewCell {
    
    static let identifier = "ReviewTableviewCell"
    
    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    private let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let condent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
        
    private func config() {
        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        contentView.addSubview(condent)
        let margin: CGFloat = 10
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: self.topAnchor),
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 100),
            userImage.heightAnchor.constraint(equalToConstant: 100),
                
            userName.topAnchor.constraint(equalTo: self.topAnchor),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: margin),
            userName.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                
            condent.topAnchor.constraint(equalTo: userName.bottomAnchor),
            condent.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: margin),
            condent.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            condent.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            condent.heightAnchor.constraint(equalTo: userName.heightAnchor),
            ])
    }
    
    func configure(review: Review?) {
        guard let review = review else {
            return
        }

        if let url = URL(string: review.user.profileImage),let data = try? Data(contentsOf: url){
            self.userImage.image = UIImage(data: data)
        }else{
            self.userImage.image = UIImage(systemName: "heart")
        }
        self.userName.text = review.user.userName
        self.condent.text = review.content
    }
}
