//
//  NetworkManager.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/12.
//

import Foundation

class NetworkManager {
    struct SuccessPostData {
        var responseCode: Int
        var data: String
    }
    
    static let shared = NetworkManager()
    private let api = NetworkAPI()
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchReview(completion: @escaping (Result<ReviewTypes, CustomError>) -> ()) {
        guard let url = api.getGetReviewAPI().url else {
            completion(.failure(CustomError.makeURLError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil,
                let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(CustomError.loadError))
                return
            }
            guard let data = data else {
                completion(.failure(CustomError.noData))
                return
            }
            do {
                let hasData = try JSONDecoder().decode(ReviewTypes.self, from: data)
                completion(.success(hasData))
            } catch {
                completion(.failure(CustomError.decodingError))
            }
        }.resume()
    }
    
    func postReview(message: String, completion: @escaping (Result<SuccessPostData, CustomError>) -> ()) {
        struct PostData: Codable {
            var content: String
        }
        
        guard let url = api.getPostReviewAPI().url else {
            completion(.failure(CustomError.makeURLError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let jsonData = try? JSONEncoder().encode(PostData(content: message)) else {
            completion(.failure(CustomError.encodingError))
            return
        }
        request.httpBody = jsonData
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil,
                let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(CustomError.loadError))
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(CustomError.responseError(code: httpResponse.statusCode)))
                return
            }
            guard let data = data else {
                completion(.failure(CustomError.noData))
                return
            }
            do {
                let postedData = try JSONDecoder().decode(PostData.self, from: data)
                completion(.success(SuccessPostData(responseCode: httpResponse.statusCode, data: postedData.content)))
            } catch {
                completion(.failure(CustomError.decodingError))
            }
        }.resume()
    }
}
