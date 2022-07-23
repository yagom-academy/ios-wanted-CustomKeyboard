//
//  ReviewViewModel.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/13.
//

import UIKit

class ReviewViewModel {
    private let networkService = ReviewAPIService()
    
    func getReview(_ completion: @escaping (Result<ReviewData, APIError>) -> Void) {
        networkService.getReview(completion)
    }
}
