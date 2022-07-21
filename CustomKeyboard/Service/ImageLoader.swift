//
//  ImageLoader.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import UIKit

//MARK: - ImageLoaderError
enum ImageLoaderError: String, Error {
    case invalidURL
    case invalidRequest
    case serverError
    case unknown
    
    var description: String { self.rawValue }
}

struct ImageLoader {
    static func loadImage(
        urlString: String,
        completion: @escaping (Result<UIImage, ImageLoaderError>) -> Void
    ) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print(url, "⭐️")
                completion(.failure(.invalidRequest))
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                print(url, "⭐️")
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                print(url, "⭐️")
                completion(.failure(.unknown))
                return
            }
            
            completion(.success(image))
        }
        
        return task
    }
    
    static func cancelSession(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url).cancel()
    }
}
