//
//  HTTPMethod.swift
//  CustomKeyboard
//
//  Created by 효우 on 2022/07/20.
//

import Foundation

enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    var method: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}
