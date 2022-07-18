//
//  ImageLoder.swift
//  CustomKeyboard
//
//

import Foundation
import UIKit

enum ImageLoaderError: Error {
    case noImage
    case invalidImageURL
}

class ImageLoder {
    let imageCache = NSCache<NSString, UIImage>()
    
    func leadImage(url: String, complition: @escaping (Result<UIImage, Error>) -> Void) {
        if url.isEmpty {
            complition(.failure(ImageLoaderError.invalidImageURL))
        }
        
        guard let imageUrl = URL(string: url) else { return }
        if let image = imageCache.object(forKey: imageUrl.lastPathComponent as NSString) {
            DispatchQueue.main.async {
                complition(.success(image))
            }
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageUrl) {
                guard let image = UIImage(data: data) else { return }
                self.imageCache.setObject(image, forKey: imageUrl.lastPathComponent as NSString)
                DispatchQueue.main.async {
                    complition(.success(image))
                }
            } else {
                DispatchQueue.main.async {
                    complition(.failure(ImageLoaderError.noImage))
                }
            }
        }
    }
}
