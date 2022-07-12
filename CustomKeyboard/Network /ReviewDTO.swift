//
//  ReviewDTO.swift
//  CustomKeyboard
//
//  Created by Kai Kim on 2022/07/11.
//

import Foundation

struct ReviewResponse: Codable {
  let data: [ReviewDTO]
}

// MARK: - Review
struct ReviewDTO: Codable {
    let id: String
    let user: User
    let content, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case user, content, createdAt, updatedAt
    }
}

// MARK: - User
struct User: Codable {
    let id: String
    let userName: String
    let profileImage: URL

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userName, profileImage
    }
}
