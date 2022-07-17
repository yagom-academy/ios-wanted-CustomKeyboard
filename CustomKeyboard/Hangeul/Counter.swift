//
//  Counter.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/15.
//

import Foundation

class Counter {
    
    static let shared = Counter()
    private init() { }
    
    func checkNumberForCombination(of lastStatus: HG.CombinationStatus) -> Int {
        switch lastStatus {
        case .top, .midOnly:
            return 1
        case .midWithTop, .doubleMidOnly:
            return 2
        case .doubleMidWithTop, .endWithMid:
            return 3
        case .endWithDoubleMid, .doubleEndWithMid:
            return 4
        case .doubleEndWithDoubleMid:
            return 5
        default:
            return 0
        }
    }
}
