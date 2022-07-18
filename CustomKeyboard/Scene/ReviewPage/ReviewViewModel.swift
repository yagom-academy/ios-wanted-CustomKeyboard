//
//  ReviewViewModel.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/13.
//

import UIKit

class ReviewViewModel {
    private let networkManager = ReviewAPIManager()
    
    func getReview(_ completion: @escaping ((ReviewData) -> Void)) {
        networkManager.getReview(completion)
    }
}
