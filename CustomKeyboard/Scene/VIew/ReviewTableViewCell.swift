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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var userIdLable: UILabel = {
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
//        lable.text = "Review : "
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    private var lastUpdateTimeLabel: UILabel = {
        let lable = UILabel()
        lable.textColor = .lightGray
        lable.font = UIFont.systemFont(ofSize: 13)
        lable.text = "1분"
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
        let stackView = UIStackView(arrangedSubviews: [userIdLable,reviewRateLable,contentLable,lastUpdateTimeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(containterView)
        containterView.addSubview(userProfileImageView)
        containterView.addSubview(userInfoStackView)
        containterView.addSubview(reportButton)
        
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
            userInfoStackView.topAnchor.constraint(equalTo: containterView.topAnchor,constant: 10),
            userInfoStackView.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 10),
            userInfoStackView.bottomAnchor.constraint(equalTo: containterView.bottomAnchor,constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            reportButton.centerYAnchor.constraint(equalTo: userIdLable.centerYAnchor),
            reportButton.rightAnchor.constraint(equalTo: containterView.rightAnchor,constant: -10),
            reportButton.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
        
    public func setupReviewData(_ review : Review) {
//      guard let rate = review.content["Rating"] else {return}
      userIdLable.text = review.user.userName
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
}
