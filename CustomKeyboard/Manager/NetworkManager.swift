//
//  NetworkManager.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/11.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    func downloadReview(completion: @escaping (ReviewList) -> Void) {
        guard let url = URL(string: "https://api.plkey.app/theme/review?themeId=PLKEY0-L-81&start=0&count=20") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data else {
                return
            }

            do {
                let result : ReviewList = try JSONDecoder().decode(ReviewList.self, from: data)
                completion(result)
            } catch(let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
