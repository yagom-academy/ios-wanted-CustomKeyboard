//
//  ReviewListViewModel.swift
//  CustomKeyboard
//
//  Created by J_Min on 2022/07/11.
//

import Foundation
import UIKit

struct ReviewListViewModel {
    var reviews: ReviewList
    
    func reviewAtIndex(index: Int) -> ReviewViewModel {
        return ReviewViewModel(reviewModel: reviews.reviewList[index])
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
