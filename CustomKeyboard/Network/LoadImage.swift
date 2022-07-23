//
//  LoadImage.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/22.
//

import UIKit

enum LoadImageError: Error {
    case networkError
    case noImage
}

class LoadImage {
    static let cache = NSCache<NSString, UIImage>()
    
    func loadImage(_ url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = LoadImage.cache.object(forKey: url as NSString) {
            completion(.success(image))
            return
        }
        
        guard let imageURL = URL(string: url) else { return }
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: imageURL) { data, response, error in
            guard error == nil else {
                completion(.failure(LoadImageError.networkError))
                return
            }
            
            guard let data = data else {
                completion(.failure(LoadImageError.noImage))
                return
            }
            
            guard let image = UIImage(data: data) else { return }
            LoadImage.cache.setObject(image, forKey: url as NSString)
            completion(.success(image))
        }
        dataTask.resume()
    }
}
