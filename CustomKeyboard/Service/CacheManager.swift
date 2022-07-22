//
//  Cache.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/20.
//

import Foundation

// MARK: - Cacheable Protocol
protocol Cacheable {
    func fetchData(_ key: String) -> Data?
    func uploadData(_ key: String, data: Data)
}

// MARK: - Cache Manager
class CacheManager: Cacheable {
    // MARK: - Properties
    static let shared = CacheManager()
    private let memory = MemoryCache()
    private let disk = DiskCache()
    
    func fetchData(_ key: String) -> Data? {
        if let data = memory.fetchData(key) {
            return data
        } else if let data = disk.fetchData(key) {
            memory.uploadData(key, data: data)
            return data
        } else {
            return nil
        }
    }
    
    func uploadData(_ key: String, data: Data) {
        memory.uploadData(key, data: data)
        disk.uploadData(key, data: data)
    }
}

// MARK: - Memory Cache
class MemoryCache: Cacheable {
    // MARK: - Properties
    let cache = NSCache<NSString, NSData>()
    
    func fetchData(_ key: String) -> Data? {
        guard let data = cache.object(forKey: key as NSString) else  {
            return nil
        }
        return Data(referencing: data)
    }
    
    func uploadData(_ key: String, data: Data) {
        cache.setObject(NSData(data: data), forKey: key as NSString)
    }
}

// MARK: - Disk Cache
class DiskCache: Cacheable {
    // MARK: - Properties
    var folderURL: URL? {
        return FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )
        .first?
        .appendingPathComponent(name)
    }
    var name: String = "cache"
    
    // MARK: - Init
    init() { createFolder() }
    
    func fetchData(_ key: String) -> Data? {
        let imageKey = key.toIdentifierPath
        guard let writeURL = folderURL?.appendingPathComponent(imageKey) else {
            return nil
        }
        return FileManager.default.contents(atPath: writeURL.path)
    }
    
    func uploadData(_ key: String, data: Data) {
        let imageKey = key.toIdentifierPath
        guard let writeURL = folderURL?.appendingPathComponent(imageKey) else {
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
        
        try? FileManager.default.createDirectory(
            at: folderURL,
            withIntermediateDirectories: true
        )
    }
}
