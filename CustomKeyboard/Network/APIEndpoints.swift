//
//  APIEndpoints.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/14.
//

import Foundation

struct APIEndpoints {
    static func getReviews() -> Endpoint {
        return Endpoint(urlString: "https://api.plkey.app/theme/review",
                               method: .get,
                               headers: [:],
                               queryItems: ["themeId": "PLKEY0-L-81", "start": "0", "count": "20"],
                               bodyData: nil)
    }
    
    static func postReview(bodyData: Data) -> Endpoint {
        return Endpoint(urlString: "https://api.plkey.app/tmp/theme/PLKEY0-L-81/review",
                               method: .post,
                               headers: ["Content-Type": "application/json"],
                               queryItems: [:],
                               bodyData: bodyData)
    }
}
