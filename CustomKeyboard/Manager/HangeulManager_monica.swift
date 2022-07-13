//
//  HangeulManager_monica.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/12.
//

import Foundation

enum HGStatus {
    case start, choseong, jungseong, doubleJungseong, jongseong, doubleJongseong, endCaseOne, endCaseTwo
}

enum CharacterKind {
    case consonant, vowel
}

struct HGChar {
    static let choseong: [String] = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    static let jungseong: [String] = ["ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ", "ㅕ", "ㅖ", "ㅗ", "ㅘ", "ㅙ", "ㅚ", "ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ", "ㅣ"]

    static let jongseong: [String] = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ", "ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]

    static let splitJongseong: [String] = ["", "ㄱ", "ㄲ", "ㄱㅅ", "ㄴ", "ㄴㅈ", "ㄴㅎ", "ㄷ", "ㄹ", "ㄹㄱ", "ㄹㅁ", "ㄹㅂ", "ㄹㅅ", "ㄹㅌ", "ㄹㅍ", "ㄹㅎ", "ㅁ", "ㅂ", "ㅂㅅ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
    
    static let baseCode = 44032
    static let jungCount = 21
    static let jongCount = 28
    static let firstChoseongUnicodeValue = 0x1100
    static let firstJungseongUnicodeValue = 0x1161
    static let firstJongseongUnicodeValue = 0x11A7
}

struct Double {
    static let jungseong = ["ㅗ": ["ㅏ": "ㅘ", "ㅐ": "ㅙ", "ㅣ": "ㅚ"], "ㅜ": ["ㅓ": "ㅝ", "ㅔ": "ㅞ", "ㅣ": "ㅟ"], "ㅡ": ["ㅣ": "ㅢ"]]
    static let jongseong = ["ㄱ": ["ㅅ": "ㄳ"], "ㄴ": ["ㅈ": "ㄵ", "ㅎ": "ㄶ"], "ㄹ": ["ㄱ": "ㄺ", "ㅁ": "ㄻ", "ㅂ": "ㄼ", "ㅅ": "ㄽ", "ㅌ": "ㄾ", "ㅍ": "ㄿ", "ㅎ": "ㅀ"], "ㅂ": ["ㅅ": "ㅄ"]]
}

class HangeulManager {

    static let shared = HangeulManager()
    private init() { }

    private var separatedBuffer = [String]() // 아직 조합이 완성되지 않은 문자들만 담아놓기
    private var combinedBuffer = [String]() // 화면에 출력될 글자들만 담아놓기
    private var status = HGStatus.start
}

// MARK: - 문자 입력시 호출

extension HangeulManager {
    func update(_ input: String) {
        setStatus(input)
        setSeparatedBuffer(input)
//        setCombinedBuffer(input) // 조합상태에 따라서 출력할 문자열 완성하기
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
            if separatedBuffer.isEmpty {
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
        let characterKind:CharacterKind = HGChar.jungseong.contains(input) ? .vowel : .consonant
        let lastChar = self.separatedBuffer.last ?? ""
        
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
            if HGChar.jongseong.contains(input) {
                status = .jongseong
            } else if Double.jungseong[lastChar]?[input] != nil {
                status = .doubleJungseong
                print("here!")
            } else {
                status = .endCaseOne
            }
        case .doubleJungseong: // 종성이 될 수 있는 자음
            if HGChar.jongseong.contains(input) {
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

// MARK: - buffer에 문자 추가/삭제

extension HangeulManager {
    private func setSeparatedBuffer(_ input: String) {
        let characterKind: CharacterKind = HGChar.jungseong.contains(input) ? .vowel : .consonant

        switch self.status {
        case .choseong, .jungseong, .jongseong:
            self.separatedBuffer.append(input)
        case .doubleJungseong:
            let last = separatedBuffer.removeLast()
            let newChar = Double.jungseong[last]?[input]
            self.separatedBuffer.append(newChar ?? "")
        case .doubleJongseong:
            let last = self.separatedBuffer.removeLast()
            let newChar = Double.jongseong[last]?[input]
            self.separatedBuffer.append(newChar ?? "")
        case .endCaseOne:
            if characterKind == .vowel {
                self.separatedBuffer = []
            } else {
                self.separatedBuffer = [input]
            }
        case .endCaseTwo:
            let last = separatedBuffer.removeLast()
            self.separatedBuffer = [last, input]
        default:
            break
        }
    }
}

// MARK: - 프로퍼티 초기화

extension HangeulManager {
    func reset() {
        self.separatedBuffer = []
        self.combinedBuffer = []
        self.status = .start
    }
}

// MARK: - SeparatedBuffer 원소 개수 Get(테스트용)

extension HangeulManager {
    func getSeparatedBufferCount() -> Int {
        return self.separatedBuffer.count
    }
}

// MARK: - 초성/중성/종성을 모아 한 글자로 만드는 메서드

extension HangeulManager {
    func getCombinedWord(_ cho: String, _ jung: String, _ jong: String) -> String {
        let choIndex = Int(HGChar.choseong.firstIndex(of: cho) ?? 0)
        let jungIndex = Int(HGChar.jungseong.firstIndex(of: jung) ?? 0)
        let jongIndex = Int(HGChar.jongseong.firstIndex(of: jong) ?? 0)
        
        let combinedValue = (choIndex * HGChar.jungCount * HGChar.jongCount) + (jungIndex * HGChar.jongCount) + jongIndex + HGChar.baseCode
        
        let combinedWord = String(UnicodeScalar(combinedValue)!)
        
        return combinedWord
    }
}

// MARK: - 한 글자를 초성, 중성, 종성으로 해체하는 함수

extension HangeulManager {
    func getSeparatedCharacters(from word: String) -> [String] {
        let unicode = Int(UnicodeScalar(word)!.value) - HGChar.baseCode
        
        let choValue = (((unicode - (unicode % HGChar.jongCount)) / HGChar.jongCount) / HGChar.jungCount) + HGChar.firstChoseongUnicodeValue
        let jungValue = (((unicode - (unicode % HGChar.jongCount)) / HGChar.jongCount) % HGChar.jungCount) + HGChar.firstJungseongUnicodeValue
        let jongValue = (unicode % HGChar.jongCount) + HGChar.firstJongseongUnicodeValue

        let cho = String(UnicodeScalar(choValue)!)
        let jung = String(UnicodeScalar(jungValue)!)
        let jong = String(UnicodeScalar(jongValue)!)
        
        return [cho, jung, jong]
    }
}
