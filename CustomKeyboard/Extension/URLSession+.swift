//
//  URLSession+.swift
//  CustomKeyboard
//
//  Created by 효우 on 2022/07/20.
//

import Foundation

extension URLSession {
    func load<T>(_ resource: Resource<T>, completion: @escaping (T?, Bool) -> Void) {
        dataTask(with: resource.urlRequest) { data, response, error in
            if let error = error {
                completion(NetworkError.networkError(error) as? T, false)
            }
            if let response = response as? HTTPURLResponse,
                (200..<300).contains(response.statusCode) {
                completion(data.flatMap(resource.parse), true)
            } else {
                completion(nil, false)
            }
        }.resume()
    }
    func upload<T>(_ resource: Resource<T>, completion: @escaping (Bool) -> Void) {
        dataTask(with: resource.urlRequest) { data, response, error in
            if let _ = error {
                completion(false)
            }
            if let response = response as? HTTPURLResponse,
                (200..<300).contains(response.statusCode) {
                completion(true)
            } else {
                completion(false)
            }
        }.resume()
    }
}
