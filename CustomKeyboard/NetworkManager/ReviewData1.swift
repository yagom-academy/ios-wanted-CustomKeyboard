//
//  ReviewData1.swift
//  CustomKeyboard
//
//  Created by 효우 on 2022/07/16.
//

import Foundation

struct Data1: Codable {
    let data: [ReviewData1]
}

struct ReviewData1: Codable {
    let user: User1
    let content: String
    let createdAt: String
}

struct User1: Codable {
    let userName: String
    let profileImage: String
}
