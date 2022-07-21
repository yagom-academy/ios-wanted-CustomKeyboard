//
//  ReviewAPIManager.swift
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

class ReviewAPIManager {
    func getReview(_ completion: @escaping (ReviewData?, APIError?) -> Void) {
        
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
        
        let uploadTask = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            guard error == nil else {
                completion(.failure(.failed))
                return
            }
            
            guard data != nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard response.statusCode == 200 else {
                completion(.failure(.unexpectedStatusCode(statusCode: "\(response.statusCode)")))
                return
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("\(dataString)")
                completion(.success(review))
                return
            }
        }
        uploadTask.resume()
    }
}
