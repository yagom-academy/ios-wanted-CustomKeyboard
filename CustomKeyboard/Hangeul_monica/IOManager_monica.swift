//
//  IOManager_monica.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/14.
//

import Foundation

class IOManager {
    
    static let shared = IOManager()
    private init() { }
    
    private var inputList : [Int] = []
    private let STManager = StatusManager.shared
    private let LBManager = LetterBufferManager.shared
    private let WLManager = WordListManager.shared
    
    func process(input letter: String) {
        
        if letter == "Back" && STManager.getStatus() == .start {
            return
        }
        
        print("===================================================")
        print("입력: \(letter)")
        switch letter {
        case "Back":
            let stat = STManager.getStatus()
            let hasTop = STManager.doesDoubleMidHaveTop()
            WLManager.update(hasTop, -1, stat, .back)
            forTestWord()
            let lastWord = WLManager.getWordList().last ?? -1
            LBManager.update(lastWord, stat, .back)
            forTestBuff()
            let buf = LBManager.getLetterBuffer()
            STManager.update(buf, -1, .back)
            forTestStat()
            setInput(-1, .back)
            break
        case "Space":
            STManager.update([], -1, .space)
            forTestStat()
            LBManager.update(-1, .space, .space)
            forTestBuff()
            WLManager.update(false, -1, .space, .space)
            break
        default:
            let new = toUnicode(from: letter)
            var buf = LBManager.getLetterBuffer()
            STManager.update(buf, new, .normal)
            forTestStat()
            let stat = STManager.getStatus()
            LBManager.update(new, stat, .normal)
            forTestBuff()
            buf = LBManager.getLetterBuffer()
            WLManager.update(buf.count > 1, buf.last!, stat, .normal)
            forTestWord()
            STManager.refresh(new)
            forTestStat()
            setInput(new, .normal)
        }
    }
    
    func reset() {
        STManager.close()
        LBManager.close()
        WLManager.close()
    }
    
    func getOutput() -> String {
        let wordList = WLManager.getWordList()
        var output = ""
        for word in wordList {
            if word == HG.SPACE {
                output += " "
            } else {
                output += String(UnicodeScalar(word)!)
            }
        }
        return output
    }
    
    private func setInput(_ input: Int, _ mode: HG.Mode) {
        switch mode {
        case .back:
            inputList.removeLast()
        default:
            inputList.append(input)
        }
    }
    
    private func forTestStat() {
        let stat = STManager.getStatus()
        print("상태: \(stat)")
    }
    
    private func forTestBuff() {
        let buff = LBManager.getLetterBuffer()
        print("버퍼: ")
        for ele in buff {
            print(String(UnicodeScalar(ele)!))
        }
    }

    private func forTestWord() {
        let word = WLManager.getWordList()
        print("낱말: ")
        for ele in word {
            if ele == HG.SPACE {
                print("| |")
            } else {
                print(String(UnicodeScalar(ele)!))
            }
        }
    }
    // 화면 사라질 때 이 output도 초기화되게 하기
}
