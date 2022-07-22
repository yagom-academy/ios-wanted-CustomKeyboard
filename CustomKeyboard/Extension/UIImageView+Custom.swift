//
//  UIImageView+Custom.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/13.
//

import UIKit

extension UIImageView {
    func load(urlString: String, completion: @escaping (Result<UIImage, CustomError>) ->()) {
        let cachedImage = ImageCacheManager.shared.cachedImage(urlString: urlString)
        if cachedImage != nil {
            self.image = cachedImage
            return
        }
        //TODO: response코드, error 처리
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil,
                    let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(CustomError.loadError))
                }
                return
            }
            guard let data = data,
                  let image = UIImage(data: data)
            else { return }
            ImageCacheManager.shared.setObject(image: image, urlString: urlString)
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}
