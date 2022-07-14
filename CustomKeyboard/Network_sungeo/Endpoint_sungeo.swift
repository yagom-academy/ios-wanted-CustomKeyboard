//
//  Endpoint_sungeo.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/14.
//

import Foundation

struct Endpoint_sungeo {
    enum EndpointError: Error {
        case invalidURLError
    }
    
    private let urlString: String
    private let method: HttpMethod_sungeo
    private let headers: [String: String]
    private let queryItems: [String: String]
    
    init(urlString: String, method: HttpMethod_sungeo, headers: [String: String], queryItems: [String: String]) {
        self.urlString = urlString
        self.method = method
        self.headers = headers
        self.queryItems = queryItems
    }
    
    func urlRequest() throws -> URLRequest {
        guard let url = url() else {
            throw EndpointError.invalidURLError
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
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
