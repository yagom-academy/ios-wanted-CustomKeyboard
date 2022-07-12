//
//  Request.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/11.
//

import Foundation

struct Requset: Requestable {
  var requestType: HTTPRequest
  var body: Data?
  var endPoint: EndPoint
}

extension URLRequest {
  static func makeURLRequest(request: Requestable) -> Self {
    var urlRequest = URLRequest(url: request.endPoint.url)
    urlRequest.httpMethod = request.requestType.rawValue
    urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest.httpBody = request.body
    return urlRequest
  }
}
