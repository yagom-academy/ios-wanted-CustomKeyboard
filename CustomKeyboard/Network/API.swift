//
//  API.swift
//  CustomKeyboard
//
//  Created by 효우 on 2022/07/20.
//

import Foundation

class API {
    
    static let shared: API = API()
    
    private lazy var defaultSession = URLSession(configuration: .default)
    
    private init() { }
    
    func get(completion: @escaping (Result<ModelData, Error>) -> Void) {
        guard let url = URL(string: constantURL.getURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let resource = Resource<ModelData>(url: url)
        defaultSession.load(resource) { data, _ in
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            completion(.success(data))
        }
    }
    
    func post(message: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: constantURL.postURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let data = PostReviewData(content: message)
        let resource = Resource<PostReviewData>(url: url, parameters: ["content":data.content], method: .post(data))
        defaultSession.upload(resource) { result in
            switch result {
            case true:
                completion(.success(true))
            case false:
                completion(.failure(NetworkError.invalidData))
            }
            completion(.success(true))
        }
    }
}
