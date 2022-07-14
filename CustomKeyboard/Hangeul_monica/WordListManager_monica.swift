//
//  WordListManager_monica.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/14.
//

import Foundation

class WordListManager {
    
    static let shared = WordListManager()
    private init() { }
    
    private var wordList = [Int]()
    
    func close() {
        wordList = []
    }
    
    func update(_ buffer: [Int], _ new: Int, status: HG.Status, mode: HG.Mode) -> [Int] {
        var word : Int!
        let curr = buffer.last ?? 0
        
        if status != .finishPassOne && status != .top && !(status == .mid && !(buffer.count > 1)){
            let prev = wordList.removeLast()
            let char = getSplit(from: prev, status, mode)
            let top = char[0], mid = char[1], end = char[2]
            
            switch status {
            case .mid:
                word = getCombine(top, curr, HG.fixed.end.blank, false)
            case .end, .doubleEnd:
                word = getCombine(top, mid, curr, false)
            case .doubleMid:
                if buffer.count > 1 {
                    word = getCombine(top, curr, HG.fixed.end.blank, false)
                } else {
                    word = curr
                }
            case .finishPassTwo:
                if isDouble(end, .end) {
                    let splitEnd = getSplitPair(end, .doubleEnd)
                    word = getCombine(top, mid, splitEnd.first!, false)
                    wordList.append(word)
                    word = getCombine(splitEnd.last!, curr, HG.fixed.end.blank, true)
                } else {
                    word = getCombine(top, mid, HG.fixed.end.blank, false)
                    wordList.append(word)
                    word = getCombine(end, curr, HG.fixed.end.blank, true)
                }
            default:
                break
            }
        } else if status == .finishPassOne || status == .top {
            let tempStat: HG.Status = isMid(new, .compatible) ? .mid : .top
            let index = getIndex(of: new, .compatible, tempStat)
            word = getUnicode(of: index, .fixed, tempStat)
        } else {
            let index = getIndex(of: new, .compatible, .mid)
            word = getUnicode(of: index, .fixed, .mid)
        }
        wordList.append(word)
        return wordList
    }
}
