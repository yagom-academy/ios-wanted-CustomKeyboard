//
//  URLSessionProtocol.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/21.
//

import Foundation

// URLSession의 dataTask와 동일하게 정의
protocol URLSessionProtocol {
    func dataTask(with urlReqeust: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

// 기본 URLSession도 포함
extension URLSession: URLSessionProtocol {
    func dataTask(with urlReqeust: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return dataTask(with: urlReqeust, completionHandler: completionHandler) as URLSessionDataTask
    }
}
