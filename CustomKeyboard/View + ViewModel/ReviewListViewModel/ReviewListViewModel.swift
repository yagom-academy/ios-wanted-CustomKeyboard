//
//  ReviewListViewModel + Delegate.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import Foundation

//MARK: - ReviewListViewModelDelegate
protocol ReviewListViewModelDelegate: AnyObject {
    func viewModel(didEndFetchReviewList viewModel: ReviewListViewModel)
    func clearText()
}

class ReviewListViewModel {
    var reviewList = [ReviewResult]()
    
    weak var delegate: ReviewListViewModelDelegate?
    
    func fetchReviewList() {
        Network(
            path: "https://api.plkey.app/theme/review",
            parameters: [
            "themeId": "PLKEY0-L-81",
            "start": "0",
            "count": "20"
            ]
        ).get { result in
            switch result {
            case .success(let list):
                self.reviewList = list
                DispatchQueue.main.async {
                    self.delegate?.viewModel(didEndFetchReviewList: self)
                }
            case .failure(let error):
                print("ERROR \(error.localizedDescription)🎉")
            }
        }
    }
    
    func postComment(_ comment: String) {
        Network(path: "", parameters: [:]).post(comment) { isSuccess in
            if isSuccess {
                self.delegate?.clearText()
            }
        }
    }
}
