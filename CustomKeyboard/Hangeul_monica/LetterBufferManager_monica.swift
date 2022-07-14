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
    
    func getLetterBuffer() -> [Int] {
        return letterBuffer
    }
    
    func update(_ new: Int, status: HG.Status, mode: HG.Mode) -> [Int] {
        if mode == .space {
            
        } else if mode == .back {
            
        } else {
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
                var prev = letterBuffer.removeLast()
                if isDouble(prev, .end) {
                    prev = getSplitPair(prev, .doubleEnd).last!
                }
                let newIndex = getIndex(of: new, .compatible, .mid)
                let char = getUnicode(of: newIndex, .fixed, .mid)
                let prevIndex = getIndex(of: prev, .compatible, .top)
                prev = getUnicode(of: prevIndex, .fixed, .top)
                letterBuffer = [prev, char]
            default:
                break
            }
        }
        return letterBuffer
    }
}
