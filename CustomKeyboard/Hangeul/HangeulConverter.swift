//
//  HangeulConverter.swift
//  CustomKeyboard
//
//  Created by hayeon on 2022/07/16.
//

import Foundation

final class HangeulConverter {
    
    func toUnicode(from string: String) -> Int {
        return Int(UnicodeScalar(string)!.value)
    }
    
    func toString(from unicode: Int) -> String {
        return String(UnicodeScalar(unicode)!)
    }
}
