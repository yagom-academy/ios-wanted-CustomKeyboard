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
    
    private let first = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    private let second = [
        "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"
    ]
    private let third = [
        "", "ㄱ", "ㄱㄱ", "ㄱㅅ", "ㄴ", "ㄴㅈ", "ㄴㅎ", "ㄷ", "ㄹ", "ㄹㄱ", "ㄹㅁ", "ㄹㅂ", "ㄹㅅ", "ㄹㅌ", "ㄹㅍ", "ㄹㅎ", "ㅁ", "ㅂ", "ㅂㅅ",
        "ㅅ", "ㅅㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    
    func makeString(_ state: Int, _ currentText: Character, _ tappedButton: KeyButton) -> (String, Int) {
        let addString = tappedButton.title(for: .normal)!
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
            print("2")
            allWord.append(addString)
            return (String(currentText) + addString, 0)
        case 3:
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
            print("4")
            allWord.append(addString)
            if tappedButton.type == .consonant {
                let doubleEnd = lastWord + addString
                let idx = third.firstIndex(of: doubleEnd) ?? 0
                let beforeLastWord = allWord[allWord.count - 2]
                print(beforeLastWord, "here")
                let beforeIdx = first.firstIndex(of: beforeLastWord) ?? 100
                if idx == 0 || beforeIdx != 100 {
                    lastWord = addString
                    return (String(currentText) + addString, 3)
                } else {
                    // 이중 받침
                    let idxLast = third.firstIndex(of: lastWord) ?? 0
                    let str = currentText.utf16.map{ Int($0) }.reduce(0, +) + idx - idxLast
                    if let scalarValue = UnicodeScalar(str) {
                        lastWord = addString
                        return (String(scalarValue), 5)
                    }
                    return ("", 0)
                }
            } else {
                let idx1 = third.firstIndex(of: lastWord) ?? 0
                let idx2 = first.firstIndex(of: lastWord) ?? 0
                let idx3 = second.firstIndex(of: addString) ?? 0
                let oldStr = currentText.utf16.map{ Int($0) }.reduce(0, +) - idx1
                let newStr = 44032 + (idx2 * 588) + (idx3 * 28)
                if let oldScalarValue = UnicodeScalar(oldStr),
                   let newScalarValue = UnicodeScalar(newStr) {
                    lastWord = addString
                    return (String(oldScalarValue) + String(newScalarValue), 3)
                }
                return ("", 0)
            }
        case 5:
            print("5")
            allWord.append(addString)
            if tappedButton.type == .consonant {
                allWord.append(addString)
                return (String(currentText) + addString, 0)
            } else {
                
            }
            return ("", 0)
//        case 6:
//        case 7:
//        case 8:
        default:
            return ("", 0)
        }
    }
}
