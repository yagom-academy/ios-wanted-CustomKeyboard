//
//  CustomKeyBoardViewModel.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/14.
//

import Foundation
import UIKit

struct CustomKeyBoardViewModel {
    struct UniCode {
        var initial: Int
        var neutral: Int
        var final: Int
    }
    
    func addWord(unicode: Int, to beforeText: String?) -> String {
        let word = String(UnicodeScalar(unicode)!)
        guard let beforeText = beforeText else { return "" }
        return beforeText + word
    }
    
    func addSpace(unicode: Int, to beforeText: String?) -> String {
        let space = String(UnicodeScalar(unicode)!)
        guard let beforeText = beforeText else { return "" }
        return beforeText + space
    }
    
    func removeWord(from beforeText: String?) -> String {
        //TODO: 지우기버튼 구현
        guard let beforeText = beforeText else { return "" }
        let lastCharUnicode = getLastCharUnicode(from: beforeText)
        var result = getStringExceptLastChar(from: beforeText)
        
        if (lastCharUnicode >= 44032) {
            
        } else {
            
        }
        let image = UIImageView()
        image.layer.
        return result
    }
    
    private func separateUniCode(from unicode: Int) -> UniCode? {
        guard unicode >= 44032 else { return nil }
        let initial = (unicode - 44032) / (21*28)
    }
    
    private func getLastCharUnicode(from text: String) -> Int {
        let lastChar = String(text.last!)
        return Int(UnicodeScalar(lastChar)!.value)
    }
    
    private func getStringExceptLastChar(from text: String) -> String {
        let i = text.index(text.endIndex, offsetBy: -1)
        return String(text[text.startIndex..<i])
    }
    
    private func parsingLastWord(from text: String) {
        let lastCharUnicode = getLastCharUnicode(from: text)
        if (lastCharUnicode >= 44032) {
            print("완전언어", lastCharUnicode)
        } else {
            print("비완성언어", lastCharUnicode)
        }
    }
}
