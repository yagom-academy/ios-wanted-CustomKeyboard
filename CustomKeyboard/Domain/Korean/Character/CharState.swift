//
//  CharState.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/20.
//

import Foundation

enum CharState {
  case includingFinalChar(Int,Int,Int)
  case noneFinalChar(Int,Int)
  case onlyConsonant
  case onlyVowel
}
