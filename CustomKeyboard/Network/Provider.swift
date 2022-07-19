//
//  Provider_sungeo.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/14.
//

import Foundation

final class Provider {
    enum ProviderError: Error {
        case decode(Error)
    }
    
    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let urlRequest = try endpoint.urlRequest()
            NetworkManager().request(urlRequest) { result in
                switch result {
                case .success(let data):
                    let result: Result<T, Error> = self.decode(data)
                    completion(result)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func postRequest(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            let urlRequest = try endpoint.urlRequest()
            NetworkManager().request(urlRequest) { result in
                switch result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    private func decode<T: Decodable>(_ data: Data) -> Result<T, Error> {
        do {
            let result: T = try JSONDecoder().decode(T.self, from: data)
            return .success(result)
        } catch let error {
            return .failure(error)
        }
    }
}
