//
//  EndPoint.swift
//  CustomKeyboard
//
//  Created by 백유정 on 2022/07/21.
//

import Foundation

enum EndPoint {
    case getReview
    case postReview
}

extension EndPoint {
    var url: URL {
        switch self {
        case .getReview:
            return .makeEndPoint("theme/review?themeId=PLKEY0-L-81&start=0&count=20")
        case .postReview:
            return .makeEndPoint("tmp/theme/PLKEY0-L-81/review")
        }
    }
}

extension URL {
    static let baseURL = "https://api.plkey.app/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}
