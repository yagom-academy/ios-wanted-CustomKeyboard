//
//  ReviewTableViewHeaderViewModel.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import Foundation

class ReviewTableViewHeaderViewModel {
    private let networkManager = ReviewAPIManager()
    
    func postReview(content: String, _ completion: @escaping (Result<Post, APIError>) -> Void) -> Review {
        networkManager.postReview(content: content, completion)
        
        let user = User(userName: "Me", profileImage: "https://cdn.imweb.me/upload/S202009105eb5486486105/7335b7dec12be.jpg")
        let review = Review(user: user, content: content, createdAt: dateToString(Date()))
        
        return review
    }
    
    private func dateToString(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy-MM-dd_HH:mm:ss"
        let res = formatter.string(from: time).replacingOccurrences(of: "_", with: "T")
        return res
    }
}
