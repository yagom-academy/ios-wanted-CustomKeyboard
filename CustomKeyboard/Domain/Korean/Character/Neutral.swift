//
//  Neutral.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/20.
//

import Foundation

enum Neutral:Int {
  case ㅏ,ㅐ,ㅑ,ㅒ,ㅓ,ㅔ,ㅕ,ㅖ,ㅗ,ㅘ,ㅙ,ㅚ,ㅛ,ㅜ,ㅝ,ㅞ,ㅟ,ㅠ,ㅡ,ㅢ,ㅣ
  
  var value: Int {
    return self.rawValue
  }
  
  static func getVowelToNeutralValue(_ unicode: Int) -> Int {
    return unicode - 12623
  }
  
  static func getNeutralValueToVowel(_ NeutralValue: Int) -> Int {
    return NeutralValue + 12623
  }
}
