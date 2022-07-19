//
//  HomeTableViewCell.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/11.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: HomeTableViewCell.self)

    @IBOutlet weak var userImageView: LazyImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        contentLabel.text = nil
        timeLabel.text = nil
    }
    
    func configureCell(_ review: Review) {
        nameLabel.text = review.user.userName
        contentLabel.text = review.content
        timeLabel.text = TimeManager().getTimeInterval(review.createdAt)
        userImageView.loadImage(review.user.profileImage)
    }
}

// MARK: - Private

extension HomeTableViewCell {
    private func configureImageViewCircle() {
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.clipsToBounds = true
    }
}
