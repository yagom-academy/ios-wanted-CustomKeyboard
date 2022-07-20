//
//  Extension_UIImage.swift
//  CustomKeyboard
//
//  Created by J_Min on 2022/07/11.
//

import UIKit

extension UIImageView {
    func load(urlString: String) {
        if let image = ProfileImageCacheManager.shared.checkProfileImageInCache(imageURL: urlString) {
            self.image = image
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            guard let url = URL(string: urlString) else { return }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        ProfileImageCacheManager.shared.cache.setObject(image, forKey: NSString(string: urlString))
                        self?.image = image
                    }
                }
            }
        }
    }
}
