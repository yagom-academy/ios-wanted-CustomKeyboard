//
//  FirthRowKeyContainerDelegate.swift
//  CustomKeyboard
//
//  Created by 김기림 on 2022/07/18.
//

import Foundation

protocol FirthRowKeyContainerStackViewDelegate:AnyObject {
    func tappedSpaceButton(_ inputUniCode: Int)
    func tappedReturnButton()
}
