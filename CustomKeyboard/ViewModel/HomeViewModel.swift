//
//  HomeViewModel.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/11.
//

import Foundation
import Combine

class HomeViewModel {
    @Published var reviewList: [Review] = []
    
    func reviewListCount() -> Int {
        return reviewList.count
    }
    
    func review(at index: Int) -> Review {
        return reviewList[index]
    }
    
    func fetch() {
        NetworkManager.shared.downloadReview(completion: { reviewData in
            self.reviewList = reviewData.data
        })
    }
}
