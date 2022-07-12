//
//  ReviewType.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/12.
//

import Foundation

struct ReviewTypes: Codable {
    var data: [ReviewType]
}

struct ReviewType: Codable {
    var _id: String
    var user: User
    var content: String
    var createdAt: String
    var updatedAt: String
}

struct User: Codable {
    var _id: String
    var isAdmin: String
    var profileImage: String
    var userName: String
}
