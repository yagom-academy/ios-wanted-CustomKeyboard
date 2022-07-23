//
//  String+.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/13.
//

import Foundation

extension String {
  func toDate() -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    guard let date = dateFormatter.date(from: self)
    else {
      return Date.now
    }
    return date
  }
}
