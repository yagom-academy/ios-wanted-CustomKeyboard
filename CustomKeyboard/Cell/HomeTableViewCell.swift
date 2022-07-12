//
//  HomeTableViewCell.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/11.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: HomeTableViewCell.self)

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func prepareForReuse() {
        userImageView.image = nil
        nameLabel.text = nil
        contentLabel.text = nil
        timeLabel.text = nil
    }
    
    override func layoutSubviews() {
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.clipsToBounds = true
    }

    func configureCell(_ review: Review) {
        nameLabel.text = review.user.userName
        contentLabel.text = review.content
        timeLabel.text = TimeManager.shared.getTimeInterval(review.createdAt)
        ImageManager.shared.download(review.user.profileImage) { data in
            DispatchQueue.main.async {
                self.userImageView.image = UIImage(data: data)
            }
        }
    }
}
