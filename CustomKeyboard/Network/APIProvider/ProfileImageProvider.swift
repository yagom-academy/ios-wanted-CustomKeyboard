//
//  ProfileImageProvider.swift
//  CustomKeyboard
//
//  Created by BH on 2022/07/20.
//

import Foundation
import UIKit.UIImage

protocol ProfileImageProviderType {
    
    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void)
    
}

class ProfileImageProvider: ProfileImageProviderType {
    
    private var networkRequester: NetworkRequesterType
    private var profileImageTask: URLSessionDataTask?
    private var imageCache = NSCache<NSString, UIImage>()
    
    init(networkRequester: NetworkRequesterType) {
        self.networkRequester = networkRequester
    }
    
    func fetchImage(
        from urlString: String,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        if let task = profileImageTask {
            task.cancel()
        }

        let cacheKey = NSString(string: urlString)
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            completion(.success(cachedImage))
            return
        }

        profileImageTask = networkRequester.request(to: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    return
                }
                self?.imageCache.setObject(image, forKey: cacheKey)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
