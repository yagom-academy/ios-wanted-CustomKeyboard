//
//  Character+Extension.swift
//  CustomKeyboard
//
//  Created by 이윤주 on 2022/07/23.
//

import Foundation

extension Character {

    func unicodeScalarCodePoint() -> UInt32 {
        let unicodeScalars = self.unicodeScalars

        return unicodeScalars[unicodeScalars.startIndex].value
    }

}
