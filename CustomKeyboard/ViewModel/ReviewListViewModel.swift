//
//  ReviewListViewModel.swift
//  CustomKeyboard
//
//  Created by J_Min on 2022/07/11.
//

import Foundation
import UIKit

class ReviewListViewModel {
    private var reviews: [ReviewModel] = []
    var cusor = 0
    
    let networkManager = NetworkManager()
    
    init(){
    }
    
    func fetAllReviews(completion: @escaping (Bool) -> Void) {
        self.networkManager.fetchAllReviews(start: cusor) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.reviews = reviews
                self?.cusor += 10
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
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
        guard let dateInterval = Calendar.current.dateComponents(.init([.minute]),
                                                                 from: createDate,
                                                                 to: Date()).minute else {
            return ""
        }
        
        if dateInterval < 60 {
            return String(dateInterval)
        } else if dateInterval <= 1440 {
            return String(dateInterval / 60)
        } else {
            return reviewModel.createdAt.split(separator: "T").map { String($0) }.first!
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
