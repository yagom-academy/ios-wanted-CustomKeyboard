//
//  NetworkAPI.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/12.
//

import Foundation

struct NetworkAPI {
    
    // MARK: - Properties
    static let schema = "https"
    static let host = "api.plkey.app"
    
    func getGetReviewAPI() -> URLComponents {
        
        var components = URLComponents()
        components.scheme = NetworkAPI.schema
        components.host = NetworkAPI.host
        components.path = "/theme/review"
        
        components.queryItems = [
            URLQueryItem(name: "themeId", value: "6"),
            URLQueryItem(name: "start", value: "0"),
            URLQueryItem(name: "count", value: "20"),
        ]
        return components
    }
    
    func getPostReviewAPI() -> URLComponents {
        
        var components = URLComponents()
        components.scheme = NetworkAPI.schema
        components.host = NetworkAPI.host
        components.path = "/tmp/theme/PLKEY0-L-81/review"
        
        return components
    }
}
