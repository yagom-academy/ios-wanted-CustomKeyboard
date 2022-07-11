//
//  Review.swift
//  CustomKeyboard
//
//  Created by rae on 2022/07/11.
//

import Foundation

struct ReviewList: Decodable {
    let data: [Review]
}

struct Review: Decodable {
    let user: User
    let content: String
    let createdAt: String
}

struct User: Decodable {
    let userName: String
    let profileImage: String
}
