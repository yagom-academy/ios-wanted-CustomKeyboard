//
//  ReviewTableViewCell.swift
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
        starLabel.text = separateStarAndReview(review.content).0.replacingOccurrences(of: "Rating", with: "별점")
        reviewLabel.text = separateStarAndReview(review.content).1.replacingOccurrences(of: "Review", with: "리뷰")
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
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            profileImage.widthAnchor.constraint(equalToConstant: 60),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: inset),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60),
            
            warningLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            warningLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            
            starLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: inset),
            starLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: inset),
            starLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            
            reviewLabel.topAnchor.constraint(equalTo: starLabel.bottomAnchor, constant: 8),
            reviewLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: inset),
            reviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            
            timeLabel.topAnchor.constraint(equalTo: reviewLabel.bottomAnchor, constant: 8),
            timeLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: inset),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset),
        ])
    }
    
    private func dateToTime(_ createdAt: String) -> String {
        let time = createdAt.components(separatedBy: ["-", "T", ":", "Z"]).map{ Int($0) ?? 0 }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy_MM_dd_HH_mm_ss"
        let currentTime = formatter.string(from: Date()).components(separatedBy: "_").map{ Int($0)! }
        
        if currentTime[2] > time[2] {
            if currentTime[2] - time[2] == 1 && time[3] > currentTime[3] {
                return String(24 - (time[3] - currentTime[3])) + "시간"
            }
            return String(time[0]) + "년 " + String(time[1]) + "월 " + String(time[2]) + "일"
        } else {
            if currentTime[3] - time[3] == 1 && time[4] > currentTime[4] {
                return String(60 - (time[4] - currentTime[4])) + "분"
            } else if currentTime[3] == time[3] {
                return String(currentTime[4] - time[4]) + "분"
            }
            return String(currentTime[3] - time[3]) + "시간"
        }
    }
    
    private func separateStarAndReview(_ content: String) -> (String, String) {
        let temp = content.components(separatedBy: "\n")
        switch temp.count {
        case 1:
            if temp[0].components(separatedBy: ":").count == 1 {
                return ("별점: ", "리뷰: " + temp[0])
            } else {
                return ("별점: ⭐️⭐️⭐️⭐️⭐️", "리뷰: ")
            }
        case 2:
            return (temp[0], temp[1])
        default:
            return ("별점: ", "리뷰: ")
        }
    }
    
    private func urlToImage(_ url: String) -> UIImage {
        guard let imageURL = URL(string: url) else { return UIImage() }
        
        do {
            // TODO: - DataTask로 바꿔보기
            let imageData = try Data(contentsOf: imageURL)
            let image = UIImage(data: imageData)
            return image ?? UIImage()
        } catch let error {
            print("Image Error: \(String(describing: error))")
            return UIImage()
        }
    }
}
