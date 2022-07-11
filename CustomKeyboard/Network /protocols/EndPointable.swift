//
//  EndPointable.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/11.
//

import Foundation


protocol EndPointable {
  var scheme: String {get}
  var host: String {get}
  var path: ServerPath {get}
  var queryItems: [URLQueryItem]? {get}
  var url: URL {get}
}

extension EndPointable {
  var scheme: String {"https"}
  var host: String {"api.plkey.app"}
}







