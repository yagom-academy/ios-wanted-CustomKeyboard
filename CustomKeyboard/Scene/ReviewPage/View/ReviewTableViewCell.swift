//
//  ReviewTableViewCell.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/12.
//

import UIKit

protocol ReusableCell {
    static var identifier: String { get }
}

extension ReusableCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) where T: ReusableCell {
        self.register(cellType, forCellReuseIdentifier: cellType.identifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(headerFooterType: T.Type) where T: ReusableCell {
        self.register(headerFooterType, forHeaderFooterViewReuseIdentifier: headerFooterType.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else { fatalError() }
        return cell
    }
}

class ReviewTableViewCell: UITableViewCell, ReusableCell {
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
        
        LoadImage().loadImage(review.user.profileImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.profileImage.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        nameLabel.text = review.user.userName
        timeLabel.text = dateToTime(review.date)
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
    
    private func dateToTime(_ createdAt: Date?) -> String {
        guard let time = createdAt else { return "" }
        let currentTime = Date()
        
        return compareDate(time, currentTime)
    }
    
    private func compareDate(_ time: Date, _ currentTime: Date) -> String {
        let interval = Int(currentTime.timeIntervalSince(time))
        if interval >= 86400 {
            return "\(time.year)년 \(time.month)월 \(time.day)일"
        } else if interval < 3600 {
            return "\(interval / 60)분"
        } else {
            return "\(interval / 3600)시간"
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
}
