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

class ProfileImageProvider {
    
    private var networkRequester: NetworkRequesterType?
    private var profileImageTask: URLSessionDataTask?
    
    func fetchImage(
        from urlString: String,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        if let task = profileImageTask {
            task.cancel()
        }
        profileImageTask = networkRequester?.request(to: urlString) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
