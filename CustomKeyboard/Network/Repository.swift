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
    
    private var themeId = "PLKEY0-L-81"
    private var currentPage = 0
    
    private let httpClient = HttpClient(baseUrl: "https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20")
    
    func reviewData(completion: @escaping (Result<ModelData, Error>) -> Void) {
        httpClient.getJson { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let reviewData = try decoder.decode(ModelData.self, from: data)
                    completion(.success(reviewData))
                } catch let error {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
