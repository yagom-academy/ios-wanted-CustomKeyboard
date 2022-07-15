//
//  FirstKeyBoardEngine.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/14.
//

import Foundation

struct FirstKeyBoardEngine: KeyBoardEngine {
    enum UniCode {
        case perfect(initial:Int, neutral:Int, support:Int)
        case perfectNoSupport(initial:Int, neutral:Int)
        case onlyInitial(value: Int)
        case onlyNeutral(value: Int)
    }
    
    func addWord(inputUniCode: Int, lastUniCode: Int) -> String {
        let parsedLastUnicode: UniCode = parsingUniCode(unicode: lastUniCode)
        let parsedInputUnicode:Int = inputUniCode - 12592
        switch parsedLastUnicode {
        case .perfect(let initial, let neutral, let support):
            return ""
        case .perfectNoSupport(let initial, let neutral):
            return ""
        case .onlyInitial(let value):
            return ""
        case .onlyNeutral(let value):
            return ""
        }
        return ""
    }
    
    func removeWord(lastUniCode: Int) -> String {
        return ""
    }
    
    private func parsingUniCode(unicode: Int) -> UniCode {
        if (unicode >= 44032) {
            let value:Int = unicode - 44032
            let initial:Int = Int(floor(Double(value / 21*28)))
            let neutral:Int = (value % 21*28) / 28
            let support:Int = value % 28
            if (support == 0) {
                return .perfectNoSupport(initial: initial, neutral: neutral)
            } else {
                return .perfect(initial: initial, neutral: neutral, support: support)
            }
        } else if (unicode <= 12622) {
            return .onlyInitial(value: unicode)
        } else {
            return .onlyNeutral(value: unicode)
        }
    }
    
    private func makeWord(initial: Int, neutral: Int, support: Int) -> Int {
        return 44032 + initial*21*28 + neutral*28 + support
    }
}
