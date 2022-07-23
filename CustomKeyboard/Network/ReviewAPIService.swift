//
//  ReviewAPIService.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import UIKit

enum APIError: Error {
    case unexpectedStatusCode(statusCode: String)
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class ReviewAPIService {
    func getReview(_ completion: @escaping (Result<ReviewData, APIError>) -> Void) {
        var request = URLRequest(url: EndPoint.getReview.url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.request(.shared, endpoint: request, completion: completion)
    }
    
    func postReview(content: String, _ completion: @escaping(Result<Post, APIError>) -> Void) {
        var request = URLRequest(url: EndPoint.postReview.url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let review = Post(content: content)
        
        guard let uploadData = try? JSONEncoder().encode(review) else {
            completion(.failure(.failed))
            return
        }
        
        URLSession.request(.shared, uploadData: uploadData, endpoint: request) { result in
            switch result {
            case .success(let data):
                guard let content = String(data: data, encoding: .utf8) else { return }
                let post = Post(content: content)
                completion(.success(post))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
