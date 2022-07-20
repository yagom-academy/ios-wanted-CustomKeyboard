//
//  ReviewProvider.swift
//  CustomKeyboard
//
//  Created by BH on 2022/07/19.
//

import Foundation

protocol ReviewAPIProviderType {
    
    func fetchReviews(completion: @escaping (Result<[ReviewResult], Error>) -> Void)
    func upload(review: String, completion: @escaping (Result<Bool, Error>) -> Void)
    
}

struct ReviewAPIProvider {
    
    let networkRequester: NetworkRequesterType
    
    func fetchReviews(completion: @escaping (Result<[ReviewResult], Error>) -> Void) {
        networkRequester.request(to: ReviewEndPoint.getReviews) { result in
            switch result {
            case .success(let data):
                guard let decodedData = try? JSONDecoder().decode(ReviewDataDTO.self, from: data) else { return
                }
                let reviewResults = decodedData.datas
                completion(.success(reviewResults))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func upload(review: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let encodedData = try? JSONEncoder().encode(PostReviewDTO(content: review))
        else {
            return
        }
        networkRequester.request(to: ReviewEndPoint.postReview, with: encodedData) { result in
            switch result {
            case .success(let statusCode):
                if 200..<300 ~= statusCode {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
