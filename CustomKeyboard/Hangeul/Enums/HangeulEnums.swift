//
//  HangeulEnums.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/20.
//

import Foundation

enum HangeulEumun {
    case moeum, jaeum
}

enum HangeulUnicodeType {
    case fixed, compatible
}

enum HangeulCombinationStatus {
    case ongoing, finished
}

enum HangeulCombinationPosition {
    case choseong, jungseong, jongseong
}

enum HangeulOutputMode {
    case none, add, change, remove
}

enum HangeulInputMode {
    case add, remove, space
}
