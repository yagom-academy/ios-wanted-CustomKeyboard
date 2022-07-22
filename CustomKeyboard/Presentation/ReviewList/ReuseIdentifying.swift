//
//  ReuseIdentifying.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/20.
//

import Foundation

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
