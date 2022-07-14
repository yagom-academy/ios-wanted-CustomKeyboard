//
//  KeyboardViewModel.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import Foundation

class KeyboardViewModel {
    private let networkManager = ReviewAPIManager.shared
    
    func postReview(content: String, _ completion: @escaping (Result<Post, APIError>) -> Void) -> Review {
        networkManager.postReview(content: content, completion)
        
        let user = User(userName: "Me", profileImage: "https://cdn.imweb.me/upload/S202009105eb5486486105/7335b7dec12be.jpg")
        let review = Review(user: user, content: content, createdAt: "2022-07-14T23:23:25.546Z")
        
        return review
    }
}
