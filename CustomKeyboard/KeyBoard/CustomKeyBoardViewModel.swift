//
//  CustomKeyBoardViewModel.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/14.
//

import UIKit

struct CustomKeyBoardViewModel {
    
    // MARK: - Properties
    private let engine: KeyBoardEngineProtocol
    
    init(engine: KeyBoardEngineProtocol) {
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
        
        guard let beforeText = beforeText else { return "" }
        guard let lastCharUnicode = getLastCharUnicode(from: beforeText),
              let beforeTextExceptLastChar = getStringExceptLastChar(from: beforeText) else { return "" }
        
        let lastChar = engine.removeWord(lastUniCode: lastCharUnicode)
        
        return beforeTextExceptLastChar + lastChar
    }
    
    private func getLastCharUnicode(from text: String) -> Int? {
        
        guard text != "" else { return nil }
        let lastChar = String(text.last!)
        return Int(UnicodeScalar(lastChar)!.value)
    }
    
    private func getStringExceptLastChar(from text: String) -> String? {
        
        guard text != "" else { return nil }
        let i = text.index(text.endIndex, offsetBy: -1)
        return String(text[text.startIndex..<i])
    }
}
