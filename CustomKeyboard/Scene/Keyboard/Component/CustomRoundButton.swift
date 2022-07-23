//
//  CustomRoundButton.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/14.
//

import UIKit

final class CustomRoundButton: UIButton {
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 4
    self.clipsToBounds = true
    self.tintColor = .white
  }
  
}
