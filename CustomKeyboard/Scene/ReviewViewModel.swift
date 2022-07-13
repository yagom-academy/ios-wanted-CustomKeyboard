//
//  ReviewViewModel.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/13.
//

import UIKit

class ReviewViewModel {
    private let networkManager = ReviewAPIManager.shared
    
    func getReview() -> [Review] {
        return networkManager.getReview()
    }
}
