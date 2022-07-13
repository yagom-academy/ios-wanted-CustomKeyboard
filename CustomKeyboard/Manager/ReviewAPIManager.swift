//
//  ReviewAPIManager.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/12.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
}

class ReviewAPIManager {
    
    func getReview() {
        
    }
    
    func postReview(content: String, _ completion: @escaping(Result<Post, APIError>) -> Void) {
        
        guard let url = URL(string: "https://api.plkey.app/tmp/theme/PLKEY0-L-81/review") else {
            completion(.failure(.failed))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let review = Post(content: content)
        
        guard let uploadData = try? JSONEncoder().encode(review) else {
            completion(.failure(.failed))
            return
        }
        
        URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            guard data != nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard response.statusCode == 200 else {
                completion(.failure(.failed))
                return
            }
            
            guard error == nil else {
                completion(.failure(.failed))
                return
            }
        }.resume()
    }
}
