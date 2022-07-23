//
//  UIButton+.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/23.
//

import UIKit

extension UIButton {
  func setKeyBoardBackgroundColor(_ color: UIColor, for state: UIControl.State) {
    UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
    guard let context = UIGraphicsGetCurrentContext() else { return }
    context.setFillColor(color.cgColor)
    context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
    
    let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    self.setBackgroundImage(backgroundImage, for: state)
  }
}
