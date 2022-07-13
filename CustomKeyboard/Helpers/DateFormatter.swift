//
//  DateFormatter.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/13.
//
import Foundation

final class CustomDateFormatter {
  
  static let shared = CustomDateFormatter()
  
  private init() {}
  
  
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
  func dateToString(from date: Date) -> String {
    dateFormatter.string(from: date)
  }
  
}
