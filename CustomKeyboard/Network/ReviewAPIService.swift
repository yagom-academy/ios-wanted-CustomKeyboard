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
        
        URLSession.request(.shared, content: content, endpoint: request, completion: completion)
    }
}
