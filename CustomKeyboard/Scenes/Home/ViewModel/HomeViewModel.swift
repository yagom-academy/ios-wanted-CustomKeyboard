//
//  HomeViewModel.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/12.
//

import Foundation

protocol HomeViewModelable {
    func reloadReviewList(completion: @escaping (Result<[ReviewModel], Error>)->())
}

class HomeViewModel: HomeViewModelable {
    private let networkService: Api
//    var reviewList: Observable<[ReviewModel]> = Observable([])
    
    init(networkService: Api) {
        self.networkService = networkService
    }
    
    func reloadReviewList(completion: @escaping (Result<[ReviewModel], Error>)->()) {
        networkService.request(httpMethod: .get, condent: "") { result in
            switch result {
            case .success(let list):
                let reviewList = list as? reviewListModel
                var tmpArr: [ReviewModel] = []
                reviewList?.data.forEach { reviewInfo in
                    let review = ReviewModel(
                        userName: reviewInfo.user.userName,
                        profileImage: reviewInfo.user.profileImage,
                        content: reviewInfo.content,
                        createdAt: reviewInfo.createdAt
                    )
                    tmpArr.append(review)
                }
//                self.reviewList.value.append(contentsOf: tmpArr)
                completion(.success(tmpArr))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
