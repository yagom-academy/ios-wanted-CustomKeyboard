//
//  ReviewListViewModel.swift
//  CustomKeyboard
//
//  Created by J_Min on 2022/07/11.
//

import Foundation
import UIKit

class ReviewListViewModel {
    var reviews: [ReviewModel] = []
    
    let networkManager = NetworkManager()
    
    init(){
    }
    
    func fetAllReviews(){
        self.networkManager.fetchAllReviews { [weak self] result in
            switch result{
            case .success(let reviews):
                self?.reviews = reviews
            case .failure(_):
                break
            }
        }
    }
    
    func reviewAtIndex(index: Int) -> ReviewViewModel {
        return ReviewViewModel(reviewModel: reviews[index])
    }
}

struct ReviewViewModel {
    let reviewModel: ReviewModel
    
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
}
