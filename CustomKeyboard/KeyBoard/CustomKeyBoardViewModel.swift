//
//  CustomKeyBoardViewModel.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/14.
//

import Foundation

struct CustomKeyBoardViewModel {
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
}
