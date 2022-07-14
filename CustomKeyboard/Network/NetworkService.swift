//
//  NetworkService.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/13.
//

import Foundation

enum Method {
    case get
    case post
}
protocol Api{
    var method: Method { get }
}

class NetworkService{
    private let reviewRepository = ReviewRepository()
    private var reviewList: [ReviewModel] = []
    
    func request(method: Method, completion: @escaping ([ReviewModel])->()){
        switch method {
        case .get:
            getRequest { list in
                completion(list)
            }
        case .post:
            postRequest()
        }
    }
    private func getRequest(completion: @escaping ([ReviewModel])->()){
        reviewRepository.fetchReview { reviewList in
            reviewList.data.forEach { reviewInfo in
                let review = ReviewModel(
                    userName: reviewInfo.user.userName,
                    profileImage: reviewInfo.user.profileImage,
                    content: reviewInfo.content,
                    createdAt: reviewInfo.createdAt
                )
                self.reviewList.append(review)
            }
            completion(self.reviewList)
        }
    }
    private func postRequest(){
        reviewRepository.postReview()
    }
}
