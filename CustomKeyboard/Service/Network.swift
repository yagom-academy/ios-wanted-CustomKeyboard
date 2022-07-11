//
//  Network.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import Foundation

enum NetworkError: Error {
    case unknown
}

struct Network {
    
    let path: String
    let parameters: [String: String]
    
    func get(completion: @escaping (Result<[ReviewResult], NetworkError>) -> Void) {
        var urlComponents = URLComponents(string: path)
        urlComponents?.setQueryItems(with: parameters)
        
        guard let url = urlComponents?.url else {
            completion(.failure(.unknown))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(.unknown))
                return
            }
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ReviewResponse.self, from: data)
                completion(.success(result.data))
            } catch {
                completion(.failure(.unknown))
            }
        }.resume()
    }
}
