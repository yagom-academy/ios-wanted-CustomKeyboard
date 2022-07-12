//
//  HangeulManager_monica.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/12.
//

import Foundation

enum HangeulStatus {
    case start, choseong, jungseong, doubleJungseong, jongseong, doubleJongseong, endCaseOne, endCaseTwo
}


class HangeulManager {

    static let shared = HangeulManager()
    private init() { }

    private var buffer = [Character]() // 아직 조합이 완성되지 않은 문자들만 담아놓기
    private var bufferString = [Character]() // 화면에 출력될 글자들만 담아놓기
    private var status : HangeulStatus!
}


