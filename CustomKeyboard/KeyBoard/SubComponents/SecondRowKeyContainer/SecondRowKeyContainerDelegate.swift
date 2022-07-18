//
//  SecondRowKeyContainerDelegate.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/18.
//

import Foundation

protocol SecondRowKeyContainerDelegate: AnyObject {
    func tappedSecondrowBasicKey(unicode: Int)
}
