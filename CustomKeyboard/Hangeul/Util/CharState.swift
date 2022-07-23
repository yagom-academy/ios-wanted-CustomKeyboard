//
//  CharState.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/20.
//

import Foundation

enum CharState {
    case includingFinalChar(initial: Int,neutral: Int,final: Int)
    case noneFinalChar(initial: Int,neutral: Int)
    case onlyConsonant
    case onlyVowel
}
