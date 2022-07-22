//
//  Collection+Custom.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/22.
//

import Foundation

//TODO: COllection, Subscribe, indices 공부
extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
