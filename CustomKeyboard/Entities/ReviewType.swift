//
//  ReviewType.swift
//  CustomKeyboard
//
//  Created by oyat on 2022/07/12.
//

import Foundation

// MARK: - ReviewTypes
struct ReviewTypes: Codable {
    var data: [ReviewType]
}

// MARK: - ReviewType
struct ReviewType: Codable {
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
