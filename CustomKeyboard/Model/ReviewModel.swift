//
//  ReviewModel.swift
//  CustomKeyboard
//
//  Created by JunHwan Kim on 2022/07/11.
//

import Foundation

struct ReviewList: Codable {
    let data: [ReviewModel]
}

struct ReviewModel: Codable {
    let user: User
    let content, createdAt: String
}

struct User: Codable {
    let profileImage: String
    let userName: String
}
