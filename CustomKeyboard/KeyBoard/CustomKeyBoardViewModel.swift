//
//  CustomKeyBoardViewModel.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/14.
//

import Foundation
import UIKit

struct CustomKeyBoardViewModel {
    private let engine: KeyBoardEngine
    
    init(engine: KeyBoardEngine) {
        self.engine = engine
    }
    
    func addWord(inputUniCode: Int, to beforeText: String?) -> String {
        guard let beforeText = beforeText else { return "" }
        let inputChar = String(UnicodeScalar(inputUniCode)!)
        guard let lastCharUnicode = getLastCharUnicode(from: beforeText),
              let beforeTextExceptLastChar = getStringExceptLastChar(from: beforeText) else { return inputChar }
        let lastChar = engine.addWord(inputUniCode: inputUniCode, lastUniCode: lastCharUnicode)
        return beforeTextExceptLastChar + lastChar
    }
    
    func addSpace(inputUniCode: Int = 32, to beforeText: String?) -> String {
        guard let beforeText = beforeText else { return "" }
        let space = String(UnicodeScalar(inputUniCode)!)
        return beforeText + space
    }
    
    func removeWord(from beforeText: String?) -> String {
        //TODO: 지우기버튼 구현
        guard let beforeText = beforeText else { return "" }
        guard let lastCharUnicode = getLastCharUnicode(from: beforeText),
              let beforeTextExceptLastChar = getStringExceptLastChar(from: beforeText) else { return "" }
        
        let lastChar = engine.removeWord(lastUniCode: lastCharUnicode)
        
        return beforeTextExceptLastChar + lastChar
    }
    
    // 맨마지막 단어 유니코드 추출
    func getLastCharUnicode(from text: String) -> Int? {
        guard text != "" else { return nil }
        let lastChar = String(text.last!)
        return Int(UnicodeScalar(lastChar)!.value)
    }
    
    // 맨마지막 단어를 뺀 문자열 반환
    func getStringExceptLastChar(from text: String) -> String? {
        guard text != "" else { return nil }
        let i = text.index(text.endIndex, offsetBy: -1)
        return String(text[text.startIndex..<i])
    }
}
