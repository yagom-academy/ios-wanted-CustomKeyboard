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
    weak var delegate: ReviewListTableViewCellViewModelDelegate?
    
    func loadImage(urlString: String) {
        if let cacheData = UserDefaults.standard.object(forKey: urlString) as? Data {
            if let cacheImage = UIImage(data: cacheData) {
                self.delegate?.reviewListTableViewCell(didLoadImage: cacheImage)
                return
            }
        }
        
        ImageLoader.loadImage(urlString: urlString) { result in
            switch result {
            case .success(let image):
                UserDefaults.standard.set(image.pngData(), forKey: urlString)
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
