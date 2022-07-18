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
    func getReview(_ completion: @escaping ((ReviewData) -> Void)) {
        guard let url = URL(string: "https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20") else {
            print("URL Error")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard error == nil,
                  let data = data,
                  let res = response as? HTTPURLResponse else {
                print("URLSession Datatask Error: \(error?.localizedDescription ?? "")")
                return
            }
            
            do {
                let reviews = try JSONDecoder().decode(ReviewData.self, from: data)
                completion(reviews)
            } catch let parsingError {
                print("Parsing Error: \(parsingError)")
            }
        }
        dataTask.resume()
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
