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
    
    func update(_ hasTop: Bool, _ new: Int, _ status: HG.Status, _ mode: HG.Mode) {
        switch mode {
        case .normal:
            updateWhenNormal(hasTop, new, status)
        case .back:
            updateWhenBack(hasTop, new, status)
        case .space:
            wordList.append(HG.SPACE)
        }
    }
    
    private func updateWhenBack(_ hasTop: Bool, _ new: Int, _ status: HG.Status) {
        let prev = wordList.removeLast()
        let blank = HG.fixed.end.blank
        
        switch status {
        case .mid:
            if !isMid(prev, .fixed) {
                let char = getSplit(from: prev, .mid, .back)
                wordList.append(char.first!)
            }
        case .end:
            let char = getSplit(from: prev, .end, .back)
            let word = getCombine(char[0], char[1], blank, false)
            wordList.append(word)
        case .doubleMid:
            if hasTop {
                let char = getSplit(from: prev, .mid, .back)
                let splitChar = getSplitPair(char[1], .doubleMid)
                let word = getCombine(char.first!, splitChar.first!, blank, false)
                wordList.append(word)
            } else {
                let splitChar = getSplitPair(prev, .doubleMid)
                wordList.append(splitChar.first!)
            }
        case .doubleEnd:
            let char = getSplit(from: prev, .doubleEnd, .back)
            let splitChar = getSplitPair(char.last!, .doubleEnd)
            let word = getCombine(char.first!, char[1], splitChar.first!, false)
            wordList.append(word)
        default:
            break
        }
    }
    
    
    
    private func updateWhenNormal(_ hasTop: Bool, _ new: Int, _ status: HG.Status) {
        var word = new
        
        if status != .finishPassOne && status != .top && !(status == .mid && !hasTop){
            let prev = wordList.removeLast()
            let char = getSplit(from: prev, status, .normal)
            let top = char[0], mid = char[1], end = char[2]
            
            switch status {
            case .mid:
                word = getCombine(top, new, HG.fixed.end.blank, false)
            case .end, .doubleEnd:
                word = getCombine(top, mid, new, false)
            case .doubleMid:
                if hasTop {
                    word = getCombine(top, new, HG.fixed.end.blank, false)
                }
            case .finishPassTwo:
                if isDouble(end, .end) {
                    let splitEnd = getSplitPair(end, .doubleEnd)
                    word = getCombine(top, mid, splitEnd.first!, false)
                    wordList.append(word)
                    word = getCombine(splitEnd.last!, new, HG.fixed.end.blank, true)
                } else {
                    word = getCombine(top, mid, HG.fixed.end.blank, false)
                    wordList.append(word)
                    word = getCombine(end, new, HG.fixed.end.blank, true)
                }
            default:
                break
            }
        }
        wordList.append(word)
    }
    
    func getWordList() -> [Int] {
        return wordList
    }
}

