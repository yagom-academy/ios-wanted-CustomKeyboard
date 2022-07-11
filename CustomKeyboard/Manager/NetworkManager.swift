//
//  NetworkManager.swift
//  CustomKeyboard
//
//  Created by JunHwan Kim on 2022/07/11.
//

import Foundation

enum NetworkError : Error{
    case url
    case network
    case decode
}

class NetworkManager{
    
    func fetchAllReviews(completion : @escaping (Result<ReviewList, NetworkError>) -> Void){
        let urlStr = "https://api.plkey.app/theme/review?themeld=6&start=0&count=20"
        guard let url = URL(string: urlStr) else {
            completion(.failure(.url))
            return
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.network))
                return
            }
            let decorder = JSONDecoder()
            guard let data = try? decorder.decode(ReviewList.self, from: data) else {
                completion(.failure(.decode))
                return
            }
            
        }.resume()
        
    }
    
}
