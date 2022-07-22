//
//  CustomKeyBoardViewModel.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/14.
//

import UIKit

struct CustomKeyBoardStackViewViewModel {
    
    // MARK: - Properties
    private let engine: KeyBoardEngineProtocol
    
    init(engine: KeyBoardEngineProtocol) {
        self.engine = engine
    }
    
    func addWord(inputUniCode: Int, to beforeText: String?) -> String {
        
        guard let beforeText = beforeText,
              let unicodeScalar = UnicodeScalar(inputUniCode) else { return "" }
        let inputChar = String(unicodeScalar)
        guard let lastCharUnicode = getLastCharUnicode(from: beforeText),
              let beforeTextExceptLastChar = getStringExceptLastChar(from: beforeText) else { return inputChar }
        let lastChar = engine.addWord(inputUniCode: inputUniCode, lastUniCode: lastCharUnicode)
        return beforeTextExceptLastChar + lastChar
    }
    
    func addSpace(inputUniCode: Int = 32, to beforeText: String?) -> String {
        
        guard let beforeText = beforeText,
              let unicodeScalar = UnicodeScalar(inputUniCode) else { return "" }
        let space = String(unicodeScalar)
        return beforeText + space
    }
    
    func removeWord(from beforeText: String?) -> String {
        
        guard let beforeText = beforeText,
              let lastCharUnicode = getLastCharUnicode(from: beforeText),
              let beforeTextExceptLastChar = getStringExceptLastChar(from: beforeText) else { return "" }
        
        let lastChar = engine.removeWord(lastUniCode: lastCharUnicode)
        
        return beforeTextExceptLastChar + lastChar
    }
    //TODO: get지우기
    private func getLastCharUnicode(from text: String) -> Int? {
        
        guard text != "",
              let lastChar = text.last,
              let unicodeScalar = UnicodeScalar(String(lastChar)) else { return nil }
        return Int(unicodeScalar.value)
    }
    
    private func getStringExceptLastChar(from text: String) -> String? {
        
        guard text != "" else { return nil }
        let i = text.index(text.endIndex, offsetBy: -1)
        return String(text[text.startIndex..<i])
    }
}
