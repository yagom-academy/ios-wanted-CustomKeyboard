//
//  ReviewEndPoint.swift
//  CustomKeyboard
//
//  Created by BH on 2022/07/19.
//

import Foundation

enum ReviewEndPoint: EndPointType {
    
    case getReviews
    case postReview
    
    var baseURL: String {
        return "https://api.plkey.app"
    }
    
    var method: HTTPMethod {
        switch self {
        case .getReviews:
            return .get
        case .postReview:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .getReviews:
            return "/theme/review"
        case .postReview:
            return "/tmp/theme/PLKEY0-L-81/review"
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .getReviews:
            return [URLQueryItem(name: "themeId", value: "PLKEY0-L-81"),
                    URLQueryItem(name: "start", value: "0"),
                    URLQueryItem(name: "count", value: "20")]
        case .postReview:
            return nil
        }
    }

}
