//
//  UnicodeManger.swift
//  CustomKeyboard
//
//  Created by 장주명 on 2022/07/21.
//

import Foundation

protocol UnicodeManger {
    func addChar(_ unitcode : Int,_ inputChar : Int) -> String
    func removeChar(_ unitcode : Int) -> String
}
