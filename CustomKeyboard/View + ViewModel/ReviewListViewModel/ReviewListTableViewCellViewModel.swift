//
//  ReviewListTableViewCellViewModel.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import UIKit

class ReviewListTableViewCellViewModel {
    let cache = Cache.shared
    var image: Observable<UIImage?> = Observable(nil)
    
    let review: ReviewResult
    
    init(review: ReviewResult) {
        self.review = review
        loadImage(urlString: review.user.profileImage)
    }
    
    func loadImage(urlString: String) {
        if let data = cache.fetchData(urlString) {
            if let image = UIImage(data: data) {
                self.image.value = image
                return
            }
        }
        
        ImageLoader.loadImage(urlString: urlString) { result in
            switch result {
            case .success(let image):
                if let data = image.pngData() {
                    self.cache.uploadData(urlString, data: data)
                }
                self.image.value = image
            case .failure(let error):
                debugPrint("ERROR \(urlString) \(error.description)🐸")
            }
        }
    }
}
