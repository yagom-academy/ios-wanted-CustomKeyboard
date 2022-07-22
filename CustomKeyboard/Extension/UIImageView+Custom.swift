//
//  UIImageView+Custom.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/13.
//

import UIKit

extension UIImageView {
    func load(urlString: String) {
        let cachedImage = ImageCacheManager.shared.getCachedImage(urlString: urlString)
        if cachedImage != nil {
            self.image = cachedImage
            return
        }
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            ImageCacheManager.shared.setObject(image: image, urlString: urlString)
            DispatchQueue.main.async() {
                self?.image = image
            }
        }.resume()
    }
}
