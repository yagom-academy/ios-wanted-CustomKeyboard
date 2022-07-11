//
//  CellIdentifiable.swift
//  CustomKeyboard
//
//  Created by yc on 2022/07/11.
//

import Foundation

protocol CellIdentifiable {
    static var identifier: String { get }
}

extension CellIdentifiable {
    static var identifier: String { String(describing: Self.self) }
}
