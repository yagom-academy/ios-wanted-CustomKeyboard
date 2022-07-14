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
    
    private let BACK = "Back", SPACE = "Space"
    
    private var inputList : [Int] = []
    private var output: String = ""
    private let STManager = StatusManager.shared
    private let LBManager = LetterBufferManager.shared
    private let WLManager = WordListManager.shared
    
    func process(input letter: String) {
        let new = toUnicode(from: letter)
        
        switch letter {
        case BACK:
            break
        case SPACE:
            break
        default:
            print("----------------------------------")
            var letterBuffer = LBManager.getLetterBuffer()
            let status = STManager.update(letterBuffer, new, mode: .normal)
            print("before status: \(status)")
            letterBuffer = LBManager.update(new, status: status, mode: .normal)
            print("letterBuffer: ")
            for ele in letterBuffer {
                print(String(UnicodeScalar(ele)!))
            }
            let wordList = WLManager.update(letterBuffer, new, status: status, mode: .normal)
            print("wordList: ")
            for ele in wordList {
                print(String(UnicodeScalar(ele)!))
            }
            STManager.refresh(new)
            setInput(new)
            setOutput(wordList)
        }
    }
    
    func reset() {
        STManager.close()
        LBManager.close()
        WLManager.close()
    }
    
    func getOutput() -> String {
        return output
    }
    
    func setOutput(_ wordList: [Int]) {
        var newOutput = ""
        for word in wordList {
            newOutput += String(UnicodeScalar(word)!)
        }
        self.output = newOutput
    }
    
    private func setInput(_ new: Int) {
        inputList.append(new)
    }
    
    // 화면 사라질 때 이 output도 초기화되게 하기
}
