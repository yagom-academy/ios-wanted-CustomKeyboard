//
//  File.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/14.
//

import Foundation

class Observable<T> {
  private var listener: ((T) -> Void)?

  var value: T {
    didSet {
      listener?(value)
    }
  }

  init(_ value: T) {
    self.value = value
  }

  func bind(_ closure: @escaping (T) -> Void) {
    closure(value)
    listener = closure
  }
}
