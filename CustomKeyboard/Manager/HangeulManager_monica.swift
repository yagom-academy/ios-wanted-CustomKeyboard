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
    private var status: HG.Status = .start
    private var statusStack: [HG.Status] = [.start]
    let BACK = -1
    let NORMAL = 1
}

// MARK: - 문자 입력시 호출

extension HangeulManager {
    func update(_ inputString: String) {
        var input: Int!
        
        if inputString == "Back" {
            if status == .start {
                return
            } else {
                updateCombinedBuffer(BACK)
                updateSeparatedBuffer(BACK)
                updateStatus(BACK)
            }
        } else {
            input = Int(UnicodeScalar(inputString)!.value)
            updateStatus(input)
            updateSeparatedBuffer(input)
            updateCombinedBuffer(input)
            refreshStatus()
        }
        
        print("=====================================")
        print("상태스택: \(statusStack)")
        print("상태: \(status)")
        print("입력: \(inputString)")
        print("separatedBuffer:")
        for ele in separatedBuffer {
            print(String(UnicodeScalar(ele)!))
        }
        print("combinedBuffer:")
        for ele in combinedBuffer {
            print(String(UnicodeScalar(ele)!))
        }
    }
}


// MARK: - 문자 조합 상태 결정

extension HangeulManager {

    private func refreshStatus() {
        switch status {
        case .finishPassOne:
            if HG.fixed.mid.list.contains(separatedBuffer.last!) {
                setStatus(.mid)
            } else {
                setStatus(.top)
            }
        case .finishPassTwo:
            setStatus(.mid)
        default:
            break
        }
    }
    
    private func updateStatus(_ input: Int) {
        if input == BACK {
            statusStack.removeLast()
            status = statusStack.last ?? .start
        } else {
            let charKind: HG.Kind = HG.compatible.midList.contains(input) ? .vowel : .consonant
//            print("    seperatedBuffer:")
//            for ele in separatedBuffer {
//                print("    \(String(UnicodeScalar(ele)!))")
//            }
            let prev = separatedBuffer.last ?? 0
//            print("    prev: \(String(UnicodeScalar(prev)!))")
            switch status {
            case .start:
                if charKind == .consonant {
                    setStatus(.top)
                } else {
                    setStatus(.mid)
                }
            case .top:
                if charKind == .vowel {
                    setStatus(.mid)
                } else {
                    status = .finishPassOne
                }
            case .mid:
                if bufferHasChoseong() && HG.compatible.endList.contains(input) {
                    setStatus(.end)
                } else if canBeDouble(a: prev, b: input) {
                    setStatus(.doubleMid)
                } else {
                    status = .finishPassOne
                }
            case .doubleMid:
                if bufferHasChoseong() && HG.compatible.endList.contains(input) {
                    setStatus(.end)
                } else {
                    status = .finishPassOne
                }
            case .end:
                if canBeDouble(a: prev, b: input) {
                    setStatus(.doubleEnd)
                } else if charKind == .vowel {
                    status = .finishPassTwo
                    statusStack.removeLast()
                    statusStack.append(.top)
                } else {
                    status = .finishPassOne
                }
            case .doubleEnd:
                if charKind == .vowel {
                    status = .finishPassTwo
                    statusStack.removeLast()
                    statusStack.append(.end)
                    statusStack.append(.top)
                } else {
                    status = .finishPassOne
                }
            default:
                break
            }
        }
       
    }
}

// MARK: - separatedBuffer에 문자 추가/삭제

extension HangeulManager {
    private func updateSeparatedBuffer(_ input: Int) {
        
        if input == BACK {
            if separatedBuffer.isEmpty {
                switch status {
                case .finishPassOne:
                    let last = combinedBuffer.last ?? 0
                    separatedBuffer = getSeparatedCharacters(from: last, mode: NORMAL)
                case .finishPassTwo:
                    let last = combinedBuffer.last ?? 0
                    let char = getSeparatedCharacters(from: last, mode: NORMAL)
                    if char[2] == HG.fixed.end.blank {
                        separatedBuffer = [char[0], char[1]]
                    } else {
                        separatedBuffer = char
                    }
                default:
                    break
                }
            } else {
                let last = separatedBuffer.removeLast()
                let prevWord = combinedBuffer.last ?? 0
                switch status {
                case .top:
                    if statusStack[statusStack.count - 2] != .start {
                        separatedBuffer.append(prevWord)
                    }
                case .mid:
                    if HG.fixed.top.list.contains(prevWord) {
                        separatedBuffer.append(prevWord)
                    }
                case .end:
                    let char = getSeparatedCharacters(from: prevWord, mode: BACK)
                    separatedBuffer = char
                case .doubleMid:
                    if HG.fixed.mid.list.contains(prevWord) {
                        separatedBuffer.append(prevWord)
                    } else {
                        let char = getSeparatedCharacters(from: prevWord, mode: BACK)
                        separatedBuffer = [char[0], char[1]]
                    }
                case .doubleEnd:
                    separatedBuffer.append(HG.fixed.end.split[last]?.first ?? 0)
                default:
                    break
                }
            }
            
            
            
        } else {
            let charKind: HG.Kind = HG.compatible.midList.contains(input) ? .vowel : .consonant
            
            switch status {
            case .top:
                let index = HG.compatible.topList.firstIndex(of: input) ?? 0
                let char = HG.fixed.top.list[index]
                separatedBuffer.append(char)
            case .mid:
                let index = HG.compatible.midList.firstIndex(of: input) ?? 0
                let char = HG.fixed.mid.list[index]
                separatedBuffer.append(char)
            case .end:
                let index = HG.compatible.endList.firstIndex(of: input) ?? 0
                let char = HG.fixed.end.list[index]
                separatedBuffer.append(char)
            case .doubleMid:
                let index = HG.compatible.midList.firstIndex(of: input) ?? 0
                let curr = HG.fixed.mid.list[index]
                let prev = separatedBuffer.removeLast()
                let char = HG.fixed.mid.double[prev]?[curr] ?? 0
                separatedBuffer.append(char)
            case .doubleEnd:
                let index = HG.compatible.endList.firstIndex(of: input) ?? 0
                let curr = HG.fixed.end.list[index]
                let prev = separatedBuffer.removeLast()
                let char = HG.fixed.end.double[prev]?[curr] ?? 0
                separatedBuffer.append(char)
            case .finishPassOne:
                if charKind == .vowel {
                    let index = HG.compatible.midList.firstIndex(of: input) ?? 0
                    let char = HG.fixed.mid.list[index]
                    separatedBuffer = [char]
                } else {
                    let index = HG.compatible.topList.firstIndex(of: input) ?? 0
                    let char = HG.fixed.top.list[index]
                    separatedBuffer = [char]
                }
            case .finishPassTwo:
                let prev = separatedBuffer.removeLast()
                let index = HG.compatible.midList.firstIndex(of: input) ?? 0
                let char = HG.fixed.mid.list[index]
                separatedBuffer = [prev, char]
            default:
                break
            }
        }
        
        
        
    }
}

// MARK: - combinedBuffer에 문자 추가/삭제

extension HangeulManager {
    private func updateCombinedBuffer(_ input: Int) {
        var word : Int!
        let curr = separatedBuffer.last ?? 0
        
        if input == BACK {
            let prevWord = combinedBuffer.removeLast()
            
            switch status {
            case .mid:
                let char = getSeparatedCharacters(from: prevWord, mode: BACK)
                combinedBuffer.append(char[0])
            case .end:
                let char = getSeparatedCharacters(from: prevWord, mode: BACK)
                word = getCombinedWord(char[0], char[1], HG.fixed.end.blank, isDouble: false)
                combinedBuffer.append(word)
            case .doubleMid:
                if statusStack.count > 2 && statusStack[statusStack.count - 3] == .top {
                    let char = getSeparatedCharacters(from: prevWord, mode: BACK)
                    let splitChar = HG.fixed.mid.split[char[1]]
                    word = getCombinedWord(char[0], splitChar?[0] ?? 0, HG.fixed.end.blank, isDouble: false)
                    combinedBuffer.append(word)
                } else {
                    let char = HG.fixed.mid.split[prevWord]
                    combinedBuffer.append(char?[0] ?? 0)
                }
            case .doubleEnd:
                let char = HG.fixed.end.split[prevWord]
                combinedBuffer.append(char?[0] ?? 0)
            default:
                break
            }
            
        } else {
            if status != .finishPassOne && status != .top && !(status == .mid && !bufferHasChoseong()){
//                print("상태: \(status), bufferHasChoseong: \(bufferHasChoseong())")
                let prevWord = combinedBuffer.removeLast()
                let char = getSeparatedCharacters(from: prevWord, mode: NORMAL)
    //            print("------setCombinedBuffer")
    //            for ele in char {
    //                print(String(UnicodeScalar(ele)!))
    //            }
                switch status {
                case .mid:
                    word = getCombinedWord(char[0], curr, HG.fixed.end.blank, isDouble: false)
                case .end:
                    word = getCombinedWord(char[0], char[1], curr, isDouble: false)
                case .doubleMid:
                    if bufferHasChoseong() {
                        word = getCombinedWord(char[0], curr, HG.fixed.end.blank, isDouble: false)
                    } else {
                        word = curr
                    }
                case .doubleEnd:
                    word = getCombinedWord(char[0], char[1], curr, isDouble: false)
                case .finishPassTwo:
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
            } else if status == .finishPassOne || status == .top {
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
}



// MARK: - 프로퍼티 초기화

extension HangeulManager {
    func reset() {
        self.separatedBuffer = []
        self.combinedBuffer = []
        self.status = .start
        self.statusStack = [.start]
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
            if status == .finishPassTwo {
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
    func getSeparatedCharacters(from word: Int, mode: Int) -> [Int] {
        
        if status == .mid && mode == NORMAL {
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
        print(String(UnicodeScalar(prev)!), String(UnicodeScalar(input)!))
        if status == .mid {
            if HG.compatible.midList.contains(input) {
                let index = HG.compatible.midList.firstIndex(of: input) ?? 0
                let inputFixedUnicode = HG.fixed.mid.list[index]
                
                if HG.fixed.mid.double[prev]?[inputFixedUnicode] != nil {
                    return true
                } else {
                    return false
                }
            }
        } else if status == .end || status == .finishPassTwo {
            
            let index = HG.compatible.endList.firstIndex(of: input) ?? 0
            let inputFixedUnicode = HG.fixed.end.list[index]
            
            if HG.fixed.end.double[prev]?[inputFixedUnicode] != nil {
                return true
            } else {
                return false
            }
        }
        return false
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


// MARK: - status 설정 및 statusStack에 status 추가

extension HangeulManager {
    private func setStatus(_ status: HG.Status) {
        self.status = status
        statusStack.append(status)
    }
}
