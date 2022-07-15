//
//  KeyBoardEngine.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/14.
//

import Foundation

protocol KeyBoardEngine: Any {
    func addWord(inputUniCode: Int, lastUniCode: Int) -> String
    func removeWord(lastUniCode: Int) -> String
}
