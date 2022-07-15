//
//  HomeViewModel.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/11.
//

import Foundation
import Combine

class HomeViewModel {
    @Published var reviewList: [Review] = []
    
    func reviewListCount() -> Int {
        return reviewList.count
    }
    
    func review(at index: Int) -> Review {
        return reviewList[index]
    }
    
    func fetch() {
        let reviewsEndpoint = APIEndpoints.getReviews()
        Provider.shared.request(endpoint: reviewsEndpoint) { (result: Result<ReviewList, Error>) in
            switch result {
            case .success(let reviewList):
                self.reviewList = reviewList.data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func submit(contentString: String) {
        let content = Content(content: contentString)
        
        guard let data = try? JSONEncoder().encode(content) else {
            print("JSONEncoder Error")
            return
        }
        
        let postEndpoint = APIEndpoints.postReview(bodyData: data)
        Provider.shared.request(endpoint: postEndpoint) { (result: Result<Content, Error>) in
            switch result {
            case .success(let content):
                let review = Review(user: User(userName: "", profileImage: ""),
                                    content: content.content,
                                    createdAt: "")
                self.reviewList.insert(review, at: 0)
                // 성공하면 button empty 및 button enabled false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
