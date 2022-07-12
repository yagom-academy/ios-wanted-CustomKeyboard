//
//  TableViewCell.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/11.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    static let cellID = "CellID"
    
    public var userProfileImageView : UIImageView!
    public var userIdLable : UILabel!
    public var reviewRateLable : UILabel!
    public var contentLable : UILabel!
    public var lastUpdateTimeLabel : UILabel!
    public var reportButton : UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        setUpCell()
        
        contentView.addSubview(userIdLable)
        contentView.addSubview(reviewRateLable)
        contentView.addSubview(contentLable)
        contentView.addSubview(lastUpdateTimeLabel)
        contentView.addSubview(userProfileImageView)
        contentView.addSubview(reportButton)

        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        userIdLable.translatesAutoresizingMaskIntoConstraints = false
        reviewRateLable.translatesAutoresizingMaskIntoConstraints = false
        contentLable.translatesAutoresizingMaskIntoConstraints = false
        lastUpdateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        reportButton.translatesAutoresizingMaskIntoConstraints = false
        
        userProfileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10).isActive = true
        userProfileImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        userIdLable.topAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant: 10).isActive = true
        userIdLable.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10).isActive = true
        
        reviewRateLable.topAnchor.constraint(equalTo: userIdLable.bottomAnchor, constant: 10).isActive = true
        reviewRateLable.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10).isActive = true
        
        contentLable.topAnchor.constraint(equalTo: reviewRateLable.bottomAnchor, constant: 5).isActive = true
        contentLable.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10).isActive = true
        
        lastUpdateTimeLabel.topAnchor.constraint(equalTo: contentLable.bottomAnchor, constant: 5).isActive = true
        lastUpdateTimeLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10).isActive = true
        
        reportButton.centerYAnchor.constraint(equalTo: userIdLable.centerYAnchor).isActive = true
        reportButton.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -10).isActive = true
        reportButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
        
    }
    
    private func setUpCell() {
        userIdLable = UILabel()
        userIdLable.textColor = .black
        userIdLable.font = UIFont.boldSystemFont(ofSize: 16)
        userIdLable.text = "o달빔o"
        
        reviewRateLable = UILabel()
        reviewRateLable.textColor = .black
        reviewRateLable.font = UIFont.systemFont(ofSize: 15)
        reviewRateLable.text = "Rating : ⭐⭐⭐⭐⭐️"
        
        contentLable = UILabel()
        contentLable.textColor = .black
        contentLable.font = UIFont.systemFont(ofSize: 15)
        contentLable.text = "Review : "
        
        lastUpdateTimeLabel = UILabel()
        lastUpdateTimeLabel.textColor = .lightGray
        lastUpdateTimeLabel.font = UIFont.systemFont(ofSize: 13)
        lastUpdateTimeLabel.text = "1분"
        
        userProfileImageView = UIImageView()
        userProfileImageView.image = UIImage(named: "default_image")
        userProfileImageView.frame.size.height = 30
        userProfileImageView.frame.size.width = 30
        userProfileImageView.contentMode = .scaleAspectFit
        
        reportButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        let attributedTitle = NSAttributedString(string: "신고", attributes: attribute)
        reportButton.setAttributedTitle(attributedTitle, for: .normal)
        reportButton.setTitleColor(.black, for: .normal)
        reportButton.tintColor = .lightGray
        reportButton.setImage(UIImage(named: "siren.png"), for: .normal)
        reportButton.imageView?.contentMode = .scaleAspectFit
        reportButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }

}
