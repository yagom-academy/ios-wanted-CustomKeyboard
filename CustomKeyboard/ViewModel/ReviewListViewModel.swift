//
//  ReviewListViewModel.swift
//  CustomKeyboard
//
//  Created by J_Min on 2022/07/11.
//

import UIKit

class ReviewListViewModel {
    // MARK: - Properties
    private let networkManager = NetworkManager()
    private var reviews: [ReviewModel] = [] {
        didSet {
            tableViewUpdate()
        }
    }
    private var startPoint = 0
    var reviewsCount: Int {
        return reviews.count
    }
    var userWriteReview = "" {
        didSet {
            sendButtonStateUpdate()
        }
    }
    
    var tableViewUpdate: () -> Void = { }
    var sendButtonStateUpdate: () -> Void = { }
    
    // MARK: - LifeCycle
    init() { }
    
    // MARK: - Method
    func fetchReviews() {
        self.networkManager.fetchReviews(start: startPoint) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.reviews.append(contentsOf: reviews)
                self?.startPoint += 10
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func sendReview() {
        let content = userWriteReview
        networkManager.uploadPost(with: PostReviewModel(content: content)) { [weak self] success in
            guard let self = self else { return }
            if success{
                self.reviews.insert(self.createReviewModel(), at: 0)
            }
        }
    }
    
    private func createReviewModel() -> ReviewModel {
        let user = User(profileImage: "https://playkeyboard.s3.ap-northeast-2.amazonaws.com/user/610b92d53840a549cce54456/profile.png", userName: "user")
        let reviewModel = ReviewModel(user: user, content: self.userWriteReview, createdAt: "2022-07-12")
        
        return reviewModel
    }
    
    func reviewAtIndex(index: Int) -> ReviewViewModel {
        return ReviewViewModel(reviewModel: reviews[index])
    }
}

struct ReviewViewModel {
    private let reviewModel: ReviewModel
    
    init(reviewModel: ReviewModel) {
        self.reviewModel = reviewModel
    }
    
    var name: String {
        return reviewModel.user.userName
    }
    
    var profileImage: URL {
        return URL(string: reviewModel.user.profileImage)!
    }
    
    var content: String {
        return reviewModel.content
    }
    
    var createDate: String {
        let createDate = calculateDate(to: reviewModel.createdAt)
        guard let dateInterval = Calendar.current
            .dateComponents(.init([.minute]),
                            from: createDate,
                            to: Date()).minute else {
            return ""
        }
        
        if dateInterval < 60 {
            return "\(dateInterval)분"
        } else if dateInterval <= 1440 {
            return String(dateInterval / 60) + "시간"
        } else {
            return reviewModel.createdAt.components(separatedBy: "T").first ?? ""
        }
    }
    
    private func calculateDate(to dateStr: String) -> Date {
        var sliceDateStr = dateStr.components(separatedBy: ["T", "."])
        sliceDateStr.removeLast()
        let joinedDateStr = sliceDateStr.joined(separator: "/")
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd/HH:mm:ss"
        dateformatter.timeZone = TimeZone(identifier: "kr")
        guard let date = dateformatter.date(from: joinedDateStr) else {
            return Date()
        }
        
        return date
    }
    
}
