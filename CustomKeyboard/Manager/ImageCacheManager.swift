//
//  ImageCacheManager.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/15.
//

import Foundation

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() { }
    
    private var memory = NSCache<NSURL, NSData>()
    
    func save(_ key: NSURL, _ data: Data) {
        self.memory.setObject(NSData(data: data), forKey: key)
    }
    
    func load(_ key: NSURL) -> Data? {
        if let data = self.memory.object(forKey: key) {
            return Data(referencing: data)
        }
        return nil
    }
}
