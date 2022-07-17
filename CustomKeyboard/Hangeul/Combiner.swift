//
//  Combiner.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/15.
//

import Foundation

class Combiner {
    
    static let shared = Combiner()
    private init() { }
    
    func getWord(from characterList: ArraySlice<Hangeul>) -> String {
        let status = characterList.last?.getCombinationStatus()
        var word = ""
        
        switch status {
        case .start:
            <#code#>
        default:
            <#code#>
        }
        
        return word
    }
}
