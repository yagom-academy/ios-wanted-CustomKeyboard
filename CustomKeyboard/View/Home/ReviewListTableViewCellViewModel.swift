//
//  ReviewListTableViewCellViewModel.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import UIKit

protocol ReviewListTableViewCellViewModelDelegate: AnyObject {
    func reviewListTableViewCell(didLoadImage image: UIImage?)
}

class ReviewListTableViewCellViewModel {
    
    weak var delegate: ReviewListTableViewCellViewModelDelegate?
    
    func loadImage(urlString: String) {
        ImageLoader.loadImage(urlString: urlString) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.delegate?.reviewListTableViewCell(didLoadImage: image)
                }
            case .failure(let error):
                print("ERROR \(error.localizedDescription)🐸")
            }
        }
    }
}
