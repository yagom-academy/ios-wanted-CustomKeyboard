//
//  ProfileImageCacheManager.swift
//  CustomKeyboard
//
//  Created by CHUBBY on 2022/07/19.
//

import Foundation
import UIKit

final class ProfileImageCacheManager {
    
    static let shared = ProfileImageCacheManager()
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func checkProfileImageInCache(imageURL: String) -> UIImage? {
        if let profileImage = cache.object(forKey: NSString(string: imageURL)) {
            return profileImage
        }
        return nil
    }
}
