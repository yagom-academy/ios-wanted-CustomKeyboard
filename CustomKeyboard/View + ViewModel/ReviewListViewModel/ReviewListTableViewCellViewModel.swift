//
//  ReviewListTableViewCellViewModel.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import UIKit

class ReviewListTableViewCellViewModel {
    
    let profileImage: Observable<UIImage?> = Observable(nil)
    
    func loadImage(urlString: String) {
        if let cacheData = UserDefaults.standard.object(forKey: urlString) as? Data {
            if let cacheImage = UIImage(data: cacheData) {
                profileImage.value = cacheImage
                return
            }
        }
        
        ImageLoader.loadImage(urlString: urlString) { result in
            switch result {
            case .success(let image):
                UserDefaults.standard.set(image.pngData(), forKey: urlString)
                self.profileImage.value = image
            case .failure(let error):
                print(error.description, "🐸")
                self.profileImage.value = UIImage()
            }
        }
    }
}
