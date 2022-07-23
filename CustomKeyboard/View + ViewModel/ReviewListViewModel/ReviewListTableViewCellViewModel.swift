//
//  ReviewListTableViewCellViewModel.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import UIKit

class ReviewListTableViewCellViewModel {
    //MARK: - Properties
    // Network
    let cache = CacheManager.shared
    var task: URLSessionDataTask?
    let review: ReviewResult
    
    // Observable
    var image: Observable<UIImage?> = Observable(nil)

    //MARK: - Init
    init(review: ReviewResult) {
        self.review = review
        setImageTask()
    }
    
    func setImageTask() {
        let urlString = review.user.profileImage
        if let data = cache.fetchData(urlString) {
            if let image = UIImage(data: data) {
                self.image.value = image
                return
            }
        }
        
        task = ImageLoader.loadImage(urlString: urlString) { result in
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
    
    func loadImage() {
        task?.resume()
    }
    
    func cancelImageDownLoad() {
        task?.cancel()
        task = nil
    }
}
