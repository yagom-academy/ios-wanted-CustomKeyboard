//
//  ReviewListViewModel + Delegate.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import UIKit

class ReviewListViewModel {
    //MARK: - Properties
    // Observable
    var reviewList: Observable<[ReviewResult]> = Observable([])
    var isSuccess: Observable<Bool> = Observable(false)
    var present: Observable<UIViewController?> = Observable(nil)
    
    // ViewModels
    let keyboardViewModel: KeyboardViewModel
    let writeViewModel: WriteViewModel
    
    //MARK: - Init
    init() {
        self.keyboardViewModel = KeyboardViewModel()
        self.writeViewModel = WriteViewModel(keyboardViewModel: self.keyboardViewModel)
    }
    
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
                print(error.description, "🎉")
            }
        }
    }
    
    func postComment(_ comment: String) {
        Network(path: "").post(comment) { isSuccess in
            if isSuccess {
                let user = ReviewUser(id: "", userName: "익명", profileImage: "")
                let review = ReviewResult(
                    id: "",
                    user: user,
                    content: "Review: " + comment,
                    createdAt: Date().toString(format: "y-MM-dd'T'HH:mm:ss.SSS'Z'")
                )
                self.reviewList.value.insert(review, at: 0)
            }
            self.isSuccess.value = isSuccess
        }
    }
    
    func presentWriteController() {
        self.present.value = WriteController(viewModel: writeViewModel)
    }
}
