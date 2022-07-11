//
//  ViewModel.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func viewModel(didEndFetchReviewList viewModel: ViewModel)
}
class ViewModel {
    var reviewList = [ReviewResult]()
    
    weak var delegate: ViewModelDelegate?
    
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
}
