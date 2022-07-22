//
//  URLComponents.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
    }
}
