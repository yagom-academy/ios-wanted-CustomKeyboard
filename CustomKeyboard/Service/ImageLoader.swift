//
//  ImageLoader.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import UIKit

enum ImageLoaderError: Error {
    case unknown
}

struct ImageLoader {
    static func loadImage(
        urlString: String,
        completion: @escaping (Result<UIImage, ImageLoaderError>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.unknown))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(.unknown))
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(.failure(.unknown))
                return
            }
            
            completion(.success(image))
        }.resume()
    }
}
