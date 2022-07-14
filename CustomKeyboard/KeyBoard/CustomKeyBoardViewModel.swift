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
        return beforeText
    }
    
    // 맨마지막 단어 유니코드 추출
    private func getLastCharUnicode(from text: String) -> Int {
        let lastChar = String(text.last!)
        return Int(UnicodeScalar(lastChar)!.value)
    }
    
    // 맨마지막 단어를 뺀 문자열 반환
    private func getStringExceptLastChar(from text: String) -> String {
        let i = text.index(text.endIndex, offsetBy: -1)
        return String(text[text.startIndex..<i])
    }
}
