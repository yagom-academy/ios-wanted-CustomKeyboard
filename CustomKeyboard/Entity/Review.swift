//
//  Review.swift
//  CustomKeyboard
//
//  Created by Mac on 2022/07/12.
//

import UIKit

struct Review: Codable {
    let user: User
    let content: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case user, content, createdAt
    }
}

struct User: Codable {
    let userName: String
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case userName, profileImage
    }
}
