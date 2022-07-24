//
//  ReviewType.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/12.
//

import Foundation

// MARK: - ReviewTypes
struct Reviews: Codable {
    var data: [Review]
}

// MARK: - ReviewType
struct Review: Codable {
    var id: String
    var user: User
    var content: String
    var createdAt: String
    var updatedAt: String
    
    enum CodingKeys: String , CodingKey {
        case id = "_id"
        case user, content, createdAt, updatedAt
        
    }
}
