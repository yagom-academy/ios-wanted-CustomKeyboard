//
//  TableViewCell.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/11.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    static let cellID = "CellID"
    
    private var containterView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "default_image")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var userNameLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.boldSystemFont(ofSize: 16)
//        lable.text = "o달빔o"
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private var reviewRateLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    private var contentLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.numberOfLines = 0
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    private var lastUpdateTimeLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = .lightGray
        lable.font = UIFont.systemFont(ofSize: 13)
        lable.text = "1분"
        lable.frame.size.height = 10
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    private var reportButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)]
        let attributedTitle = NSAttributedString(string: "신고", attributes: attribute)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "siren.png"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [reviewRateLable,contentLable,lastUpdateTimeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(containterView)
        containterView.addSubview(userProfileImageView)
        containterView.addSubview(userInfoStackView)
        containterView.addSubview(reportButton)
        containterView.addSubview(userNameLable)
        
        NSLayoutConstraint.activate([
            containterView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            containterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containterView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            containterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containterView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userProfileImageView.leftAnchor.constraint(equalTo: containterView.leftAnchor,constant: 10),
            userProfileImageView.topAnchor.constraint(equalTo: containterView.topAnchor,constant: 10),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 50),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            userNameLable.topAnchor.constraint(equalTo: containterView.topAnchor,constant: 10),
            userNameLable.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10),
            userNameLable.rightAnchor.constraint(equalTo: reportButton.leftAnchor,constant: 10),
            userNameLable.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            reportButton.centerYAnchor.constraint(equalTo: userNameLable.centerYAnchor),
            reportButton.rightAnchor.constraint(equalTo: containterView.rightAnchor,constant: -10),
            reportButton.heightAnchor.constraint(equalToConstant: 10),
            reportButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            userInfoStackView.topAnchor.constraint(equalTo: userNameLable.bottomAnchor,constant: 8),
            userInfoStackView.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10),
            userInfoStackView.rightAnchor.constraint(equalTo: containterView.rightAnchor, constant: -10),
            userInfoStackView.bottomAnchor.constraint(equalTo: containterView.bottomAnchor,constant: -10),
        ])
    }
        
    public func setupReviewData(_ review : Review) {
//      guard let rate = review.content["Rating"] else {return}
      userNameLable.text = review.user.userName
      reviewRateLable.text = review.content["Rating"] != nil ? "Rating: \(String(describing: review.content["Rating"]!))" : nil
      contentLable.text = review.content["Review"] != nil ? "Review: \(String(describing: review.content["Review"]!))" : nil
      lastUpdateTimeLabel.text = review.lastModifiedAt
    }
  
    func setProfileImage(_ data: Data?){
      guard let data = data else {return}
      userProfileImageView.image = UIImage(data: data)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    userProfileImageView.image =  UIImage(named: "default_image")
  }
}
