//
//  ReviewListTableViewCellViewModel.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import UIKit

//MARK: - ReviewListTableViewCellViewModelDelegate
protocol ReviewListTableViewCellViewModelDelegate: AnyObject {
    func reviewListTableViewCell(didLoadImage image: UIImage?)
}

class ReviewListTableViewCellViewModel {
    private let imageCache = ImageCacheManager.shared
    weak var delegate: ReviewListTableViewCellViewModelDelegate?
    
    func loadImage(urlString: String) {
        let url = NSString(string: urlString)
        if let cachedImage = imageCache.object(forKey: url) {
            self.delegate?.reviewListTableViewCell(didLoadImage: cachedImage)
            return
        }
        
        ImageLoader.loadImage(urlString: urlString) { result in
            switch result {
            case .success(let image):
                self.imageCache.setObject(image, forKey: url)
                DispatchQueue.main.async {
                    self.delegate?.reviewListTableViewCell(didLoadImage: image)
                }
            case .failure(let error):
                debugPrint("ERROR \(error.localizedDescription)🐸")
                DispatchQueue.main.async {
                    self.delegate?.reviewListTableViewCell(didLoadImage: UIImage())
                }
            }
        }
    }
}
