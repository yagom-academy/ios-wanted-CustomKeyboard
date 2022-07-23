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
