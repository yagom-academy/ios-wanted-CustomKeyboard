//
//  HangeulManager_monica.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/12.
//

import Foundation

class HangeulManager {

    static let shared = HangeulManager()
    private init() { }

    private var separatedBuffer = [Int]() // 아직 조합이 완성되지 않은 문자들만 담아놓기(fixed unicode)
    private var combinedBuffer = [Int]() // 화면에 출력될 글자들만 담아놓기(fixed unicode)
    private var status = HG.Status.start
}

// MARK: - 문자 입력시 호출

extension HangeulManager {
    func update(_ inputString: String) {
//        print("=====================================")
//        print("상태: \(status)")
//        print("separatedBuffer:")
//        for ele in separatedBuffer {
//            print(String(UnicodeScalar(ele)!))
//        }
//        print("combinedBuffer:")
//        for ele in combinedBuffer {
//            print(String(UnicodeScalar(ele)!))
//        }
        let input = Int(UnicodeScalar(inputString)!.value)
        setStatus(input)
        setSeparatedBuffer(input)
        setCombinedBuffer(input) // 조합상태에 따라서 출력할 문자열 완성하기
        
    }
}


// MARK: - 문자 조합 상태 결정

extension HangeulManager {

    private func setStatus(_ input: Int) {
        setBasicStatus()
        setNewStatus(input)
    }

    private func setBasicStatus() {
        switch status {
        case .endCaseOne:
            if HG.fixed.mid.list.contains(separatedBuffer.last!) {
                status = .jungseong
            } else {
                status = .choseong
            }
        case .endCaseTwo:
            status = .jungseong
        default:
            break
        }
    }
    
    private func setNewStatus(_ input: Int) {
        let charKind: HG.Kind = HG.compatible.midList.contains(input) ? .vowel : .consonant
        let prev = separatedBuffer.last ?? 0
        
        switch status {
        case .start:
            if charKind == .consonant {
                status = .choseong
            } else {
                status = .jungseong
            }
        case .choseong:
            if charKind == .vowel {
                status = .jungseong
            } else {
                status = .endCaseOne
            }
        case .jungseong:
            if bufferHasChoseong() && HG.compatible.endList.contains(input) {
                status = .jongseong
            } else if canBeDouble(a: prev, b: input) {
                status = .doubleJungseong
            } else {
                status = .endCaseOne
            }
        case .doubleJungseong:
            if bufferHasChoseong() && HG.compatible.endList.contains(input) {
                status = .jongseong
            } else {
                status = .endCaseOne
            }
        case .jongseong:
            if canBeDouble(a: prev, b: input) {
                status = .doubleJongseong
            } else if charKind == .vowel {
                status = .endCaseTwo
            } else {
                status = .endCaseOne
            }
        case .doubleJongseong:
            if charKind == .vowel {
                status = .endCaseTwo
            } else {
                status = .endCaseOne
            }
        default:
            break
        }
    }
}

// MARK: - separatedBuffer에 문자 추가/삭제

extension HangeulManager {
    private func setSeparatedBuffer(_ input: Int) {
        let charKind: HG.Kind = HG.compatible.midList.contains(input) ? .vowel : .consonant
        
        switch status {
        case .choseong:
            let index = HG.compatible.topList.firstIndex(of: input) ?? 0
            let char = HG.fixed.top.list[index]
            separatedBuffer.append(char)
        case .jungseong:
            let index = HG.compatible.midList.firstIndex(of: input) ?? 0
            let char = HG.fixed.mid.list[index]
            separatedBuffer.append(char)
        case .jongseong:
            let index = HG.compatible.endList.firstIndex(of: input) ?? 0
            let char = HG.fixed.end.list[index]
            separatedBuffer.append(char)
        case .doubleJungseong:
            let index = HG.compatible.midList.firstIndex(of: input) ?? 0
            let curr = HG.fixed.mid.list[index]
            let prev = separatedBuffer.removeLast()
            let char = HG.fixed.mid.double[prev]?[curr] ?? 0
            separatedBuffer.append(char)
        case .doubleJongseong:
            let index = HG.compatible.endList.firstIndex(of: input) ?? 0
            let curr = HG.fixed.end.list[index]
            let prev = separatedBuffer.removeLast()
            let char = HG.fixed.end.double[prev]?[curr] ?? 0
            separatedBuffer.append(char)
        case .endCaseOne:
            if charKind == .vowel {
                let index = HG.compatible.midList.firstIndex(of: input) ?? 0
                let char = HG.fixed.mid.list[index]
                separatedBuffer = [char]
            } else {
                let index = HG.compatible.topList.firstIndex(of: input) ?? 0
                let char = HG.fixed.top.list[index]
                separatedBuffer = [char]
            }
        case .endCaseTwo:
            let prev = separatedBuffer.removeLast()
            let index = HG.compatible.midList.firstIndex(of: input) ?? 0
            let char = HG.fixed.mid.list[index]
            separatedBuffer = [prev, char]
        default:
            break
        }
    }
}

// MARK: - combinedBuffer에 문자 추가/삭제

extension HangeulManager {
    private func setCombinedBuffer(_ input: Int) {
        var word : Int!
        let curr = separatedBuffer.last ?? 0
        
        if status != .endCaseOne && status != .choseong && !(status == .jungseong && !bufferHasChoseong()){
            let prevWord = combinedBuffer.removeLast()
            let char = getSeparatedCharacters(from: prevWord)
            print("------setCombinedBuffer")
            for ele in char {
                print(String(UnicodeScalar(ele)!))
            }
            switch status {
            case .jungseong:
                word = getCombinedWord(char[0], curr, HG.fixed.end.blank, isDouble: false)
            case .jongseong:
                word = getCombinedWord(char[0], char[1], curr, isDouble: false)
            case .doubleJungseong:
                if bufferHasChoseong() {
                    word = getCombinedWord(char[0], curr, HG.fixed.end.blank, isDouble: false)
                } else {
                    word = curr
                }
            case .doubleJongseong:
                word = getCombinedWord(char[0], char[1], curr, isDouble: false)
            case .endCaseTwo:
                if HG.fixed.end.split[char[2]] != nil {
                    let prevWord = getCombinedWord(char[0], char[1], HG.fixed.end.split[char[2]]?.first ?? 0, isDouble: false)
                    combinedBuffer.append(prevWord)
                    let prev = HG.fixed.end.split[char[2]]?.last ?? 0
                    word = getCombinedWord(prev, curr, HG.fixed.end.blank, isDouble: true)
                } else {
                    let prevWord = getCombinedWord(char[0], char[1], HG.fixed.end.blank, isDouble: false)
                    combinedBuffer.append(prevWord)
                    word = getCombinedWord(char[2], curr, HG.fixed.end.blank, isDouble: true)
                }
            default:
                break
            }
        } else if status == .endCaseOne || status == .choseong {
            var index : Int!
            if HG.compatible.midList.contains(input) {
                index = HG.compatible.midList.firstIndex(of: input) ?? 0
                word = HG.fixed.mid.list[index]
            } else {
                index = HG.compatible.topList.firstIndex(of: input) ?? 0
                word = HG.fixed.top.list[index]
            }
        } else {
            let index = HG.compatible.midList.firstIndex(of: input) ?? 0
            word = HG.fixed.mid.list[index]
        }
        combinedBuffer.append(word)
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
    func getCombinedWord(_ top: Int, _ mid: Int, _ end: Int, isDouble: Bool) -> Int {
        var topIndex : Int!
        
        if isDouble {
            if status == .endCaseTwo {
                let endIndex = HG.fixed.end.list.firstIndex(of: top) ?? 0
                let compatible = HG.compatible.endList[endIndex]
                topIndex = Int(HG.compatible.topList.firstIndex(of: compatible) ?? 0)
            }
        } else {
            topIndex = Int(HG.fixed.top.list.firstIndex(of: top) ?? 0)
        }
        let midIndex = Int(HG.fixed.mid.list.firstIndex(of: mid) ?? 0)
        let endIndex = Int(HG.fixed.end.list.firstIndex(of: end) ?? 0)
        
        let combinedWord = (topIndex * HG.midCount * HG.endCount) + (midIndex * HG.endCount) + endIndex + HG.baseCode
        
        return combinedWord
    }
}

// MARK: - 한 글자를 초성, 중성, 종성으로 해체하는 함수

extension HangeulManager {
    func getSeparatedCharacters(from word: Int) -> [Int] {
        if status == .jungseong {
            return [word, 0, 0]
        }
        
        
        let unicode = word - HG.baseCode
        
        let top = (((unicode - (unicode % HG.endCount)) / HG.endCount) / HG.midCount) + HG.fixed.top.list.first!
        let mid = (((unicode - (unicode % HG.endCount)) / HG.endCount) % HG.midCount) + HG.fixed.mid.list.first!
        let end = (unicode % HG.endCount) + HG.fixed.end.list.first!
        
        return [top, mid, end]
    }
}


// MARK: - 겹모음인지, 겹받침인지, separatedBuffer에 초성이 있는지 판정

extension HangeulManager {
    
    private func canBeDouble(a prev: Int, b input: Int) -> Bool {
        
        if status == .jungseong {
            
            let index = HG.compatible.midList.firstIndex(of: input) ?? 0
            let inputFixedUnicode = HG.fixed.mid.list[index]
            
            if HG.fixed.mid.double[prev]?[inputFixedUnicode] != nil {
                return true
            } else {
                return false
            }
        } else if status == .jongseong || status == .endCaseTwo {
            
            let index = HG.compatible.endList.firstIndex(of: input) ?? 0
            let inputFixedUnicode = HG.fixed.end.list[index]
            
            print(prev, inputFixedUnicode)
            if HG.fixed.end.double[prev]?[inputFixedUnicode] != nil {
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    private func bufferHasChoseong() -> Bool {
        return separatedBuffer.count > 1 ? true : false
    }
    
}

// MARK: - combinedBuffer에 있는 원소를 문자열로 만들어 반환

extension HangeulManager {
    func getOutputString() -> String {
        var output = ""
        for word in combinedBuffer {
            output += String(UnicodeScalar(word)!)
        }
        return output
    }
}
