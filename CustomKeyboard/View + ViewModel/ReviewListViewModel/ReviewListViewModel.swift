//
//  ReviewListViewModel + Delegate.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import Foundation
import UIKit


class ReviewListViewModel {
    var reviewList: Observable<[ReviewResult]> = Observable([])
    var isSuccess: Observable<Bool> = Observable(false)
    var present: Observable<UIViewController?> = Observable(nil)
    
    let keyboardViewModel: KeyboardViewModel
    let writeViewModel: WriteViewModel
    var resultText: Observable<String>
    
    init() {
        self.keyboardViewModel = KeyboardViewModel()
        self.writeViewModel = WriteViewModel(keyboardViewModel: self.keyboardViewModel)
        
        resultText = writeViewModel.sendedText
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
                debugPrint("ERROR \(error.localizedDescription)🎉")
            }
        }
    }
    
    func postComment(_ comment: String) {
        Network(path: "", parameters: [:]).post(comment) { isSuccess in
            if isSuccess {
                let user = ReviewUser(id: "", userName: "익명", profileImage: "")
                let review = ReviewResult(id: "", user: user, content: comment, createdAt: Date().intervalCurrentTime)
                self.reviewList.value.insert(review, at: 0)
            }
            self.isSuccess.value = isSuccess
        }
    }
    
    func presentWriteController() {
        self.present.value = WriteController(viewModel: writeViewModel)
    }
}
