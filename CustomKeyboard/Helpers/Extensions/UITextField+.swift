//
//  UITextField+.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/23.
//

import UIKit

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
