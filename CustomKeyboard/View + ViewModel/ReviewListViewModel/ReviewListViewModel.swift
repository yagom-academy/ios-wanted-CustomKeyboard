//
//  ReviewListViewModel + Delegate.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import Foundation

protocol ReviewListObservable {
    var reviewList: Observable<[ReviewResult]> { get set }
    var isSuccess: Observable<Bool> { get set }
}

class ReviewListViewModel: ReviewListObservable {
    var reviewList: Observable<[ReviewResult]> = Observable([])
    var isSuccess: Observable<Bool> = Observable(false)
    
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
                self.reviewList.value = list
            case .failure(let error):
                print("ERROR \(error.localizedDescription)🎉")
            }
        }
    }
    
    func postComment(_ comment: String) {
        Network(path: "", parameters: [:]).post(comment) { isSuccess in
            self.isSuccess.value = isSuccess
        }
    }
}
