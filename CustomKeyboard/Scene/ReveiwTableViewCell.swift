//
//  ReveiwTableViewCell.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/12.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        image.tintColor = .lightGray
        
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private let warningLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .secondaryLabel
        label.text = "🚨 신고"
        
        return label
    }()
    
    private let starLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    func setup(_ review: Review) {
        layout()
        
        profileImage.image = urlToImage(review.user.profileImage)
        nameLabel.text = review.user.userName
        timeLabel.text = dateToTime(review.createdAt)
        starLabel.text = "별점: "
        reviewLabel.text = "리뷰: "
    }
}

extension ReviewTableViewCell {
    func layout() {
        [
            profileImage,
            nameLabel,
            warningLabel,
            starLabel,
            reviewLabel,
            timeLabel
        ].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let inset: CGFloat = 12
        
        profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: inset).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: inset).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60).isActive = true
        
        warningLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
        warningLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset).isActive = true
        
        starLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: inset).isActive = true
        starLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: inset).isActive = true
        starLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset).isActive = true
        
        reviewLabel.topAnchor.constraint(equalTo: starLabel.bottomAnchor, constant: 8).isActive = true
        reviewLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: inset).isActive = true
        reviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset).isActive = true
        
        timeLabel.topAnchor.constraint(equalTo: reviewLabel.bottomAnchor, constant: 8).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: inset).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset).isActive = true
    }
    
    private func dateToTime(_ createdAt: String) -> String {
        let time = createdAt.components(separatedBy: ["-", "T", ":", "Z"]).map{ Int($0) ?? 0 }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        let currentTime = formatter.string(from: Date()).components(separatedBy: "_").map{ Int($0)! }
        
        if currentTime[2] > time[2] {
            if currentTime[2] - time[2] == 1 && time[3] > currentTime[3] {
                return String(time[3] - currentTime[3]) + "시간"
            }
            return String(time[0]) + "년 " + String(time[1]) + "월 " + String(time[2]) + "일"
        } else {
            if currentTime[3] - time[3] == 1 && time[4] > currentTime[4] {
                return String(time[4] - currentTime[4]) + "분"
            }
            return String(currentTime[3] - time[3]) + "시간"
        }
    }
    
    private func separateStarAndReview(_ content: String) -> [String] {
        let temp = content.components(separatedBy: [":", "\n"])
        return []
    }
    
    private func urlToImage(_ url: String) -> UIImage {
        guard let imageURL = URL(string: url) else { return UIImage() }
        
        do {
            let imageData = try Data(contentsOf: imageURL)
            let image = UIImage(data: imageData)
            return image ?? UIImage()
        } catch let error {
            print("Image Error: \(String(describing: error))")
            return UIImage()
        }
    }
}
