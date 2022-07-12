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

enum CharacterKind {
    case consonant, vowel
}

struct HangeulCharacter {
    static let choseong: [String] = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    static let jungseong: [String] = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]

    static let jongseong: [String] = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    static let splitJongseong: [String] = ["", "ㄱ", "ㄲ", "ㄱㅅ", "ㄴ", "ㄴㅈ", "ㄴㅎ", "ㄷ", "ㄹ", "ㄹㄱ", "ㄹㅁ", "ㄹㅂ", "ㄹㅅ", "ㄹㅌ", "ㄹㅍ", "ㄹㅎ", "ㅁ", "ㅂ", "ㅂㅅ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    // 겹자음 자소글자를 두 글자로 나눈 것
}

struct Double {
    static let jungseong = ["ㅗ": ["ㅏ": "ㅘ", "ㅐ": "ㅙ", "ㅣ": "ㅚ"], "ㅜ": ["ㅓ": "ㅝ", "ㅔ": "ㅞ", "ㅣ": "ㅟ"], "ㅡ": ["ㅣ": "ㅢ"]]
    static let jongseong = ["ㄱ": ["ㅅ": "ㄳ"], "ㄴ": ["ㅈ": "ㄵ", "ㅎ": "ㄶ"], "ㄹ": ["ㄱ": "ㄺ", "ㅁ": "ㄻ", "ㅂ": "ㄼ", "ㅅ": "ㄽ", "ㅌ": "ㄾ", "ㅍ": "ㄿ", "ㅎ": "ㅀ"], "ㅂ": ["ㅅ": "ㅄ"]]
}

class HangeulManager {

    static let shared = HangeulManager()
    private init() { }

    private var buffer = [String]() // 아직 조합이 완성되지 않은 문자들만 담아놓기
    private var bufferString = [String]() // 화면에 출력될 글자들만 담아놓기
    private var status = HangeulStatus.start
}

// MARK: - 문자 입력시 호출

extension HangeulManager {
    func update(_ input: String) {
        setStatus(input) // 조합상태 결정짓고
        print("status: \(self.status)")
        self.buffer.append(input)
//        setBuffer(input) // buffer에는 아직 문자가 완성되지 않은 애들만 담아놓기
//        setBufferString(input) // 조합상태에 따라서 출력할 문자열 완성하기
    }
}

// MARK: - 문자 조합 상태 결정

extension HangeulManager {

    private func setStatus(_ input: String) {
                setBasicStatus()
                setNewStatus(input)
    }

    private func setBasicStatus() {
        switch self.status {
        case .endCaseOne:
            if buffer.isEmpty {
                self.status = .start
            } else {
                self.status = .choseong
            }
        case .endCaseTwo:
            self.status = .jungseong
        default:
            break
        }
    }
    
    private func setNewStatus(_ input: String) {
        let characterKind:CharacterKind = HangeulCharacter.jungseong.contains(input) ? .vowel : .consonant
        let lastChar = self.buffer.last ?? ""
        
        switch self.status {
        case .start:
            if characterKind == .consonant {
                self.status = .choseong
            } else {
                self.status = .endCaseOne
            }
        case .choseong:
            if characterKind == .vowel {
                status = .jungseong
            } else {
                status = .endCaseOne // 초성이 들어온 상태에서 또 자음이 입력된 경우 끝!
            }
        case .jungseong: // 종성이 될수 있는 자음 또는 겹모음이 될수 있는 모음
            if HangeulCharacter.jongseong.contains(input) {
                status = .jongseong
            } else if Double.jungseong[lastChar]?[input] != nil {
                status = .doubleJungseong
                print("here!")
            } else {
                status = .endCaseOne
            }
        case .doubleJungseong: // 종성이 될 수 있는 자음
            if HangeulCharacter.jongseong.contains(input) {
                    status = .jongseong
                } else {
                    status = .endCaseOne
                }
        case .jongseong:
            if Double.jongseong[lastChar]?[input] != nil {
                status = .doubleJongseong
            } else if characterKind == .vowel {
                status = .endCaseTwo
            } else {
                status = .endCaseOne
            }
        case .doubleJongseong:
            if characterKind == .vowel {
                status = .endCaseTwo
            } else {
                status = .endCaseOne
            }
        default:
            break
        }
    }
}
