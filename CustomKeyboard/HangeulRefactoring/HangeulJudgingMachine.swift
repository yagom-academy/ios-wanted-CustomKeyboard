//
//  HangeulJudgingMachine.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

enum HangeulUnicodeType {
    case fixed, compatible
}

class HangeulJudgingMachine {
    
    func isMid(unicode: Int, unicodeType: HangeulUnicodeType) -> Bool {
        
        switch unicodeType {
        case .fixed:
            for hangeul in HangeulDictionary.fixed.mid.allCases {
                if hangeul.rawValue == unicode {
                    return true
                }
            }
        case .compatible:
            for hangeul in HangeulDictionary.compatible.mid.allCases {
                if hangeul.rawValue == unicode {
                    return true
                }
            }
        }
        return false
    }
    
    func isEnd(unicode: Int, unicodeType: HangeulUnicodeType) -> Bool {
        
        switch unicodeType {
        case .fixed:
            for hangeul in HangeulDictionary.fixed.end.allCases {
                if hangeul.rawValue == unicode {
                    return true
                }
            }
        case .compatible:
            for hangeul in HangeulDictionary.compatible.end.allCases {
                if hangeul.rawValue == unicode {
                    return true
                }
            }
        }
        return false
    }
    
    
    func isDoubleMid(unicode: Int, unicodeType: HangeulUnicodeType) -> Bool {
        switch unicodeType {
        case .fixed:
            for hangeul in HangeulDictionary.fixed.doubleMid.allCases {
                if hangeul.rawValue == unicode {
                    return true
                }
            }
        case .compatible:
            for hangeul in HangeulDictionary.compatible.doubleMid.allCases {
                if hangeul.rawValue == unicode {
                    return true
                }
            }
        }
        return false
    }
    
    deinit {
        print("close judgingMachine")
    }
}
