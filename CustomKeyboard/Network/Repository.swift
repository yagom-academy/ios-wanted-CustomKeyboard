//
//  Repository.swift
//  CustomKeyboard
//
//  Created by 신의연 on 2022/07/12.
//

import Foundation

enum RepositoryError {
    
}

class Repository {
    
    let getDataManager = GetReviewData()
    
    func getReviewData(request: GetRequest, completion: @escaping (Result<Data1, Error>) -> Void) {
        guard let request = request.getUrlRequest else { return }
        getDataManager.getReviewList(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(Data1.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(NetworkError.decodeError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
