//
//  URL+.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/22.
//

import Foundation

extension URL {
    static let baseURL = "https://api.plkey.app/"
    static let profileImageURL = "https://cdn.imweb.me/upload/S202009105eb5486486105/7335b7dec12be.jpg"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}
