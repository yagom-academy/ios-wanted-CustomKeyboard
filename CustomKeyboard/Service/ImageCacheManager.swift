//
//  ImageCacheManager.swift
//  CustomKeyboard
//
//  Created by 이경민 on 2022/07/17.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString,UIImage>()
}
