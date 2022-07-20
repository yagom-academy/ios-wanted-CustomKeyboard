//
//  ThirdRowKeyContainerDelegate.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/18.
//

import UIKit

protocol ThirdRowKeyContainerDelegate: AnyObject {
    func tappedShiftButton() -> Bool
    func tappedBackButton()
    func tappedThirdrowBasicKey(unicode: Int)
}
