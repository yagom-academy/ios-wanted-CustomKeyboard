//
//  LazyImageView.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/19.
//

import UIKit

final class LazyImageView: UIImageView {
    private var task: URLSessionDataTask?
    private let imageCacheManager = ImageCacheManager.shared
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureImageViewCircle()
    }
    
    func loadImage(_ urlString: String) {
        image = UIImage(systemName: "person.circle")
        
        if let task = task {
            task.cancel()
        }
        
        let key = urlString as NSString
        
        if let cachedData = imageCacheManager.load(key) {
            image = UIImage(data: cachedData)
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            self.imageCacheManager.save(key, data)

            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }
        
        task?.resume()
    }
    
    private func configureImageViewCircle() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}
