//
//  Requestable.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/11.
//

import Foundation

enum HTTPRequest: String {
  case get = "GET"
  case post = "POST"
}

protocol Requestable {
  var requestType: HTTPRequest {get}
  var body: Data? {get}
  var endPoint: EndPoint {get}
}

