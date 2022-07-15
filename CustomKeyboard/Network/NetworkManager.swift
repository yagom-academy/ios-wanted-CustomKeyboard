//
//  NetworkManager.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/13.
//

import Foundation

class NetworkManager {
    enum NetworkError: Error {
        case serverError(_ statusCode: Int)
        case noData
        case unknownError
        case invalidError(Error)
    }
    
    func request(_ urlRequest: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.invalidError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknownError))
                return
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.serverError(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
