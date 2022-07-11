//
//  EndPoint.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/11.
//

import Foundation

enum ServerPath: String {
  case showList = "/theme/review"
  case postComment = "/tmp/theme/PLKEY0-L-81/review"
}

struct EndPoint: EndPointable {
  let path: ServerPath
  init(path: ServerPath){
    self.path = path
  }
}

extension EndPoint {
  var url: URL {
    var urlComponent = URLComponents()
    urlComponent.scheme = scheme
    urlComponent.host = host
    urlComponent.path = path.rawValue
    urlComponent.queryItems = queryItems
    guard let url = urlComponent.url
    else
    {
      preconditionFailure("Invalid URL components: \(urlComponent)")
    }
    return url
  }
}
