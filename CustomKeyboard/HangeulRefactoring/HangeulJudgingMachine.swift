//
//  HangeulJudgingMachine.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

enum HangeulUnicodeType {
    case none, fixed, compatible
}

class HangeulJudgingMachine {
    
    func isMid(unicode: Int) -> Bool {
        for hangeul in HangeulDictionary.compatible.mid.allCases {
            if hangeul.rawValue == unicode {
                return true
            }
        }
        return false
    }
    
    func isEnd(unicode: Int) -> Bool {
        for hangeul in HangeulDictionary.compatible.end.allCases {
            if hangeul.rawValue == unicode {
                return true
            }
        }
        return false
    }
    
    
    func isDoubleMid(unicode: Int) -> Bool {
        for hangeul in HangeulDictionary.compatible.doubleMid.allCases {
            if hangeul.rawValue == unicode {
                return true
            }
        }
        return false
    }
    
    deinit {
        print("close judgingMachine")
    }
}
