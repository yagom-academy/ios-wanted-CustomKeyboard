//
//  Review.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/12.
//

import UIKit

// DTO : Data Transfer Object
struct ReviewData: Codable {
    let reviewData: [Review]

    enum CodingKeys: String, CodingKey {
        case reviewData = "data"
    }
}

struct Review: Codable {
    let user: User
    let content: String
    /// 2022-07-22T19:00:00.000Z
    let createdAt: String
    
    var date: Date? {
        let time = createdAt.replacingOccurrences(of: "T", with: " ")
            .components(separatedBy: ".")[0]
        return time.toDate()
    }
}

struct User: Codable {
    let userName: String
    let profileImage: String
}

struct Post: Codable {
    let content: String
}
