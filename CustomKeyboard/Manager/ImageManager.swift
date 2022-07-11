//
//  ImageManager.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/11.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    private init() { }
    
    func download(_ stringURL: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: stringURL) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            completion(data)
        }.resume()
    }
}
