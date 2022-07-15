//
//  KeyboardManager.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/14.
//

import UIKit

class KeyboardManager {
    static let shared = KeyboardManager()
    private var lastWord = ""
    private var allWord: [String] = []
    
    private let first = ["ㄱ", "ㄱㄱ", "ㄴ", "ㄷ", "ㄷㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅂㅂ", "ㅅ", "ㅅㅅ", "ㅇ", "ㅈ", "ㅈㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    private let second = [
        "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"
    ]
    private let third = [
        "", "ㄱ", "ㄱㄱ", "ㄱㅅ", "ㄴ", "ㄴㅈ", "ㄴㅎ", "ㄷ", "ㄹ", "ㄹㄱ", "ㄹㅁ", "ㄹㅂ", "ㄹㅅ", "ㄹㅌ", "ㄹㅍ", "ㄹㅎ", "ㅁ", "ㅂ", "ㅂㅅ",
        "ㅅ", "ㅅㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    
    func makeString(_ state: Int, _ currentText: Character, _ tappedButton: KeyButton) -> (String, Int) {
        guard let addString = tappedButton.title(for: .normal) else { return ("", 0) }
        switch state {
        case 0:
            // 초기 상태
            print("0")
            allWord.append(addString)
            lastWord = addString
            if tappedButton.type == .consonant {
                return (addString, 1)
            } else {
                return (addString, 0)
            }
        case 1:
            // 자음이 입력되어 있는 상태 (ex ㄷ, ㅇ, ㅈ, ㄱ ...)
            print("1")
            allWord.append(addString)
            if tappedButton.type == .consonant {
                lastWord = addString
                return (String(currentText) + addString, 1)
            } else {
                let idx1 = first.firstIndex(of: String(currentText)) ?? 0
                let idx2 = second.firstIndex(of: addString) ?? 0
                let str = 44032 + (idx1 * 588) + (idx2 * 28)
                if let scalarValue = UnicodeScalar(str) {
                    lastWord = addString
                    return (String(scalarValue), 3)
                }
                return ("", 0)
            }
            // TODO: - 이중 모음의 경우 구현
        case 2:
            // 모음이 입력되어 있는 상태 (ex ㅏ, ㅑ, ㅜ, ㅗ ...)
            print("2")
            allWord.append(addString)
            return (String(currentText) + addString, 0)
        case 3:
            // 자음 + 모음이 입력되어 있는 상태 (ex 하, 기, 시, 러 ...)
            print("3")
            allWord.append(addString)
            if tappedButton.type == .consonant {
                let idx = third.firstIndex(of: addString) ?? 0
                let str = currentText.utf16.map{ Int($0) }.reduce(0, +) + idx
                if let scalarValue = UnicodeScalar(str) {
                    lastWord = addString
                    return (String(scalarValue), 4)
                }
                return ("", 0)
            } else {
                lastWord = addString
                return (String(currentText) + addString, 2)
            }
        case 4:
            // 자음 + 모음 + 자음으로 받침이 있는 상태 (ex 언, 젠, 간, 끝 ...)
            print("4")
            allWord.append(addString)
            if tappedButton.type == .consonant {
                let doubleEnd = lastWord + addString
                let idx1 = third.firstIndex(of: doubleEnd) ?? 0
                let idx2 = third.firstIndex(of: lastWord) ?? 0
                if idx1 == 0 {
                    lastWord = addString
                    return (String(currentText) + addString, 1)
                } else {
                    let str = currentText.utf16.map{ Int($0) }.reduce(0, +) - idx2 + idx1
                    if let scalarValue = UnicodeScalar(str) {
                        lastWord = doubleEnd
                        return (String(scalarValue), 4)
                    }
                    return ("", 0)
                }
            } else {
                // 자음 + 모음 + 자음으로 받침이 있는 상태 (ex 언, 젠, 간, 끝, 밟 ...)
                let idx1 = third.firstIndex(of: lastWord) ?? 0
                let idx2 = third.firstIndex(of: allWord[allWord.count - 3]) ?? 0
                let idx3 = first.firstIndex(of: allWord[allWord.count - 2]) ?? 0
                let idx4 = second.firstIndex(of: addString) ?? 0
                var oldStr = 0
                var newStr = 0
                // 쌍자음 받침 뒤에 모음이 오는 경우 (ex 갔 + ㅏ, 잤 + ㅗ ...)
                if let doubleIdx = first.firstIndex(of: lastWord) {
                    oldStr = currentText.utf16.map{ Int($0) }.reduce(0, +) - idx1
                    newStr = 44032 + (doubleIdx * 588) + (idx4 * 28)
                    // 겹받침 뒤에 모음이 오는 경우 (ex 밟 + ㅏ, 삶 + ㅏ ...) 밟 -> 바 -> 발
                } else {
                    oldStr = currentText.utf16.map{ Int($0) }.reduce(0, +) - idx1 + idx2
                    newStr = 44032 + (idx3 * 588) + (idx4 * 28)
                }
                if let oldScalarValue = UnicodeScalar(oldStr),
                   let newScalarValue = UnicodeScalar(newStr) {
                    lastWord = addString
                    return (String(oldScalarValue) + String(newScalarValue), 3)
                }
                return ("", 0)
            }
//        case 5:
//            print("5")
//            allWord.append(addString)
//            if tappedButton.type == .consonant {
//                allWord.append(addString)
//                return (String(currentText) + addString, 0)
//            } else {
//
//            }
//            return ("", 0)
//        case 6:
//        case 7:
//        case 8:
        default:
            return ("", 0)
        }
    }
}
