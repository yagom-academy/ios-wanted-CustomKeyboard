//
//  KeyboardManager.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/14.
//

import UIKit

class KeyboardManager {
    private var lastWord = ""
    private var allWord: [String] = []
    
    private let first = ["ㄱ", "ㄱㄱ", "ㄴ", "ㄷ", "ㄷㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅂㅂ", "ㅅ", "ㅅㅅ", "ㅇ", "ㅈ", "ㅈㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    private let second = [
        "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"
    ]
    private let secondDouble = ["ㅏ", "ㅏㅣ", "ㅑ", "ㅑㅣ", "ㅓ", "ㅓㅣ", "ㅕ", "ㅕㅣ", "ㅗ", "ㅗㅏ", "ㅗㅐ", "ㅗㅣ", "ㅛ", "ㅜ", "ㅜㅓ", "ㅜㅔ", "ㅜㅣ", "ㅠ", "ㅡ", "ㅡㅣ", "ㅣ"]
    private let third = [
        "", "ㄱ", "ㄱㄱ", "ㄱㅅ", "ㄴ", "ㄴㅈ", "ㄴㅎ", "ㄷ", "ㄹ", "ㄹㄱ", "ㄹㅁ", "ㄹㅂ", "ㄹㅅ", "ㄹㅌ", "ㄹㅍ", "ㄹㅎ", "ㅁ", "ㅂ", "ㅂㅅ",
        "ㅅ", "ㅅㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    
    func pressSpace(_ tappedButton: KeyButton) -> (String, Int) {
        lastWord = " "
        return (" ", 0)
    }
    
    func makeString(_ state: Int, _ currentText: String, _ tappedButton: KeyButton) -> (String, Int) {
        guard let addString = tappedButton.title(for: .normal) else { return ("", 0) }
        allWord.append(addString)
        switch state {
        case 0:
            // 초기 상태
            if tappedButton.type == .space {
                return pressSpace(tappedButton)
            }
            
            lastWord = addString
            if tappedButton.type == .consonant {
                return (addString, 1)
            } else {
                return (addString, 2)
            }
        case 1:
            lastWord = addString
            // 자음이 입력되어 있는 상태 (ex ㄷ, ㅇ, ㅈ, ㄱ ...)
            if tappedButton.type == .space {
                return pressSpace(tappedButton)
            }
            
            if tappedButton.type == .consonant {
                return (currentText + addString, 1)
            } else {
                let idx1 = first.firstIndex(of: currentText) ?? 0
                let idx2 = second.firstIndex(of: addString) ?? 0
                let str = 44032 + (idx1 * 588) + (idx2 * 28)
                if let scalarValue = UnicodeScalar(str) {
                    return (String(scalarValue), 3)
                }
                return ("", 0)
            }
            // TODO: - 이중 모음의 경우 구현 : ㅘ + ㅣ = ㅙ 구현 X
        case 2:
            // 모음이 입력되어 있는 상태 (ex ㅏ, ㅑ, ㅜ, ㅗ ...)
            if tappedButton.type == .space {
                return pressSpace(tappedButton)
            }
            
            if tappedButton.type == .consonant {
                lastWord = addString
                return (currentText + addString, 1)
            } else {
                let doubleMid = lastWord + addString
                let idx = secondDouble.firstIndex(of: doubleMid) ?? 0
                if idx == 0 {
                    lastWord = addString
                    return (currentText + addString, 2)
                } else {
                    lastWord = doubleMid
                    let str = second[idx]
                    return (str, 2)
                }
            }
        case 3:
            // 자음 + 모음이 입력되어 있는 상태 (ex 하, 기, 시, 러 ...)
            if tappedButton.type == .space {
                return pressSpace(tappedButton)
            }
            
            if tappedButton.type == .consonant {
                let idx = third.firstIndex(of: addString) ?? 0
                let str = currentText.utf16.map{ Int($0) }.reduce(0, +) + idx
                if let scalarValue = UnicodeScalar(str) {
                    lastWord = addString
                    return (String(scalarValue), 4)
                }
                return ("", 0)
            } else {
                let doubleMid = lastWord + addString
                let idx1 = secondDouble.firstIndex(of: doubleMid) ?? 0
                let idx2 = second.firstIndex(of: lastWord) ?? 0
                if idx1 == 0 {
                    lastWord = addString
                    return (currentText + addString, 2)
                } else {
                    let str = currentText.utf16.map{ Int($0) }.reduce(0, +) - (idx2 * 28) + (idx1 * 28)
                    if let scalarValue = UnicodeScalar(str) {
                        lastWord = doubleMid
                        return (String(scalarValue), 3)
                    }
                    return ("", 0)
                }
            }
        case 4:
            // 자음 + 모음 + 자음으로 받침이 있는 상태 (ex 언, 젠, 간, 끝 ...)
            if tappedButton.type == .space {
                return pressSpace(tappedButton)
            }
            
            if tappedButton.type == .consonant {
                let doubleEnd = lastWord + addString
                let idx1 = third.firstIndex(of: doubleEnd) ?? 0
                let idx2 = third.firstIndex(of: lastWord) ?? 0
                if idx1 == 0 {
                    lastWord = addString
                    return (currentText + addString, 1)
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
        default:
            return ("", 0)
        }
    }
    
    func deleteString(_ state: Int, _ currentText: String) -> (String, Int) {
        if !allWord.isEmpty {
            allWord.removeLast()
        }
        switch state {
        case 1:
            // 쌍자음만 입력되어 있는 상태 (ex ㄱㄱ, ㄷㄷ, ㅂㅂ ...)
            if lastWord.count == 2 {
                lastWord = allWord[allWord.count - 1]
                return (allWord[allWord.count - 1], 1)
            } else {
                lastWord = allWord[allWord.count - 1]
                return ("", 0)
            }
        case 2:
            // 이중 모음이 입력되어 있는 상태 (ex ㅏㅣ, ㅓㅣ, ㅡㅣ ...)
            if lastWord.count == 2 {
                lastWord = allWord[allWord.count - 1]
                return (allWord[allWord.count - 1], 2)
            } else {
                lastWord = allWord[allWord.count - 1]
                return ("", 0)
            }
        case 3:
            // 자음 + 이중모음이 입력되어 있는 상태 (ex 왜, 내, 의 ...)
            if lastWord.count == 2 {
                let idx1 = secondDouble.firstIndex(of: lastWord) ?? 0
                let idx2 = second.firstIndex(of: allWord[allWord.count - 1]) ?? 0
                let str = currentText.utf16.map{ Int($0) }.reduce(0, +) - idx1 + idx2
                lastWord = allWord[allWord.count - 1]
                if let scalarValue = UnicodeScalar(str) {
                    return (String(scalarValue), 3)
                }
                return ("", 0)
            } else {
                // TODO: - 가, 야, .. (앞글자의 받침으로 들어갈수 있는지 확인)
                let idx = second.firstIndex(of: lastWord) ?? 0
                let str = currentText.utf16.map{ Int($0) }.reduce(0, +) - idx
                lastWord = allWord[allWord.count - 1]
                if let scalarValue = UnicodeScalar(str) {
                    return (String(scalarValue), 1)
                }
                return ("", 0)
            }
        case 4:
            // 겹받침이 있는 상태 (ex 핥, 삷, 겠, 찲 ...)
            if lastWord.count == 2 {
                let idx1 = third.firstIndex(of: lastWord) ?? 0
                let idx2 = third.firstIndex(of: allWord[allWord.count - 1]) ?? 0
                let str = currentText.utf16.map{ Int($0) }.reduce(0, +) - idx1 + idx2
                lastWord = allWord[allWord.count - 1]
                if let scalarValue = UnicodeScalar(str) {
                    return (String(scalarValue), 4)
                }
                return ("", 0)
            } else {
                let idx = third.firstIndex(of: lastWord) ?? 0
                let str = currentText.utf16.map{ Int($0) }.reduce(0, +) - idx
                lastWord = allWord[allWord.count - 1]
                if let scalarValue = UnicodeScalar(str) {
                    return (String(scalarValue), 3)
                }
                return ("", 0)
            }
        default:
            return ("", 0)
        }
    }
}
