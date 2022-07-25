//
//  getReviewModel.swift
//  CustomKeyboard
//
//  Created by dong eun shin on 2022/07/14.
//

import Foundation

struct ReviewListModel: Codable {
    let data: [Review]
}

// MARK: - review
struct Review: Codable {
    let user: User
    let content, createdAt: String
}

// MARK: - User
struct User: Codable {
    let userName: String
    let profileImage: String
}
