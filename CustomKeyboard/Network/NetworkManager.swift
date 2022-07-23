//
//  NetworkManager.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/13.
//

import Foundation

enum NetworkError: Error {
    case urlRequestError
    case invalidError
    case statusCodeError
    case noData
    case decodeError
}

final class NetworkManager {
    // URLSession.shared -> URLSessionProtocol
    // 나중에 MockURLSession 활용해 테스트
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(endpoint: Endpoint, dataType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = endpoint.urlRequest() else {
            completion(.failure(NetworkError.urlRequestError))
            return
        }
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidError))
                return
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(NetworkError.statusCodeError))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkError.decodeError))
            }
        }
        
        dataTask.resume()
    }
    
    func postRequest(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let urlRequest = endpoint.urlRequest() else {
            completion(.failure(NetworkError.urlRequestError))
            return
        }
        
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidError))
                return
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(NetworkError.statusCodeError))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            completion(.success(data))
        }
        
        dataTask.resume()
   }
}
