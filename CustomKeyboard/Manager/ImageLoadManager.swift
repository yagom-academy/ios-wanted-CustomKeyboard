//
//  ImageLoadManager.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/15.
//

import Foundation

final class ImageLoadManager {
    static let shared = ImageLoadManager()
    private init() { }
    
    private let imageCacheManager = ImageCacheManager.shared
    
    func load(_ urlString: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let key = url as NSURL
        
        if let cachedData = self.imageCacheManager.load(key) {
            completion(cachedData)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            self.imageCacheManager.save(key, data)
            completion(data)
        }.resume()
    }
}
