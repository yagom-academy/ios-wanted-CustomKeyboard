//
//  EndPoint.swift
//  CustomKeyboard
//
//  Created by BH on 2022/07/19.
//

import Foundation

protocol EndPointType {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var query: [URLQueryItem]? { get }
    
    func asURLRequest() throws -> URLRequest
    
}

extension EndPointType {
    
    func asURLRequest() throws -> URLRequest {
        var components = URLComponents(string: baseURL)
        components?.path = path
        components?.queryItems = query
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
}

