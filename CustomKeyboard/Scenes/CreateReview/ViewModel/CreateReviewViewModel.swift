//
//  CreateReviewViewModel.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/14.
//

import Foundation

class CreateReviewViewModel{
    private let networkService = NetworkService()
    
    func uploadReview(condent: String, completion: @escaping ()->()){
        networkService.request(httpMethod: .post, condent: condent) { result in
            switch result {
            case .success(_):
                print("Success!")
                completion()
            case .failure(_):
                completion()
            }
        }
    }
}
