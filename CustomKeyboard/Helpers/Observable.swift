//
//  Observable.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/13.
//

import Foundation

final class Observable<T> {
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
