//
//  NetworkManager.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/13.
//

import Foundation

final class NetworkManager {
    enum NetworkError: Error {
        case serverError(_ statusCode: Int)
        case noData
        case unknownError
        case invalidError(Error)
        case urlRequestError
        case decodeError(Error)
    }
    
    private let session = URLSession.shared
    
    func fetchData<T: Decodable>(endpoint: Endpoint, dataType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlRequest = endpoint.urlRequest() else {
            completion(.failure(.urlRequestError))
            return
        }
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
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
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let error {
                completion(.failure(.decodeError(error)))
            }
        }
        
        dataTask.resume()
    }
    
    func postRequest(endpoint: Endpoint, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let urlRequest = endpoint.urlRequest() else {
            completion(.failure(.urlRequestError))
            return
        }
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
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
        }
        
        dataTask.resume()
   }
}
