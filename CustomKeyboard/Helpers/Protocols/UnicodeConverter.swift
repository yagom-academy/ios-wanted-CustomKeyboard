//
//  UnicodeConverter.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/20.
//

import Foundation

protocol UnicodeConverter {
  func convertCharFromUniCode(_ unicode: Int) -> String
  func convertUniCodeFromChar(_ char: String) -> Int
  func combineCharToUnicode(initial: Int, neutral : Int, final: Int) -> Int
  func lastCharState(_ unicode: Int) -> CharState
}
