//
//  URLSessionDataTaskProtocol.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/21.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
