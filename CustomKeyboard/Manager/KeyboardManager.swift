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
    
    private let first = [
        "ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    private let firstDouble = [
        "ㄱ", "ㄱㄱ", "ㄴ", "ㄷ", "ㄷㄷ", "ㄹ", "ㅁ", "ㅂ", "ㅂㅂ", "ㅅ", "ㅅㅅ", "ㅇ", "ㅈ", "ㅈㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    private let second = [
        "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"
    ]
    private let secondDouble = [
        "ㅏ", "ㅏㅣ", "ㅑ", "ㅑㅣ", "ㅓ", "ㅓㅣ", "ㅕ", "ㅕㅣ", "ㅗ", "ㅗㅏ", "ㅗㅐ", "ㅗㅣ",
        "ㅛ", "ㅜ", "ㅜㅓ", "ㅜㅔ", "ㅜㅣ", "ㅠ", "ㅡ", "ㅡㅣ", "ㅣ"
    ]
    private let third = [
        "", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ",
        "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    private let thirdDouble = [
        "", "ㄱ", "ㄱㄱ", "ㄱㅅ", "ㄴ", "ㄴㅈ", "ㄴㅎ", "ㄷ", "ㄹ", "ㄹㄱ", "ㄹㅁ", "ㄹㅂ", "ㄹㅅ", "ㄹㅌ",
        "ㄹㅍ", "ㄹㅎ", "ㅁ", "ㅂ", "ㅂㅅ", "ㅅ", "ㅅㅅ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"
    ]
    
    func pressSpace(_ tappedButton: KeyButton) -> (String, Int) {
        lastWord = " "
        return (" ", 0)
    }
    
    func makeString(_ state: Int, _ currentText: String, _ tappedButton: KeyButton) -> (String, Int) {
        if tappedButton.type == .space {
            print("space")
            return pressSpace(tappedButton)
        }
        
        guard let addString = tappedButton.title(for: .normal) else { return ("", 0) }
        switch state {
        case 0:
            // 초기 상태
            lastWord = addString
            allWord.append(addString)
            if tappedButton.type == .consonant {
                return (addString, 1)
            } else {
                return (addString, 2)
            }
        case 1:
            // 자음이 입력되어 있는 상태 (ex ㄷ, ㅇ, ㅈ, ㄱ ...)
            if tappedButton.type == .consonant {
                let doubleFirst = lastWord + addString
                let idx = firstDouble.firstIndex(of: doubleFirst) ?? 0
                if idx == 0 {
                    lastWord = addString
                    allWord.append(lastWord)
                    return (currentText + addString, 1)
                } else {
                    lastWord = doubleFirst
                    allWord.removeLast()
                    allWord.append(lastWord)
                    let str = first[idx]
                    return (str, 1)
                }
            } else {
                let idx1 = first.firstIndex(of: currentText) ?? 0
                let idx2 = second.firstIndex(of: addString) ?? 0
                let str = 44032 + (idx1 * 588) + (idx2 * 28)
                if let scalarValue = UnicodeScalar(str) {
                    lastWord = addString
                    allWord.append(lastWord)
                    return (String(scalarValue), 3)
                }
                return ("", 0)
            }
            // TODO: - 이중 모음의 경우 구현 : ㅘ + ㅣ = ㅙ 구현 X
        case 2:
            // 모음이 입력되어 있는 상태 (ex ㅏ, ㅑ, ㅜ, ㅗ ...)
            if tappedButton.type == .consonant {
                lastWord = addString
                allWord.append(lastWord)
                return (currentText + addString, 1)
            } else {
                let doubleMid = lastWord + addString
                let idx = secondDouble.firstIndex(of: doubleMid) ?? 0
                if idx == 0 {
                    lastWord = addString
                    allWord.append(lastWord)
                    return (currentText + addString, 2)
                } else {
                    lastWord = doubleMid
                    allWord.removeLast()
                    allWord.append(lastWord)
                    let str = second[idx]
                    return (str, 2)
                }
            }
        case 3:
            // 자음 + 모음이 입력되어 있는 상태 (ex 하, 기, 시, 러 ...)
            if tappedButton.type == .consonant {
                let idx = third.firstIndex(of: addString) ?? 0
                if idx == 0 {
                    lastWord = addString
                    allWord.append(lastWord)
                    return (currentText+addString, 1)
                }
                let str = currentText.utf16.map{ Int($0) }.reduce(0, +) + idx
                if let scalarValue = UnicodeScalar(str) {
                    lastWord = addString
                    allWord.append(lastWord)
                    return (String(scalarValue), 4)
                }
                return ("", 0)
            } else {
                let doubleMid = lastWord + addString
                let idx1 = secondDouble.firstIndex(of: doubleMid) ?? 0
                let idx2 = second.firstIndex(of: lastWord) ?? 0
                if idx1 == 0 {
                    lastWord = addString
                    allWord.append(lastWord)
                    return (currentText + addString, 2)
                } else {
                    let str = currentText.utf16.map{ Int($0) }.reduce(0, +) - (idx2 * 28) + (idx1 * 28)
                    if let scalarValue = UnicodeScalar(str) {
                        lastWord = doubleMid
                        allWord.removeLast()
                        allWord.append(lastWord)
                        return (String(scalarValue), 3)
                    }
                    return ("", 0)
                }
            }
        case 4:
            // 자음 + 모음 + 자음으로 받침이 있는 상태 (ex 언, 젠, 간, 끝 ...)
            if tappedButton.type == .consonant {
                let doubleEnd = lastWord + addString
                let idx1 = thirdDouble.firstIndex(of: doubleEnd) ?? 0
                let idx2 = thirdDouble.firstIndex(of: lastWord) ?? 0
                if idx1 == 0 {
                    lastWord = addString
                    allWord.append(lastWord)
                    return (currentText + addString, 1)
                } else {
                    let str = currentText.utf16.map{ Int($0) }.reduce(0, +) - idx2 + idx1
                    if let scalarValue = UnicodeScalar(str) {
                        lastWord = doubleEnd
                        allWord.removeLast()
                        allWord.append(lastWord)
                        return (String(scalarValue), 4)
                    }
                    return ("", 0)
                }
            } else {
                // 자음 + 모음 + 자음으로 받침이 있는 상태 (ex 언, 젠, 간, 끝, 밟 ...)
                let idx1 = thirdDouble.firstIndex(of: lastWord) ?? 0
                let idx2 = second.firstIndex(of: addString) ?? 0
                var oldStr = 0
                var newStr = 0
                // 쌍자음 받침 뒤에 모음이 오는 경우 (ex 갔 + ㅏ, 잤 + ㅗ ...)
                if let doubleIdx = firstDouble.firstIndex(of: lastWord) {
                    oldStr = currentText.utf16.map{ Int($0) }.reduce(0, +) - idx1
                    newStr = 44032 + (doubleIdx * 588) + (idx2 * 28)
                    // 겹받침 뒤에 모음이 오는 경우 (ex 밟 + ㅏ, 삶 + ㅏ ...) 밟 -> 바 -> 발
                } else {
                    let thirdText = allWord.removeLast()
                    let separateText1 = String(thirdText.prefix(1))
                    let separateText2 = String(thirdText.suffix(1))
                    let idx3 = thirdDouble.firstIndex(of: separateText1) ?? 0
                    let idx4 = first.firstIndex(of: separateText2) ?? 0
                    allWord.append(separateText1)
                    allWord.append(separateText2)
                    oldStr = currentText.utf16.map{ Int($0) }.reduce(0, +) - idx1 + idx3
                    newStr = 44032 + (idx4 * 588) + (idx2 * 28)
                }
                if let oldScalarValue = UnicodeScalar(oldStr),
                   let newScalarValue = UnicodeScalar(newStr) {
                    lastWord = addString
                    allWord.append(lastWord)
                    return (String(oldScalarValue) + String(newScalarValue), 3)
                }
                return ("", 0)
            }
        default:
            return ("", 0)
        }
    }
    
    func deleteString(_ state: Int, _ currentText: String) -> (String, Int) {
        if allWord.isEmpty {
            return ("", 0)
        }
        
        let deleteText = allWord.removeLast()
        switch state {
        case 1:
            // 쌍자음만 입력되어 있는 상태 (ex ㄱㄱ, ㄷㄷ, ㅂㅂ ...)
            if lastWord.count == 2 {
                lastWord = String(lastWord.prefix(1))
                allWord.append(lastWord)
                return (lastWord, 1)
            } else {
                lastWord = allWord[allWord.count - 1]
                return ("", 0)
            }
        case 2:
            // 이중 모음이 입력되어 있는 상태 (ex ㅏㅣ, ㅓㅣ, ㅡㅣ ...)
            if lastWord.count == 2 {
                lastWord = String(lastWord.prefix(1))
                return (lastWord, 2)
            } else {
                lastWord = allWord[allWord.count - 1]
                return ("", 0)
            }
        case 3:
            // 자음 + 이중모음이 입력되어 있는 상태 (ex 왜, 내, 의 ...)
            if lastWord.count == 2 {
                let idx1 = secondDouble.firstIndex(of: lastWord) ?? 0
                let idx2 = second.firstIndex(of: String(lastWord.prefix(1))) ?? 0
                let str = currentText.utf16.map{ Int($0) }.reduce(0, +) - (idx1 * 28) + (idx2 * 28)
                lastWord = String(lastWord.prefix(1))
                if let scalarValue = UnicodeScalar(str) {
                    return (String(scalarValue), 3)
                }
                return ("", 0)
            } else {
                // TODO: - 가, 야, .. (앞글자의 받침으로 들어갈수 있는지 확인)
                let frontText = String(currentText.prefix(1)) // ["ㅏ"]
                return ("", 0)
            }
        case 4:
            // 겹받침이 있는 상태 (ex 핥, 삷, 겠, 찲 ...)
            if lastWord.count == 2 {
                let idx1 = thirdDouble.firstIndex(of: lastWord) ?? 0
                let idx2 = third.firstIndex(of: String(lastWord.prefix(1))) ?? 0
                let str = currentText.utf16.map{ Int($0) }.reduce(0, +) - idx1 + idx2
                lastWord = String(lastWord.prefix(1))
                allWord.append(lastWord)
                if let scalarValue = UnicodeScalar(str) {
                    return (String(scalarValue), 4)
                }
                return ("", 0)
            } else {
                // 홀받침이 있는 상태 (ex 박, 살, 깃 ...)
                let idx = thirdDouble.firstIndex(of: lastWord) ?? 0
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
