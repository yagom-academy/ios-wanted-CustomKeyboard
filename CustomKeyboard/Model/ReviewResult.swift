//
//  ReviewResult.swift
//  CustomKeyboard
//
//  Created by BH on 2022/07/19.
//

import Foundation

struct ReviewResult: Decodable {
    let user: User
    let content: String
    let createdAt: String
}
