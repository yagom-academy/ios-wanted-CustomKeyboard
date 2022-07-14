//
//  LetterBufferManager_monica.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/14.
//

import Foundation

class LetterBufferManager {
    
    static let shared = LetterBufferManager()
    private init() { }
    
    private var letterBuffer = [Int]()
    
    func close() {
        letterBuffer = []
    }
    
    func update(_ input: Int, _ status: HG.Status, _ mode: HG.Mode) {
        if mode == .space {
            letterBuffer = []
        } else if mode == .back {
            updateWhenBack(input, status)
        } else {
            updateWhenNormal(input, status)
        }
    }
    
    func updateWhenBack(_ lastWord: Int, _ status: HG.Status) {
        let blank = HG.fixed.end.blank
        
        if letterBuffer.isEmpty {
            switch status {
            case .finishPassOne:
                letterBuffer = getSplit(from: lastWord, .finishPassOne, .normal)
            case .finishPassTwo:
                let char = getSplit(from: lastWord, .finishPassTwo, .normal)
                if char.last! == blank {
                    letterBuffer = [char[0], char[1]]
                } else {
                    letterBuffer = char
                }
            default:
                break
            }
        } else {
            let lastLetter = letterBuffer.removeLast()
            switch status {
            case .top:
                if lastWord > 0 {
                    let char = getSplit(from: lastWord, .top, .back)
                    if char.last! == blank {
                        letterBuffer = [char[0], char[1]]
                    } else {
                        letterBuffer = char
                    }
                }
            case .end:
                let char = getSplit(from: lastWord, .end, .back)
                letterBuffer = [char[0], char[1]]
            case .doubleMid:
                if isMid(lastWord, .fixed) {
                    letterBuffer.append(lastWord)
                } else {
                    let char = getSplit(from: lastWord, .doubleMid, .back)
                    letterBuffer = [char[0], char[1]]
                }
            case .doubleEnd:
                print("lastletter: \(String(UnicodeScalar(lastLetter)!))")
                let char = getSplitPair(lastLetter, .doubleEnd)
                letterBuffer.append(char.first!)
            default:
                break
            }
        }
    }
    
    
    func updateWhenNormal(_ new: Int, _ status: HG.Status) {
        let charKind: HG.Kind = isMid(new, .compatible) ? .vowel : .consonant
        
        switch status {
        case .top, .mid, .end:
            let index = getIndex(of: new, .compatible, status)
            let char = getUnicode(of: index, .fixed, status)
            letterBuffer.append(char)
        case .doubleMid, .doubleEnd:
            let index = getIndex(of: new, .compatible, status)
            let curr = getUnicode(of: index, .fixed, status)
            let prev = letterBuffer.removeLast()
            let char = getDouble(prev, curr, status)
            letterBuffer.append(char)
        case .finishPassOne:
            var tempStat: HG.Status = .top
            if charKind == .vowel {
                tempStat = .mid
            }
            let index = getIndex(of: new, .compatible, tempStat)
            let char = getUnicode(of: index, .fixed, tempStat)
            letterBuffer = [char]
        case .finishPassTwo:
            var prev = letterBuffer.removeLast() // ㅈ
            if isDouble(prev, .end) {
                prev = getSplitPair(prev, .doubleEnd).last!
            }
            let newIndex = getIndex(of: new, .compatible, .mid)
            let char = getUnicode(of: newIndex, .fixed, .mid)
            // 지금 end에서 인덱스 구하고
            var prevIndex = getIndex(of: prev, .fixed, .end)
            // 그 인덱스로 compatible 값 구하고
            let compatible = getUnicode(of: prevIndex, .compatible, .end)
            prevIndex = getIndex(of: compatible, .compatible, .top)
            prev = getUnicode(of: prevIndex, .fixed, .top)
            letterBuffer = [prev, char]
        default:
            break
        }
    }
    
    func getLetterBuffer() -> [Int] {
        return letterBuffer
    }
}
