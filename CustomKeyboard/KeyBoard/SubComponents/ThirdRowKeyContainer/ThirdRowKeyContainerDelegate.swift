//
//  ThirdRowKeyContainerDelegate.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/18.
//

import Foundation

protocol ThirdRowKeyContainerDelegate: AnyObject {
    func tappedShiftButton()
    func tappedBackButton()
    func tappedThirdrowBasicKey(unicode: Int)
}
