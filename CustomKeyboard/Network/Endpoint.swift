//
//  Endpoint.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/14.
//

import Foundation

struct Endpoint {
    enum EndpointError: Error {
        case invalidURLError
    }
    
    private let urlString: String
    private let method: HttpMethod
    private let headers: [String: String]
    private let queryItems: [String: String]
    private let bodyData: Data?
    
    init(urlString: String, method: HttpMethod, headers: [String: String], queryItems: [String: String], bodyData: Data?) {
        self.urlString = urlString
        self.method = method
        self.headers = headers
        self.queryItems = queryItems
        self.bodyData = bodyData
    }
    
    func urlRequest() throws -> URLRequest {
        guard let url = url() else {
            throw EndpointError.invalidURLError
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpBody = bodyData
        
        return urlRequest
    }
    
    private func url() -> URL? {
        guard var urlComponents = URLComponents(string: urlString) else {
            return nil
        }
        
        urlComponents.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents.url
    }
}
