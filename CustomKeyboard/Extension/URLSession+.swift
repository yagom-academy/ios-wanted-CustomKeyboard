//
//  URLSession+.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/21.
//

import Foundation

extension URLSession {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    @discardableResult
    func uploadTask(_ uploadData: Data, _ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionUploadTask {
        let task = uploadTask(with: endpoint, from: uploadData, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping(Result<T, APIError>) -> Void) {
        session.dataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.failed))
                    return
                }
                
                guard let data = data else {
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
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(.success(userData))
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, content: String, endpoint: URLRequest, completion: @escaping(Result<T, APIError>) -> Void) {
        
        let review = Post(content: content)
        
        guard let uploadData = try? JSONEncoder().encode(review) else {
            completion(.failure(.failed))
            return
        }
                
        session.uploadTask(uploadData, endpoint) { data, response, error in
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
                completion(.success(review as! T))
                return
            }
        }
    }
}
