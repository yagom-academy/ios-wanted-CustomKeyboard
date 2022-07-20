//
//  Cache.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/20.
//

import Foundation

protocol CacheProtocol: AnyObject {
    func fetchData(_ key: String) -> Data?
    func uploadData(_ key: String, data: Data)
}

class Cache: CacheProtocol {
    static let shared = Cache()
    let memory = MemoryCache.shared
    let disk = DiskCache.shared
    
    func fetchData(_ key: String) -> Data? {
        if let data = self.memory.fetchData(key) {
            return data
        } else if let data = self.disk.fetchData(key) {
            memory.uploadData(key, data: data)
            return data
        } else {
            return nil
        }
    }
    
    func uploadData(_ key: String, data: Data) {
        self.memory.uploadData(key, data: data)
        self.disk.uploadData(key, data: data)
    }
    
}

class MemoryCache: CacheProtocol {
    static let shared = MemoryCache()
    
    let cache = NSCache<NSString, NSData>()
    
    func fetchData(_ key: String) -> Data? {
        guard let data = self.cache.object(forKey: key as NSString) else  {
            return nil
        }
        return Data(referencing: data)
    }
    
    func uploadData(_ key: String, data: Data) {
        self.cache.setObject(NSData(data: data), forKey: key as NSString)
    }
}

class DiskCache: CacheProtocol {

    static let shared = DiskCache(name: "cache")
    
    var folderURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(self.name)
    }
    
    var name: String = "cache"
    
    init(name: String) {
        self.name = name
        
        self.createFolder()
    }
    
    
    func fetchData(_ key: String) -> Data? {
        let imageKey = key.toIdentifierPath
        guard let writeURL = self.folderURL?.appendingPathComponent(imageKey) else {
            return nil
        }
        return FileManager.default.contents(atPath: writeURL.path)
    }
    
    func uploadData(_ key: String, data: Data) {
        let imageKey = key.toIdentifierPath
        guard let writeURL = self.folderURL?.appendingPathComponent(imageKey) else {
            return
        }
        try? data.write(to: writeURL)
    }
    
    private func createFolder() {
        guard let folderURL = folderURL else {
            return
        }

        if FileManager.default.fileExists(atPath: folderURL.path) {
            return
        }
        
        try? FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
    }
}
