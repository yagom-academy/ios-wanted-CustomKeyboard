//
//  ImageLoader.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import UIKit

//MARK: - ImageLoaderError
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
            
            //TODO: - 에러 핸들링
//            guard let error = error else {
//                completion(.failure(.unknown))
//                return
//            }

            //TODO: - 프로필 이미지가 없는 경우, 예외처리 하기
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
